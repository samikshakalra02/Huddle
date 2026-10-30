import 'package:flutter/foundation.dart';
import 'package:huddle_client/huddle_client.dart';
import '../data/fake_data.dart';
import 'api_service.dart';

/// Neon UI Cartoon Character Personas / Vibes
enum AvatarVibe {
  lofiCoder, // Headphones + focused smile
  starScholar, // Star sunglasses + sparkle cheek
  lateNightCram, // Beanie + warm hoodie
  aiPioneer, // Wire specs + cyber teal collar
  campusCheer, // Joyful arc eyes + star clip
  cyberVisor, // Futuristic neon HUD visor
  neonNeko, // Glowing cat ears + anime mouth
  gamerPro, // Headset + mic + wink
}

class UserService {
  static final UserService instance = UserService._();
  UserService._() {
    _init();
  }

  final ValueNotifier<StudentPersona> currentPersona =
      ValueNotifier<StudentPersona>(FakeData.personas.first);

  final ValueNotifier<String> currentUser = ValueNotifier<String>(
    FakeData.personas.first.name,
  );

  final ValueNotifier<String?> customAvatarSeed = ValueNotifier<String?>(null);

  final ValueNotifier<AvatarVibe> activeVibe = ValueNotifier<AvatarVibe>(
    AvatarVibe.lofiCoder,
  );

  final ValueNotifier<String> activeNeonColor = ValueNotifier<String>(
    'violet',
  ); // 'violet', 'teal', 'pink', 'volt', 'yellow'

  String get effectiveAvatarSeed => customAvatarSeed.value ?? currentUser.value;

  void setAvatarSeed(String? seed) {
    customAvatarSeed.value = seed;
  }

  void setAvatarVibe(AvatarVibe vibe) {
    activeVibe.value = vibe;
  }

  void setNeonColor(String colorKey) {
    activeNeonColor.value = colorKey;
  }

  final ValueNotifier<List<StudentPersona>> allPersonas =
      ValueNotifier<List<StudentPersona>>(List.from(FakeData.personas));

  void _init() {
    refreshFromServer();
  }

  Future<void> refreshFromServer() async {
    try {
      final list = await ApiService.instance.getPersonas();
      if (list.isNotEmpty) {
        allPersonas.value = list;
        // keep current persona in sync
        final currentName = currentPersona.value.name;
        final match = list.where(
          (p) => p.name.toLowerCase() == currentName.toLowerCase(),
        );
        if (match.isNotEmpty) {
          currentPersona.value = match.first;
          currentUser.value = match.first.name;
        } else {
          currentPersona.value = list.first;
          currentUser.value = list.first.name;
        }
      }
    } catch (_) {
      // offline or server unavailable - fallback gracefully to FakeData
    }
  }

  void selectPersona(StudentPersona persona) {
    currentPersona.value = persona;
    currentUser.value = persona.name;
  }

  void setUserName(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;

    final match = allPersonas.value.where(
      (p) =>
          p.name.toLowerCase() == trimmed.toLowerCase() ||
          p.name.toLowerCase().startsWith(trimmed.toLowerCase()),
    );

    if (match.isNotEmpty) {
      selectPersona(match.first);
    } else {
      // Fallback: create a customized persona on the fly
      final custom = StudentPersona(
        name: trimmed,
        handle: '@${trimmed.toLowerCase().replaceAll(' ', '.')}',
        major: 'General Studies · Active Student',
        year: 'Year 2 · Sophomore',
        campus: 'Main Campus Quad',
        bio: 'Campus learner locked into peer study squads and active recall.',
        studyVibe: 'Pomodoro Focus · Quiet Library Corner',
        currentGoal: 'Build daily study habit and complete 10 quizzes',
        karmaScore: 4.50,
        karmaRank: 'RISING SCHOLAR',
        streakDays: 3,
        focusHours: 12.0,
        quizzesAced: 6,
        squadsJoined: 2,
        peerEndorsementsCount: 8,
        activeSquadName: 'General Study Crew',
        badges: [
          StudentBadge(
            title: 'CAMPUS EXPLORER',
            description: 'Joined first campus study crew',
            category: 'Welcome',
            isVolt: true,
            isUnlocked: true,
            unlockedDate: 'Today',
          ),
        ],
        recentActivity: [
          KarmaActivity(
            title: 'Joined Huddle Campus',
            detail: 'Created student profile and began study streak',
            karmaDelta: 0.10,
            timeAgo: 'Just now',
            iconName: 'star',
          ),
        ],
        endorsements: [],
      );
      allPersonas.value = [...allPersonas.value, custom];
      selectPersona(custom);
    }
  }

  Future<void> endorseCurrentPersona({
    required String tag,
    required String quote,
    required String authorName,
  }) async {
    final target = currentPersona.value;
    try {
      final updated = await ApiService.instance.endorsePersona(
        targetName: target.name,
        tag: tag,
        quote: quote,
        authorName: authorName,
      );
      if (updated != null) {
        _updateLocalPersona(updated);
        return;
      }
    } catch (_) {}

    // Local fallback
    final updatedEndorsements = [
      PeerEndorsement(
        authorName: authorName,
        authorMajor: 'Campus Peer',
        tag: tag.toUpperCase(),
        quote: quote,
        timeAgo: 'Just now',
      ),
      ...target.endorsements,
    ];
    final updated = target.copyWith(
      karmaScore: (target.karmaScore + 0.02).clamp(0.0, 5.0),
      peerEndorsementsCount: target.peerEndorsementsCount + 1,
      endorsements: updatedEndorsements,
    );
    _updateLocalPersona(updated);
  }

  Future<void> updateCurrentGoal(String newGoal) async {
    final target = currentPersona.value;
    try {
      final updated = await ApiService.instance.updateGoal(
        name: target.name,
        newGoal: newGoal,
      );
      if (updated != null) {
        _updateLocalPersona(updated);
        return;
      }
    } catch (_) {}

    final updated = target.copyWith(currentGoal: newGoal);
    _updateLocalPersona(updated);
  }

  void _updateLocalPersona(StudentPersona updated) {
    currentPersona.value = updated;
    final list = allPersonas.value.map((p) {
      return p.name.toLowerCase() == updated.name.toLowerCase() ? updated : p;
    }).toList();
    allPersonas.value = list;
  }

  bool get isLoggedIn => currentUser.value.trim().isNotEmpty;
}
