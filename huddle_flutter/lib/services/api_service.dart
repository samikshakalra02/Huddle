import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:huddle_client/huddle_client.dart';
import '../client.dart';
import '../data/fake_data.dart';
import 'tech_domain_validator.dart';

/// Centralized API service for Huddle that safely manages server connectivity,
/// seamless offline demo fallbacks, and live Serverpod RPC communication.
/// Prevents unhandled connection refused errors and WebSocket storming when
/// Serverpod has not yet been started.
class ApiService {
  static final ApiService instance = ApiService._();

  ApiService._();

  final ValueNotifier<bool> isServerAvailable = ValueNotifier<bool>(false);
  DateTime? _lastConnectionAttempt;
  static const Duration _cooldown = Duration(seconds: 20);

  /// Checks if Serverpod is responsive at the configured host.
  /// Uses a 20-second cooldown on automatic checks to avoid spamming the network,
  /// but can be forced via [force] (e.g. on pull-to-refresh or explicit user retry).
  Future<bool> checkConnection({bool force = false}) async {
    final now = DateTime.now();
    if (!force &&
        _lastConnectionAttempt != null &&
        now.difference(_lastConnectionAttempt!) < _cooldown) {
      return isServerAvailable.value;
    }

    _lastConnectionAttempt = now;

    try {
      // Lightweight feed probe with a quick 1.5s timeout
      await client.feed.get().timeout(const Duration(milliseconds: 1500));
      isServerAvailable.value = true;
      return true;
    } catch (_) {
      isServerAvailable.value = false;
      return false;
    }
  }

  /// Fetches campus feed (reels + events).
  /// If the server is offline or unreachable, returns [FakeData] immediately.
  Future<FeedResponse> getFeed({bool forceRefresh = false}) async {
    if (forceRefresh) {
      await checkConnection(force: true);
    }

    if (!isServerAvailable.value) {
      return FeedResponse(
        reels: FakeData.reels,
        events: FakeData.events,
      );
    }

    try {
      final feed = await client.feed.get();
      return FeedResponse(
        reels: feed.reels.isNotEmpty ? feed.reels : FakeData.reels,
        events: feed.events.isNotEmpty ? feed.events : FakeData.events,
      );
    } catch (_) {
      isServerAvailable.value = false;
      return FeedResponse(
        reels: FakeData.reels,
        events: FakeData.events,
      );
    }
  }

  /// Suggests study squads based on topic, exam, and time slot.
  Future<List<SquadSuggestion>> suggestSquads({
    required String topic,
    String exam = 'Placements',
    String timeSlot = '6:00 - 8:00 PM',
  }) async {
    if (!isServerAvailable.value) {
      return FakeData.squadSuggestions;
    }

    try {
      final res = await client.squad.suggest(
        topic: topic.isEmpty ? 'DSA' : topic,
        exam: exam,
        timeSlot: timeSlot,
      );
      return res.isNotEmpty ? res : FakeData.squadSuggestions;
    } catch (_) {
      isServerAvailable.value = false;
      return FakeData.squadSuggestions;
    }
  }

  /// Retrieves live details for a squad room.
  Future<SquadDetails> getSquad({required int squadId}) async {
    if (!isServerAvailable.value) {
      return SquadDetails(
        squad: FakeData.squadSuggestions.first.squad,
        members: FakeData.roomMembers,
        recentMessages: FakeData.roomMessages,
      );
    }

    try {
      final details = await client.squad.getSquad(squadId: squadId);
      if (details != null) {
        return details;
      }
    } catch (_) {
      isServerAvailable.value = false;
    }

    return SquadDetails(
      squad: FakeData.squadSuggestions.first.squad,
      members: FakeData.roomMembers,
      recentMessages: FakeData.roomMessages,
    );
  }

  /// Submits quiz answers. When offline, scores locally without making a network call.
  Future<QuizResult> submitQuiz({
    required int reelId,
    required List<int> selectedAnswers,
    required Reel reel,
  }) async {
    if (!isServerAvailable.value) {
      return _evaluateQuizLocally(reel, selectedAnswers);
    }

    try {
      return await client.reel.submitQuiz(
        reelId: reelId,
        selectedAnswers: selectedAnswers,
      );
    } catch (_) {
      isServerAvailable.value = false;
      return _evaluateQuizLocally(reel, selectedAnswers);
    }
  }

  QuizResult _evaluateQuizLocally(Reel reel, List<int> selectedAnswers) {
    int score = 0;
    final questions = reel.quizQuestions;
    for (var i = 0; i < questions.length && i < selectedAnswers.length; i++) {
      if (selectedAnswers[i] == questions[i].correctOptionIndex) {
        score++;
      }
    }
    final total = questions.length;
    final passed = total > 0 && (score >= (total * 0.6));
    final feedback = passed
        ? 'Great job! You mastered this concept.'
        : 'Keep practicing! Join a squad to study ${reel.suggestedSquadTopic} together.';

    return QuizResult(
      score: score,
      totalQuestions: total,
      passed: passed,
      suggestedSquadTopic: reel.suggestedSquadTopic,
      feedback: feedback,
    );
  }

