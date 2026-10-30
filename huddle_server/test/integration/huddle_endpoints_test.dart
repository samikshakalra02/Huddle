// ignore_for_file: avoid_print
import 'dart:async';
import 'package:test/test.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Huddle Endpoints', (sessionBuilder, endpoints) {
    test('1. feed.get: returns reels and events', () async {
      final feed = await endpoints.feed.get(sessionBuilder);

      print('\n================ [1. feed.get OUTPUT] ================');
      print('Total Reels: ${feed.reels.length}');
      for (final r in feed.reels) {
        print('  ▶ Reel: "${r.title}" by ${r.creatorName} [${r.subject}]');
        print('    Video URL: ${r.videoUrl}');
        print(
          '    Questions: ${r.quizQuestions.length} questions | Suggested Squad: "${r.suggestedSquadTopic}"',
        );
      }
      print('Total Campus Events: ${feed.events.length}');
      for (final e in feed.events) {
        print('  📅 Event: "${e.title}" organized by ${e.organizer}');
        print(
          '    Venue: ${e.venue} | Tag: #${e.tag} | Time: ${e.eventTime.toIso8601String()}',
        );
      }

      expect(feed.reels, isNotEmpty);
      expect(feed.events, isNotEmpty);
      expect(feed.reels.length, greaterThanOrEqualTo(3));
      expect(feed.events.length, greaterThanOrEqualTo(3));
    });

    test('2. reel.submitQuiz: evaluates quiz and suggests squad topic', () async {
      final feed = await endpoints.feed.get(sessionBuilder);
      final reel = feed.reels.first;

      // Submit all correct answers
      final result1 = await endpoints.reel.submitQuiz(
        sessionBuilder,
        reelId: reel.id!,
        selectedAnswers: [1, 1, 1],
      );

      print(
        '\n================ [2. reel.submitQuiz (Perfect Score)] ================',
      );
      print(
        'Score: ${result1.score}/${result1.totalQuestions} (Passed: ${result1.passed})',
      );
      print('Feedback: ${result1.feedback}');
      print('Suggested Squad Topic: "${result1.suggestedSquadTopic}"');

      // Submit low score
      final result2 = await endpoints.reel.submitQuiz(
        sessionBuilder,
        reelId: reel.id!,
        selectedAnswers: [0, 0, 0],
      );

      print(
        '\n================ [2. reel.submitQuiz (Low Score / Need Help)] ================',
      );
      print(
        'Score: ${result2.score}/${result2.totalQuestions} (Passed: ${result2.passed})',
      );
      print('Feedback: ${result2.feedback}');
      print('Auto-suggested Squad Topic: "${result2.suggestedSquadTopic}"');

      expect(result1.score, 3);
      expect(result1.passed, isTrue);
      expect(result2.score, 0);
      expect(result2.passed, isFalse);
    });

    test(
      '3. squad.suggest: ranks candidates with "why you matched" explanation',
      () async {
        print('\n================ [3. squad.suggest OUTPUT] ================');
        print(
          'Searching squads for: Topic="DBMS", TargetExam="Midterms", TimeSlot="4:00 PM - 6:00 PM"',
        );

        final suggestions = await endpoints.squad.suggest(
          sessionBuilder,
          topic: 'DBMS',
          exam: 'Midterms',
          timeSlot: '4:00 PM - 6:00 PM',
        );

        for (var i = 0; i < suggestions.length; i++) {
          final s = suggestions[i];
          print(
            '  #${i + 1} Squad: "${s.squad.name}" (Streak: ${s.squad.streak} days, Members: ${s.memberCount}/${s.squad.maxMembers})',
          );
          print('     🎯 Match Score: ${s.matchScore}%');
          print('     💡 Why You Matched: "${s.matchReason}"');
          print(
            '     📌 Squad Goal: ${s.squad.goal} (${s.squad.currentGoalCount} completed)',
          );
        }

        expect(suggestions, isNotEmpty);
        expect(suggestions.first.squad.topic, contains('DBMS'));
        expect(suggestions.first.matchScore, greaterThan(80));
      },
    );

    test('4. squad.join: adds student to squad with karma and avatar', () async {
      final squads = await endpoints.squad.list(sessionBuilder);
      final squad = squads.first;

      final member = await endpoints.squad.join(
        sessionBuilder,
        squadId: squad.id!,
        userName: 'Aisha R.',
      );

      print('\n================ [4. squad.join OUTPUT] ================');
      print('Joined Squad: "${squad.name}" (ID: ${squad.id})');
      print('  Member Name: ${member.userName}');
      print('  Member ID: ${member.id}');
      print('  Karma Rating: ${member.karma} ⭐');
      print(
        '  Focusing Status: ${member.isFocusing ? "Currently in focus mode" : "In break"}',
      );
      print('  Joined At: ${member.joinedAt.toIso8601String()}');

      expect(member.userName, 'Aisha R.');
    });

    test(
      '5. squad.startTimer: server stores start time (server owns the timer)',
      () async {
        final squads = await endpoints.squad.list(sessionBuilder);
        final squad = squads.first;

        final updated = await endpoints.squad.startTimer(
          sessionBuilder,
          squadId: squad.id!,
          durationSeconds: 1500, // 25-minute Pomodoro
        );

        final now = DateTime.now().toUtc();
        final elapsedSeconds = now
            .difference(updated.timerStartedAt!)
            .inSeconds;
        final remainingSeconds = updated.timerDurationSeconds - elapsedSeconds;

        print(
          '\n================ [5. squad.startTimer OUTPUT] ================',
        );
        print('Squad: "${updated.name}"');
        print(
          'Server Timer Started At: ${updated.timerStartedAt!.toIso8601String()}',
        );
        print(
          'Focus Duration: ${updated.timerDurationSeconds ~/ 60} minutes (${updated.timerDurationSeconds} seconds)',
        );
        print('Is Focusing: ${updated.isFocusing}');
        print(
          'Client-computed Remaining Time: ${remainingSeconds ~/ 60}m ${remainingSeconds % 60}s',
        );

        expect(updated.timerStartedAt, isNotNull);
        expect(updated.timerDurationSeconds, 1500);
        expect(updated.isFocusing, isTrue);
      },
    );

    test(
      '6. squad.room: streaming endpoint provides live sync, chat, presence, timer events',
      () async {
        final squads = await endpoints.squad.list(sessionBuilder);
        final squad = squads.first;
        final squadId = squad.id!;

        print(
          '\n================ [6. squad.room (Streaming Endpoint)] ================',
        );

        // Subscribe to squad.room stream
        final roomStream = endpoints.squad.room(sessionBuilder, squadId);
        final receivedEvents = <dynamic>[];
        final completer = Completer<void>();

        final sub = roomStream.listen((event) {
          receivedEvents.add(event);
          print('  ⚡ Stream Received Event: [type: ${event.type}]');
          if (event.type == 'sync') {
            print(
              '     Sync: Squad "${event.squad?.name}", Members: ${event.members?.length}',
            );
          } else if (event.type == 'chat') {
            print('     Chat: "${event.userName}": "${event.message}"');
          } else if (event.type == 'presence') {
            print('     Presence: ${event.message}');
          } else if (event.type == 'timer') {
            print(
              '     Timer: ${event.message} | Duration: ${event.squad?.timerDurationSeconds}s',
            );
          }

          if (receivedEvents.length >= 4 && !completer.isCompleted) {
            completer.complete();
          }
        });

        // 1. Wait briefly for initial 'sync' snapshot
        await Future.delayed(const Duration(milliseconds: 50));

        // 2. Trigger Chat Event
        await endpoints.squad.sendChat(
          sessionBuilder,
          squadId: squadId,
          userName: 'Ayaan',
          message: 'Ready for the 25-minute focus sprint!',
        );

        // 3. Trigger Presence Event
        await endpoints.squad.updatePresence(
          sessionBuilder,
          squadId: squadId,
          userName: 'Ayaan',
          isFocusing: true,
        );

        // 4. Trigger Timer Event
        await endpoints.squad.startTimer(
          sessionBuilder,
          squadId: squadId,
          durationSeconds: 1500,
        );

        await completer.future.timeout(const Duration(seconds: 3));
        await sub.cancel();

        expect(receivedEvents.length, greaterThanOrEqualTo(4));
        expect(receivedEvents.any((e) => e.type == 'sync'), isTrue);
        expect(receivedEvents.any((e) => e.type == 'chat'), isTrue);
        expect(receivedEvents.any((e) => e.type == 'presence'), isTrue);
        expect(receivedEvents.any((e) => e.type == 'timer'), isTrue);
      },
    );

    test(
      '7. 2s polling fallback: squad.getSquad returns squad, members and recent chat messages',
      () async {
        final squads = await endpoints.squad.list(sessionBuilder);
        final squad = squads.first;

        await endpoints.squad.sendChat(
          sessionBuilder,
          squadId: squad.id!,
          userName: 'Ayaan',
          message: 'Checking 2s polling chat sync',
        );

        final details = await endpoints.squad.getSquad(
          sessionBuilder,
          squadId: squad.id!,
        );

        print(
          '\n================ [7. 2s Polling Fallback (squad.getSquad)] ================',
        );
        print(
          'Squad Name: "${details!.squad.name}" (Streak: ${details.squad.streak} days)',
        );
        print('Members (${details.members.length}):');
        for (final m in details.members) {
          print(
            '  - ${m.userName} | Karma: ${m.karma} | Focusing: ${m.isFocusing}',
          );
        }
        print('Recent Chat Messages (${details.recentMessages?.length ?? 0}):');
        for (final msg in details.recentMessages ?? []) {
          print(
            '  - [${msg.userName}]: ${msg.message} (${msg.sentAt.toIso8601String()})',
          );
        }
        print(
          '==========================================================================\n',
        );

        expect(details, isNotNull);
        expect(details.squad.id, squad.id);
        expect(details.members, isNotEmpty);
        expect(details.recentMessages, isNotEmpty);
      },
    );
  });
}
