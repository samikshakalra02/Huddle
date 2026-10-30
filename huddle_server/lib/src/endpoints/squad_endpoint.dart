import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../seed.dart';

class SquadEndpoint extends Endpoint {
  /// Streaming endpoint: provides live chat, presence, and timer events between squad members.
  Stream<SquadRoomEvent> room(Session session, int squadId) async* {
    await Seed.seedIfNeeded(session);


    // 1. Initial snapshot so client has full state immediately on connection
    final squad = await Squad.db.findById(session, squadId);
    final members = await SquadMember.db.find(
      session,
      where: (t) => t.squadId.equals(squadId),
      orderBy: (t) => t.joinedAt,
    );

    yield SquadRoomEvent(
      squadId: squadId,
      type: 'sync',
      squad: squad,
      members: members,
      timestamp: DateTime.now().toUtc(),
    );

    // 2. Stream real-time events over Serverpod message channel
    final channel = 'squad_$squadId';
    final stream = session.messages.createStream<SquadRoomEvent>(channel);
    await for (final event in stream) {
      yield event;
    }
  }

  /// Sends a chat message in the squad room, persists it, and broadcasts to listeners.
  Future<SquadChatMessage> sendChat(
    Session session, {
    required int squadId,
    required String userName,
    required String message,
  }) async {
    await Seed.seedIfNeeded(session);

    final chatMsg = await SquadChatMessage.db.insertRow(
      session,
      SquadChatMessage(
        squadId: squadId,
        userName: userName,
        message: message,
        sentAt: DateTime.now().toUtc(),
      ),
    );

    // Broadcast chat event to streaming channel
    await session.messages.postMessage(
      'squad_$squadId',
      SquadRoomEvent(
        squadId: squadId,
        type: 'chat',
        userName: userName,
        message: message,
        timestamp: DateTime.now().toUtc(),
      ),
    );

    return chatMsg;
  }

  /// Updates a member's focus presence and broadcasts updated status.
  Future<SquadMember> updatePresence(
    Session session, {
    required int squadId,
    required String userName,
    required bool isFocusing,
  }) async {
    await Seed.seedIfNeeded(session);

    final member = await SquadMember.db.findFirstRow(
      session,
      where: (t) => t.squadId.equals(squadId) & t.userName.equals(userName),
    );

    if (member == null) {
      throw ArgumentError('Member $userName not found in squad $squadId');
    }

    final updated = member.copyWith(isFocusing: isFocusing);
    await SquadMember.db.updateRow(session, updated);

    final allMembers = await SquadMember.db.find(
      session,
      where: (t) => t.squadId.equals(squadId),
      orderBy: (t) => t.joinedAt,
    );

    await session.messages.postMessage(
      'squad_$squadId',
      SquadRoomEvent(
        squadId: squadId,
        type: 'presence',
        userName: userName,
        message: isFocusing
            ? '$userName started focusing'
            : '$userName took a break',
        members: allMembers,
        timestamp: DateTime.now().toUtc(),
      ),
    );

    return updated;
  }

  /// Suggests squads scored by topic, time slot, and target exam with a "why you matched" explanation.
  Future<List<SquadSuggestion>> suggest(
    Session session, {
    required String topic,
    String? exam,
    String? timeSlot,
  }) async {
    await Seed.seedIfNeeded(session);

    final allSquads = await Squad.db.find(
      session,
      orderBy: (t) => t.streak.desc(),
    );

    final suggestions = <SquadSuggestion>[];

    for (final squad in allSquads) {
      final members = await SquadMember.db.find(
        session,
        where: (t) => t.squadId.equals(squad.id!),
      );

      // 1. Topic Match (0-40)
      int topicScore = 15;
      final cleanTopic = topic.trim().toLowerCase();
      final squadTopic = squad.topic.toLowerCase();
      final squadName = squad.name.toLowerCase();

      final matchesTopic =
          cleanTopic.isNotEmpty &&
          (squadTopic.contains(cleanTopic) ||
              cleanTopic.contains(squadTopic) ||
              squadName.contains(cleanTopic));

      if (matchesTopic) {
        topicScore = 40;
      } else {
        final words = cleanTopic.split(RegExp(r'\s+'));
        if (words.any((w) => w.length > 2 && squadTopic.contains(w))) {
          topicScore = 28;
        }
      }

      // 2. Target Exam Match (0-30)
      int examScore = 20;
      final cleanExam = exam?.trim().toLowerCase();
      if (cleanExam != null && cleanExam.isNotEmpty) {
        if (squad.targetExam.toLowerCase().contains(cleanExam) ||
            cleanExam.contains(squad.targetExam.toLowerCase())) {
          examScore = 30;
        } else {
          examScore = 10;
        }
      }

      // 3. Time Slot Match (0-30)
      int timeScore = 20;
      final cleanTime = timeSlot?.trim().toLowerCase();
      if (cleanTime != null && cleanTime.isNotEmpty) {
        if (squad.timeSlot.toLowerCase().contains(cleanTime) ||
            cleanTime.contains(squad.timeSlot.toLowerCase())) {
          timeScore = 30;
        } else {
          timeScore = 10;
        }
      }

      final rawScore = topicScore + examScore + timeScore;
      final matchScore = rawScore.clamp(65, 98);

      // Generate "Why you matched" line
      final reasons = <String>[];
      if (topicScore >= 28) {
        reasons.add('Same ${squad.topic} focus');
      } else {
        reasons.add('${squad.topic} crew');
      }

      if (examScore >= 25 && exam != null && exam.isNotEmpty) {
        reasons.add('${squad.targetExam} target');
      } else {
        reasons.add('${squad.targetExam} prep');
      }

      if (timeScore >= 25 && timeSlot != null && timeSlot.isNotEmpty) {
        reasons.add('${squad.timeSlot} free');
      } else {
        reasons.add(squad.timeSlot);
      }

      final matchReason = reasons.join(' · ');

      suggestions.add(
        SquadSuggestion(
          squad: squad,
          matchScore: matchScore,
          matchReason: matchReason,
          memberCount: members.length,
        ),
      );
    }

    // Sort descending by matchScore
    suggestions.sort((a, b) => b.matchScore.compareTo(a.matchScore));
    return suggestions;
  }