  /// Evaluates reel content with ML classifier before uploading.
  Future<ReelValidationResult> validateReel({
    required String title,
    required String subject,
    required String content,
  }) async {
    if (!isServerAvailable.value) {
      return TechDomainValidator.validateContent(
        title: title,
        subject: subject,
        content: content,
      );
    }

    try {
      return await client.reel.validateReel(
        title: title,
        subject: subject,
        content: content,
      );
    } catch (_) {
      return TechDomainValidator.validateContent(
        title: title,
        subject: subject,
        content: content,
      );
    }
  }

  /// Uploads a new peer reel after server ML validation.
  Future<ReelValidationResult> uploadReel({
    required Reel reel,
    required String content,
  }) async {
    if (!isServerAvailable.value) {
      final res = TechDomainValidator.validateContent(
        title: reel.title,
        subject: reel.subject,
        content: content,
        reel: reel,
      );
      if (res.isValid) {
        final assignedReel = reel.copyWith(
          id: FakeData.reels.length + 100,
        );
        FakeData.reels.insert(0, assignedReel);
        return ReelValidationResult(
          isValid: true,
          isTechDomain: true,
          confidenceScore: res.confidenceScore,
          detectedDomain: res.detectedDomain,
          technicalKeywords: res.technicalKeywords,
          reason: res.reason,
          validatedReel: assignedReel,
        );
      }
      return res;
    }

    try {
      final res = await client.reel.uploadReel(
        reel: reel,
        content: content,
      );
      if (res.isValid && res.validatedReel != null) {
        FakeData.reels.insert(0, res.validatedReel!);
      }
      return res;
    } catch (_) {
      final res = TechDomainValidator.validateContent(
        title: reel.title,
        subject: reel.subject,
        content: content,
        reel: reel,
      );
      if (res.isValid) {
        final assignedReel = reel.copyWith(
          id: FakeData.reels.length + 100,
        );
        FakeData.reels.insert(0, assignedReel);
        return ReelValidationResult(
          isValid: true,
          isTechDomain: true,
          confidenceScore: res.confidenceScore,
          detectedDomain: res.detectedDomain,
          technicalKeywords: res.technicalKeywords,
          reason: res.reason,
          validatedReel: assignedReel,
        );
      }
      return res;
    }
  }

  /// Joins a squad.
  Future<void> joinSquad({
    required int squadId,
    required String userName,
  }) async {
    if (!isServerAvailable.value) return;
    try {
      await client.squad.join(squadId: squadId, userName: userName);
    } catch (_) {
      isServerAvailable.value = false;
    }
  }

  /// Starts synchronized Pomodoro timer in a squad room.
  Future<void> startTimer({
    required int squadId,
    int durationSeconds = 1500,
  }) async {
    if (!isServerAvailable.value) return;
    try {
      await client.squad.startTimer(
        squadId: squadId,
        durationSeconds: durationSeconds,
      );
    } catch (_) {
      isServerAvailable.value = false;
    }
  }

  /// Updates focus presence in a squad room.
  Future<void> updatePresence({
    required int squadId,
    required String userName,
    required bool isFocusing,
  }) async {
    if (!isServerAvailable.value) return;
    try {
      await client.squad.updatePresence(
        squadId: squadId,
        userName: userName,
        isFocusing: isFocusing,
      );
    } catch (_) {
      isServerAvailable.value = false;
    }
  }

  /// Sends a chat message to a squad room.
  Future<void> sendChat({
    required int squadId,
    required String userName,
    required String message,
  }) async {
    if (!isServerAvailable.value) return;
    try {
      await client.squad.sendChat(
        squadId: squadId,
        userName: userName,
        message: message,
      );
    } catch (_) {
      isServerAvailable.value = false;
    }
  }

  /// Subscribes to real-time events for a squad room.
  /// If the server is offline, returns null to avoid opening a doomed WebSocket.
  Stream<SquadRoomEvent>? getSquadRoomStream(int squadId) {
    if (!isServerAvailable.value) return null;
    try {
      return client.squad.room(squadId);
    } catch (_) {
      isServerAvailable.value = false;
      return null;
    }
  }

  /// Retrieves student personas for the campus directory.
  Future<List<StudentPersona>> getPersonas() async {
    if (!isServerAvailable.value) {
      return FakeData.personas;
    }

    try {
      final list = await client.profile.getPersonas();
      return list.isNotEmpty ? list : FakeData.personas;
    } catch (_) {
      isServerAvailable.value = false;
      return FakeData.personas;
    }
  }

  /// Endorses a student persona.
  Future<StudentPersona?> endorsePersona({
    required String targetName,
    required String tag,
    required String quote,
    required String authorName,
  }) async {
    if (!isServerAvailable.value) return null;
    try {
      return await client.profile.endorsePersona(
        targetName: targetName,
        tag: tag,
        quote: quote,
        authorName: authorName,
      );
    } catch (_) {
      isServerAvailable.value = false;
      return null;
    }
  }

  /// Updates a student persona's study goal sprint.
  Future<StudentPersona?> updateGoal({
    required String name,
    required String newGoal,
  }) async {
    if (!isServerAvailable.value) return null;
    try {
      return await client.profile.updateGoal(
        name: name,
        newGoal: newGoal,
      );
    } catch (_) {
      isServerAvailable.value = false;
      return null;
    }
  }
}
