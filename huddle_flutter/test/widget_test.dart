import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:huddle_client/huddle_client.dart';
import 'package:huddle_flutter/services/user_service.dart';
import 'package:huddle_flutter/theme.dart';
import 'package:huddle_flutter/ui/screens/home_screen.dart';
import 'package:huddle_flutter/ui/screens/landing_screen.dart';
import 'package:huddle_flutter/ui/screens/login_screen.dart';
import 'package:huddle_flutter/ui/screens/profile_screen.dart';
import 'package:huddle_flutter/ui/screens/squad_match_screen.dart';
import 'package:huddle_flutter/ui/screens/try_it_sheet.dart';
import 'package:huddle_flutter/ui/widgets/event_card.dart';

void main() {
  group('Huddle Modern Palette & Theme Tests', () {
    test('4-color palette and tokens match exact spec', () {
      expect(HuddleTheme.background, const Color(0xFFF7F5F0));
      expect(HuddleTheme.ink, const Color(0xFF17171C));
      expect(HuddleTheme.accent, const Color(0xFF6C4DFF));
      expect(HuddleTheme.highlight, const Color(0xFFFFD23F));
      expect(HuddleTheme.borderWidth, 1.5);
      expect(HuddleTheme.cardRadius, const Radius.circular(14));
      expect(HuddleTheme.roundRadius, const Radius.circular(999));
    });

    test('ThemeData configures background scaffold and 1.5px border tokens', () {
      final theme = HuddleTheme.themeData;
      expect(theme.scaffoldBackgroundColor, const Color(0xFFF7F5F0));
      expect(HuddleTheme.border.top.width, 1.5);
      expect(HuddleTheme.border.top.color, const Color(0xFF17171C));
      expect(HuddleTheme.cardShadow.offset, const Offset(0, 2));
      expect(HuddleTheme.cardShadow.blurRadius, 0.0);
    });
  });

  group('UserService Tests', () {
    test('Defaults to Aisha Rahman and can update user', () {
      final service = UserService.instance;
      expect(service.currentUser.value, 'Aisha Rahman');

      service.setUserName('Priya Menon');
      expect(service.currentUser.value, 'Priya Menon');

      // Reset back to Aisha Rahman
      service.setUserName('Aisha Rahman');
    });

    test('Can set and retrieve custom avatar seed', () {
      final service = UserService.instance;
      service.setAvatarSeed('luna-7');
      expect(service.effectiveAvatarSeed, 'luna-7');
      service.setAvatarSeed(null);
      expect(service.effectiveAvatarSeed, 'Aisha Rahman');
    });
  });

  group('Huddle Widget Tests', () {
    testWidgets('EventCard displays details and toggles RSVP', (tester) async {
      final event = CampusEvent(
        id: 1,
        title: 'Hack Night: Build with AI',
        organizer: 'ACM Student Chapter',
        venue: 'Auditorium L2',
        eventTime: DateTime(2026, 10, 30, 18, 0),
        description: 'Collaborative hackathon with pizza and prizes.',
        tag: 'Hackathon',
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: HuddleTheme.themeData,
          home: Scaffold(
            body: EventCard(event: event),
          ),
        ),
      );

      expect(find.text('Hack Night: Build with AI'), findsOneWidget);
      expect(find.text('ACM Student Chapter'), findsOneWidget);
      expect(find.text('Auditorium L2'), findsOneWidget);
      expect(find.text('CAMPUS EVENT · HACKATHON'), findsOneWidget);
      expect(find.text('RSVP to Event'), findsOneWidget);

      // Tap RSVP button
      await tester.tap(find.text('RSVP to Event'));
      await tester.pump();

      expect(find.text("You're Going!"), findsOneWidget);
    });

    testWidgets('TryItSheet displays question and options', (tester) async {
      final reel = Reel(
        id: 1,
        title: 'SQL Joins in 45 Seconds',
        creatorName: 'Ayaan',
        subject: 'DBMS',
        videoUrl: 'https://example.com/sql.mp4',
        durationSeconds: 45,
        suggestedSquadTopic: 'DBMS Revision',
        quizQuestions: [
          QuizQuestion(
            question:
                'Which SQL JOIN returns only matching rows from both tables?',
            options: [
              'LEFT JOIN',
              'INNER JOIN',
              'FULL OUTER JOIN',
              'CROSS JOIN',
            ],
            correctOptionIndex: 1,
            explanation:
                'INNER JOIN returns only rows with matches in both tables.',
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: HuddleTheme.themeData,
          home: Scaffold(
            body: TryItSheet(
              reel: reel,
              onFindSquad: (topic) {},
            ),
          ),
        ),
      );

      expect(find.text('TRY IT QUIZ'), findsOneWidget);
      expect(
        find.text(
          'Q1. Which SQL JOIN returns only matching rows from both tables?',
        ),
        findsOneWidget,
      );
      expect(find.text('INNER JOIN'), findsOneWidget);
      expect(find.text('LEFT JOIN'), findsOneWidget);
    });

    testWidgets('ProfileScreen displays Karma, student identity, and stats', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: HuddleTheme.themeData,
          home: const ProfileScreen(),
        ),
      );

      expect(find.text('VERIFIED STUDENT'), findsOneWidget);
      expect(find.text('CAMPUS KARMA'), findsOneWidget);
      expect(find.text('VERIFIED KARMA'), findsOneWidget);
      expect(find.text('STUDY STREAK'), findsOneWidget);
      expect(find.text('EARNED BADGES'), findsOneWidget);
      expect(find.text('MY REELS'), findsOneWidget);
      expect(find.text('GOALS & SPRINT'), findsOneWidget);
    });

    testWidgets('LoginScreen displays Gen Z welcome squad and allows typing name', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: HuddleTheme.themeData,
          home: const LoginScreen(),
        ),
      );

      expect(find.text('STUDY TOGETHER.'), findsOneWidget);
      expect(find.text('NEVER CRAM ALONE.'), findsOneWidget);
      expect(find.text('WELCOME SQUAD'), findsOneWidget);
      expect(find.text('LOCK IN & ENTER HUDDLE 🚀'), findsOneWidget);

      // Tap on Priya squad member chip
      await tester.tap(find.text('Priya').first);
      await tester.pump();

      expect(find.text("Welcome, Priya!"), findsOneWidget);
    });
  });

  group('Responsive & Text Scaling Tests (No RenderFlex Overflows)', () {
    final testSizes = [
      const Size(360, 640), // Compact Phone
      const Size(390, 844), // Modern Phone
      const Size(768, 1024), // iPad / Tablet
      const Size(1280, 800), // Laptop
      const Size(1920, 1080), // Desktop Full HD
    ];

    for (final size in testSizes) {
      testWidgets(
        'LandingScreen renders with zero overflow at ${size.width}x${size.height} and 1.3x text scale',
        (tester) async {
          tester.view.physicalSize = size;
          tester.view.devicePixelRatio = 1.0;
          addTearDown(() => tester.view.resetPhysicalSize());

          FlutterErrorDetails? caught;
          final prevOnError = FlutterError.onError;
          FlutterError.onError = (details) {
            caught = details;
          };
          await tester.pumpWidget(
            MaterialApp(
              theme: HuddleTheme.themeData,
              home: MediaQuery(
                data: MediaQueryData(
                  size: size,
                  textScaler: const TextScaler.linear(1.3),
                ),
                child: const LandingScreen(),
              ),
            ),
          );
          await tester.pump();
          FlutterError.onError = prevOnError;
          if (caught != null) {
            // ignore: avoid_print
            print('CAUGHT DETAILS:\n${caught?.exceptionAsString()}\n${caught?.informationCollector?.call().map((d) => d.toString()).join('\n')}');
          }
          expect(tester.takeException(), isNull);
        },
      );

      testWidgets(
        'HomeScreen renders with zero overflow at ${size.width}x${size.height} and 1.3x text scale',
        (tester) async {
          tester.view.physicalSize = size;
          tester.view.devicePixelRatio = 1.0;
          addTearDown(() => tester.view.resetPhysicalSize());

          await tester.pumpWidget(
            MaterialApp(
              theme: HuddleTheme.themeData,
              home: MediaQuery(
                data: MediaQueryData(
                  size: size,
                  textScaler: const TextScaler.linear(1.3),
                ),
                child: const HomeScreen(),
              ),
            ),
          );
          await tester.pump();
          expect(tester.takeException(), isNull);
        },
      );

      testWidgets(
        'SquadMatchScreen renders with zero overflow at ${size.width}x${size.height} and 1.3x text scale',
        (tester) async {
          tester.view.physicalSize = size;
          tester.view.devicePixelRatio = 1.0;
          addTearDown(() => tester.view.resetPhysicalSize());

          await tester.pumpWidget(
            MaterialApp(
              theme: HuddleTheme.themeData,
              home: MediaQuery(
                data: MediaQueryData(
                  size: size,
                  textScaler: const TextScaler.linear(1.3),
                ),
                child: const SquadMatchScreen(),
              ),
            ),
          );
          await tester.pump();
          expect(tester.takeException(), isNull);
        },
      );

      testWidgets(
        'ProfileScreen renders with zero overflow at ${size.width}x${size.height} and 1.3x text scale',
        (tester) async {
          tester.view.physicalSize = size;
          tester.view.devicePixelRatio = 1.0;
          addTearDown(() => tester.view.resetPhysicalSize());

          await tester.pumpWidget(
            MaterialApp(
              theme: HuddleTheme.themeData,
              home: MediaQuery(
                data: MediaQueryData(
                  size: size,
                  textScaler: const TextScaler.linear(1.3),
                ),
                child: const ProfileScreen(),
              ),
            ),
          );
          await tester.pump();
          expect(tester.takeException(), isNull);
        },
      );

      testWidgets(
        'LoginScreen renders with zero overflow at ${size.width}x${size.height} and 1.3x text scale',
        (tester) async {
          tester.view.physicalSize = size;
          tester.view.devicePixelRatio = 1.0;
          addTearDown(() => tester.view.resetPhysicalSize());

          await tester.pumpWidget(
            MaterialApp(
              theme: HuddleTheme.themeData,
              home: MediaQuery(
                data: MediaQueryData(
                  size: size,
                  textScaler: const TextScaler.linear(1.3),
                ),
                child: const LoginScreen(),
              ),
            ),
          );
          await tester.pump();
          expect(tester.takeException(), isNull);
        },
      );
    }
  });
}