  /// Adds a user to a squad or returns their existing membership.
  Future<SquadMember> join(
    Session session, {
    required int squadId,
    required String userName,
    String? avatarUrl,
  }) async {
    await Seed.seedIfNeeded(session);

    final squad = await Squad.db.findById(session, squadId);
    if (squad == null) {
      throw ArgumentError('Squad with id $squadId not found');
    }

    // Check if user is already a member
    final existing = await SquadMember.db.findFirstRow(
      session,
      where: (t) => t.squadId.equals(squadId) & t.userName.equals(userName),
    );

    if (existing != null) {
      return existing;
    }

    // Check member cap
    final currentCount = await SquadMember.db.count(
      session,
      where: (t) => t.squadId.equals(squadId),
    );

    if (currentCount >= squad.maxMembers) {
      throw StateError(
        'Squad is at full capacity (${squad.maxMembers} members)',
      );
    }

    final newMember = await SquadMember.db.insertRow(
      session,
      SquadMember(
        squadId: squadId,
        userName: userName,
        avatarUrl: avatarUrl,
        isFocusing: true,
        karma: 4.8,
        joinedAt: DateTime.now().toUtc(),
      ),
    );

    // Notify room channel if listeners exist
    await session.messages.postMessage(
      'squad_$squadId',
      SquadRoomEvent(
        squadId: squadId,
        type: 'presence',
        userName: userName,
        message: '$userName joined the squad',
        squad: squad,
        timestamp: DateTime.now().toUtc(),
      ),
    );

    return newMember;
  }

  /// Server owns the clock: sets the start time and focus duration in database.
  Future<Squad> startTimer(
    Session session, {
    required int squadId,
    int? durationSeconds,
  }) async {
    await Seed.seedIfNeeded(session);

    final squad = await Squad.db.findById(session, squadId);
    if (squad == null) {
      throw ArgumentError('Squad with id $squadId not found');
    }

    final duration = durationSeconds ?? 1500; // 25 minutes default
    final updatedSquad = squad.copyWith(
      timerStartedAt: DateTime.now().toUtc(),
      timerDurationSeconds: duration,
      isFocusing: true,
    );

    await Squad.db.updateRow(session, updatedSquad);

    // Post to squad room message channel for real-time sync
    await session.messages.postMessage(
      'squad_$squadId',
      SquadRoomEvent(
        squadId: squadId,
        type: 'timer',
        userName: null,
        message: 'Timer started for ${duration ~/ 60} minutes',
        squad: updatedSquad,
        timestamp: DateTime.now().toUtc(),
      ),
    );

    return updatedSquad;
  }

  /// Fallback: 2-second polling endpoint. Fetches squad, members, and recent chat messages.
  Future<SquadDetails?> getSquad(
    Session session, {
    required int squadId,
  }) async {
    await Seed.seedIfNeeded(session);

    final squad = await Squad.db.findById(session, squadId);
    if (squad == null) return null;

    final members = await SquadMember.db.find(
      session,
      where: (t) => t.squadId.equals(squadId),
      orderBy: (t) => t.joinedAt,
    );

    final recentMessages = await SquadChatMessage.db.find(
      session,
      where: (t) => t.squadId.equals(squadId),
      orderBy: (t) => t.sentAt,
      limit: 50,
    );

    return SquadDetails(
      squad: squad,
      members: members,
      recentMessages: recentMessages,
    );
  }

  /// Lists all squads.
  Future<List<Squad>> list(Session session) async {
    await Seed.seedIfNeeded(session);
    return Squad.db.find(session, orderBy: (t) => t.id);
  }
}
