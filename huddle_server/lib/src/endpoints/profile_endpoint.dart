import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class ProfileEndpoint extends Endpoint {
  static final List<StudentPersona> _personas = [
    StudentPersona(
      name: 'Aisha Rahman',
      handle: '@aisha.cs',
      major: 'Computer Science (Systems & AI)',
      year: 'Year 3 · Junior',
      campus: 'North Campus Tech Hub',
      bio:
          'Distributed systems nerd & CS 201 TA. Building a mini Raft consensus engine. Do not talk to me before 2 Pomodoro rounds.',
      studyVibe: 'Silent Pomodoro · Lofi Synthwave · Double Espresso',
      currentGoal:
          'Implement Raft cluster heartbeat & score 95%+ on DistSys finals',
      karmaScore: 4.92,
      karmaRank: 'TOP 1% CAMPUS ANCHOR',
      streakDays: 18,
      focusHours: 38.5,
      quizzesAced: 24,
      squadsJoined: 4,
      peerEndorsementsCount: 58,
      activeSquadName: 'Algorithm Knights',
      badges: [
        StudentBadge(
          title: 'POMODORO MASTER',
          description: 'Completed 25+ certified focus hours',
          category: 'Focus',
          isVolt: true,
          isUnlocked: true,
          unlockedDate: 'Oct 24',
        ),
        StudentBadge(
          title: 'SPEED SOLVER',
          description: 'Aced 5 consecutive active recall quizzes',
          category: 'Quiz',
          isVolt: false,
          isUnlocked: true,
          unlockedDate: 'Oct 27',
        ),
        StudentBadge(
          title: 'MIDNIGHT DEBUGGER',
          description: 'Studied past 1:00 AM with squad members',
          category: 'Grind',
          isVolt: true,
          isUnlocked: true,
          unlockedDate: 'Oct 28',
        ),
        StudentBadge(
          title: 'CAMPUS ANCHOR',
          description: 'Maintained 4.9+ Karma for 30 consecutive days',
          category: 'Prestige',
          isVolt: false,
          isUnlocked: true,
          unlockedDate: 'Oct 15',
        ),
      ],
      recentActivity: [
        KarmaActivity(
          title: 'Hosted 50m Pomodoro Session',
          detail: '4 peers locked in together in Algorithm Knights',
          karmaDelta: 0.05,
          timeAgo: '2h ago',
          iconName: 'timer',
        ),
        KarmaActivity(
          title: 'Aced Try-It Quiz: Mutex vs Semaphore',
          detail: 'Scored 3/3 on first attempt in 28 seconds',
          karmaDelta: 0.03,
          timeAgo: '5h ago',
          iconName: 'quiz',
        ),
        KarmaActivity(
          title: 'Peer Endorsement Received',
          detail: 'Endorsed for "Clarity under pressure" by Dev P.',
          karmaDelta: 0.04,
          timeAgo: 'Yesterday',
          iconName: 'star',
        ),
      ],
      endorsements: [
        PeerEndorsement(
          authorName: 'Dev Patel',
          authorMajor: 'CS Year 4',
          tag: 'SYSTEMS GENIUS',
          quote:
              'Carried our Distributed Systems sprint at 2 AM without losing patience. Explains concensus like second nature.',
          timeAgo: '1d ago',
        ),
        PeerEndorsement(
          authorName: 'Marcus Turner',
          authorMajor: 'CS Year 2',
          tag: 'BEST EXPLAINER',
          quote:
              'Her 45s reel on Mutex vs Semaphore literally saved my midterm score. Clear, direct, zero fluff.',
          timeAgo: '3d ago',
        ),
        PeerEndorsement(
          authorName: 'Sarah Kim',
          authorMajor: 'EE Year 3',
          tag: 'SQUAD ANCHOR',
          quote:
              'Always keeps the squad locked in when everyone else is drifting off. 25m Pomodoro queen.',
          timeAgo: '5d ago',
        ),
      ],
    ),
    StudentPersona(
      name: 'Kabir Sharma',
      handle: '@kabir.cad',
      major: 'Mechanical Engineering (Solid Mechanics)',
      year: 'Year 4 · Senior',
      campus: 'South Engineering Machine Labs',
      bio:
          'Formula Student chassis lead. Spending 14 hours a day in the shop. Grinding FE Mechanical exam & Finite Element Analysis.',
      studyVibe: 'Whiteboard Problem Solving · MathCAD · Matcha Latte',
      currentGoal: 'Master FE Exam Thermo & Fluid Dynamics question banks',
      karmaScore: 4.78,
      karmaRank: 'TOP 5% SQUAD ANCHOR',
      streakDays: 9,
      focusHours: 44.0,
      quizzesAced: 16,
      squadsJoined: 3,
      peerEndorsementsCount: 42,
      activeSquadName: 'Late Night Mechanics',
      badges: [
        StudentBadge(
          title: 'MARATHON SESSION',
          description: 'Logged 4+ hour single squad focus session',
          category: 'Focus',
          isVolt: true,
          isUnlocked: true,
          unlockedDate: 'Oct 26',
        ),
        StudentBadge(
          title: 'HARDWARE HUSTLE',
          description: 'Completed 10 mechanical design review sessions',
          category: 'Specialty',
          isVolt: false,
          isUnlocked: true,
          unlockedDate: 'Oct 20',
        ),
        StudentBadge(
          title: 'NIGHT OWL',
          description: 'Studied past 11 PM with squad',
          category: 'Grind',
          isVolt: true,
          isUnlocked: true,
          unlockedDate: 'Oct 25',
        ),
        StudentBadge(
          title: 'WORKSHOP LEAD',
          description: 'Conducted CAD speedrun workshop on campus',
          category: 'Leadership',
          isVolt: false,
          isUnlocked: true,
          unlockedDate: 'Oct 18',
        ),
      ],
      recentActivity: [
        KarmaActivity(
          title: 'Completed Thermo Problem Set #7',
          detail: '4 hours focus streak logged with 3 squad members',
          karmaDelta: 0.04,
          timeAgo: '3h ago',
          iconName: 'timer',
        ),
        KarmaActivity(
          title: 'FE Exam Diagnostic Test Passed',
          detail: 'Scored 88% on Fluid Mechanics module',
          karmaDelta: 0.03,
          timeAgo: 'Yesterday',
          iconName: 'quiz',
        ),
      ],
      endorsements: [
        PeerEndorsement(
          authorName: 'Ananya Verma',
          authorMajor: 'Mech Year 2',
          tag: 'WHITEBOARD WIZARD',
          quote:
              'Explains Mohr circle and stress tensors 10x better than our textbook. Saved our lab report.',
          timeAgo: '2d ago',
        ),
        PeerEndorsement(
          authorName: 'Rohan Mehta',
          authorMajor: 'Mech Year 4',
          tag: 'CHASSIS BEAST',
          quote:
              'Hosted a 4-hour mock FE session in the squad room. Relentless work ethic, total MVP.',
          timeAgo: '4d ago',
        ),
      ],
    ),
    StudentPersona(
      name: 'Priya Menon',
      handle: '@priya.data',
      major: 'Economics & Data Science',
      year: 'Year 2 · Sophomore',
      campus: 'West Stats & Social Sciences Quad',
      bio:
          'Econometrics researcher & stats tutor. Passionate about causal inference, R regressions, and behavioral economics. Ping me for clean ggplot2 charts.',
      studyVibe: 'Noise-Cancelling Over-Ears · Classical Piano · Iced Americano',
      currentGoal:
          'Draft empirical thesis proposal on local rental price dynamics',
      karmaScore: 4.85,
      karmaRank: 'TOP 3% RISING STAR',
      streakDays: 14,
      focusHours: 29.0,
      quizzesAced: 22,
      squadsJoined: 5,
      peerEndorsementsCount: 39,
      activeSquadName: 'Stochastic Squad',
      badges: [
        StudentBadge(
          title: 'SPEED SOLVER',
          description: 'Aced 5 consecutive active recall quizzes',
          category: 'Quiz',
          isVolt: true,
          isUnlocked: true,
          unlockedDate: 'Oct 25',
        ),
        StudentBadge(
          title: 'REEL MAESTRO',
          description: 'Author of 3 high-impact campus micro-lessons',
          category: 'Creator',
          isVolt: false,
          isUnlocked: true,
          unlockedDate: 'Oct 22',
        ),
        StudentBadge(
          title: 'CONSISTENT GRIND',
          description: '14-day unbroken daily focus room check-in',
          category: 'Streak',
          isVolt: true,
          isUnlocked: true,
          unlockedDate: 'Oct 28',
        ),
        StudentBadge(
          title: 'STATS VIRTUOSO',
          description: '100% on every econometric method test',
          category: 'Specialty',
          isVolt: false,
          isUnlocked: true,
          unlockedDate: 'Oct 19',
        ),
      ],
      recentActivity: [
        KarmaActivity(
          title: 'Published Peer Reel: OLS Assumptions',
          detail: 'Bite-sized breakdown watched by 160 students',
          karmaDelta: 0.06,
          timeAgo: '4h ago',
          iconName: 'movie',
        ),
        KarmaActivity(
          title: '14-Day Streak Milestone Reached',
          detail: 'Consistent daily Pomodoro presence on campus',
          karmaDelta: 0.05,
          timeAgo: '1d ago',
          iconName: 'fire',
        ),
      ],
      endorsements: [
        PeerEndorsement(
          authorName: 'Jason Liu',
          authorMajor: 'Econ Year 3',
          tag: 'STATS SAVIOR',
          quote:
              'Her intuition on Heteroskedasticity and p-values is crystal clear. Makes econometrics actually fun.',
          timeAgo: '1d ago',
        ),
        PeerEndorsement(
          authorName: 'Maya Sen',
          authorMajor: 'Stats Year 1',
          tag: 'NOTION GENIUS',
          quote:
              'Always shares structured Notion summary notes after every focus round. Invaluable study partner.',
          timeAgo: '3d ago',
        ),
      ],
    ),
    StudentPersona(
      name: 'Ayaan Khan',
      handle: '@ayaan.arch',
      major: 'Architecture & Spatial Design',
      year: 'Year 3 · Junior',
      campus: 'East Studio Lofts',
      bio:
          'Studio dweller building physical models & Rhino 3D parametric rigs. Living off oat milk and laser cutter queues. Seeking quiet late-night drawing crews.',
      studyVibe: 'Ambient Lo-Fi · Wacom Drawing Tablet · Continuous Green Tea',
      currentGoal: 'Finish final scale model for urban transit hub critique',
      karmaScore: 4.65,
      karmaRank: 'TOP 8% VISUAL THINKER',
      streakDays: 7,
      focusHours: 22.5,
      quizzesAced: 11,
      squadsJoined: 2,
      peerEndorsementsCount: 27,
      activeSquadName: 'Studio All-Nighters',
      badges: [
        StudentBadge(
          title: 'STUDIO ANCHOR',
          description: 'Host of East Loft all-night focus sessions',
          category: 'Host',
          isVolt: true,
          isUnlocked: true,
          unlockedDate: 'Oct 23',
        ),
        StudentBadge(
          title: 'FEEDBACK HERO',
          description: 'Given 20+ peer critique reactions in chat',
          category: 'Community',
          isVolt: false,
          isUnlocked: true,
          unlockedDate: 'Oct 21',
        ),
        StudentBadge(
          title: 'NIGHT OWL',
          description: 'Studied past 11 PM with squad',
          category: 'Grind',
          isVolt: true,
          isUnlocked: true,
          unlockedDate: 'Oct 27',
        ),
        StudentBadge(
          title: 'CREATIVE FLOW',
          description: 'Maintained 3 consecutive 50m study blocks',
          category: 'Focus',
          isVolt: false,
          isUnlocked: true,
          unlockedDate: 'Oct 17',
        ),
      ],
      recentActivity: [
        KarmaActivity(
          title: '3D Rhino Model Section Crit',
          detail: 'Shared structural renders with studio peer crew',
          karmaDelta: 0.03,
          timeAgo: '6h ago',
          iconName: 'draw',
        ),
        KarmaActivity(
          title: 'Laser Cutter Workshop Completed',
          detail: 'Assisted 3 first-year students with acrylic cuts',
          karmaDelta: 0.04,
          timeAgo: '2d ago',
          iconName: 'hand',
        ),
      ],
      endorsements: [
        PeerEndorsement(
          authorName: 'Fatima Baig',
          authorMajor: 'Arch Year 3',
          tag: 'LIFESAVER',
          quote:
              'Saved my section drawings from crashing 20 mins before critique! The most generous designer on campus.',
          timeAgo: '2d ago',
        ),
        PeerEndorsement(
          authorName: 'Tyler Nguyen',
          authorMajor: 'Design Year 4',
          tag: 'LOFI VIBES',
          quote:
              'Creates the best calm studio focus room atmosphere on campus. Zero ego, pure craft.',
          timeAgo: '5d ago',
        ),
      ],
    ),
  ];

  /// Get all campus student personas
  Future<List<StudentPersona>> getPersonas(Session session) async {
    return _personas;
  }

  /// Get persona by exact or partial name
  Future<StudentPersona?> getPersonaByName(Session session, String name) async {
    final lower = name.toLowerCase().trim();
    final match = _personas.where((p) => p.name.toLowerCase().contains(lower));
    if (match.isNotEmpty) return match.first;
    return _personas.first;
  }

  /// Endorse a peer's campus karma
  Future<StudentPersona> endorsePersona(
    Session session, {
    required String targetName,
    required String tag,
    required String quote,
    required String authorName,
  }) async {
    final index = _personas.indexWhere(
      (p) => p.name.toLowerCase().contains(targetName.toLowerCase().trim()),
    );
    if (index == -1) return _personas.first;

    final target = _personas[index];
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
    _personas[index] = updated;
    return updated;
  }

  /// Update personal study goal
  Future<StudentPersona> updateGoal(
    Session session, {
    required String name,
    required String newGoal,
  }) async {
    final index = _personas.indexWhere(
      (p) => p.name.toLowerCase().contains(name.toLowerCase().trim()),
    );
    if (index == -1) return _personas.first;

    final target = _personas[index];
    final updated = target.copyWith(currentGoal: newGoal);
    _personas[index] = updated;
    return updated;
  }
}

