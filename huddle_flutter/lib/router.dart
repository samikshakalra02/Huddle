import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/landing_screen.dart';
import 'ui/screens/login_screen.dart';
import 'ui/screens/main_shell.dart';
import 'ui/screens/profile_screen.dart';
import 'ui/screens/reel_screen.dart';
import 'ui/screens/squad_match_screen.dart';
import 'ui/screens/squad_room_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/login',
  routes: [
    // Web Landing Page
    GoRoute(
      path: '/',
      builder: (context, state) => const LandingScreen(),
    ),

    // Modern Gen Z Login Screen
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),

    // App Navigation Shell
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(
          path: '/feed',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomeScreen(),
          ),
        ),
        GoRoute(
          path: '/reels/:id',
          pageBuilder: (context, state) {
            final idStr = state.pathParameters['id'] ?? '1';
            final id = int.tryParse(idStr) ?? 1;
            return NoTransitionPage(
              child: ReelScreen(initialReelId: id),
            );
          },
        ),
        GoRoute(
          path: '/match',
          pageBuilder: (context, state) {
            final topic = state.uri.queryParameters['topic'] ?? 'DSA';
            return NoTransitionPage(
              child: SquadMatchScreen(topic: topic),
            );
          },
        ),
        GoRoute(
          path: '/room/:id',
          pageBuilder: (context, state) {
            final idStr = state.pathParameters['id'] ?? '1';
            final id = int.tryParse(idStr) ?? 1;
            return NoTransitionPage(
              child: SquadRoomScreen(squadId: id),
            );
          },
        ),
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ProfileScreen(),
          ),
        ),
      ],
    ),
  ],
);
