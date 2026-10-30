import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../services/user_service.dart';
import '../../theme.dart';
import '../widgets/huddle_button.dart';
import '../widgets/huddle_card.dart';
import '../widgets/huddle_chip.dart';
import '../widgets/pictorial_avatar.dart';
import '../widgets/section_label.dart';
import '../widgets/serverpod_badge.dart';

/// Modern Gen Z Welcome & Fast Onboarding Login Screen.
/// Built strictly with Flutter and Serverpod.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nameController = TextEditingController();
  String _selectedCampus = 'CS Quad';
  String _activeSpeechQuote =
      "Ayaan: 'Locked in on graph algorithms tonight. Join our squad!' 🔥";
  String _activeSpeaker = 'Ayaan';
  bool _isSubmitting = false;

  final List<Map<String, dynamic>> _welcomeSquad = [
    {
      'name': 'Ayaan',
      'handle': '@ayaan.dsa',
      'vibe': AvatarVibe.lofiCoder,
      'emoji': '🔥',
      'label': '14d streak',
      'quote': 'Locked in on graph algorithms tonight. Join our squad!',
      'major': 'CS · Final Year',
    },
    {
      'name': 'Priya',
      'handle': '@priya.dev',
      'vibe': AvatarVibe.starScholar,
      'emoji': '⚡',
      'label': '25m sprint',
      'quote': '25 min deep work, no distractions. Let\'s crush DBMS!',
      'major': 'Software Eng · Year 3',
    },
    {
      'name': 'Sarah',
      'handle': '@sarah.bio',
      'vibe': AvatarVibe.campusCheer,
      'emoji': '💖',
      'label': '98% match',
      'quote': 'Pre-med active recall reel is live. Try the 3-question quiz!',
      'major': 'Bio Sciences · Year 2',
    },
    {
      'name': 'Marcus',
      'handle': '@marcus.os',
      'vibe': AvatarVibe.lateNightCram,
      'emoji': '🎧',
      'label': 'lo-fi squad',
      'quote': 'Late night OS kernel lock-in. 8 members focusing now.',
      'major': 'Systems Eng · Year 3',
    },
    {
      'name': 'Aisha',
      'handle': '@aisha.ml',
      'vibe': AvatarVibe.aiPioneer,
      'emoji': '🧠',
      'label': 'active recall',
      'quote': 'Attention mechanisms explained in 45 seconds. Level up!',
      'major': 'AI / ML · Year 4',
    },
    {
      'name': 'Kai',
      'handle': '@kai.cyber',
      'vibe': AvatarVibe.cyberVisor,
      'emoji': '🕶️',
      'label': 'visionary',
      'quote': 'Distributed systems consensus protocol broken down visually.',
      'major': 'Cyber Sec · Year 4',
    },
    {
      'name': 'Mia',
      'handle': '@mia.ui',
      'vibe': AvatarVibe.neonNeko,
      'emoji': '🐱',
      'label': 'cyber neko',
      'quote': 'Designing neo-brutalist campus components. Come co-work!',
      'major': 'Design Tech · Year 2',
    },
    {
      'name': 'Leo',
      'handle': '@leo.game',
      'vibe': AvatarVibe.gamerPro,
      'emoji': '🎮',
      'label': 'pro gamer',
      'quote': 'Game physics engine sprint in 25 mins. Locked in!',
      'major': 'Interactive Media · Year 3',
    },
  ];

  final List<String> _campusQuads = [
    'CS Quad',
    'North Library',
    'Engineering Hub',
    'Science Hall',
    'Design Lab',
  ];

  @override
  void initState() {
    super.initState();
    final current = UserService.instance.currentUser.value;
    if (current.isNotEmpty && current != 'Student') {
      _nameController.text = current;
    } else {
      _nameController.text = 'Ayaan';
    }
    _nameController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _selectSquadMember(Map<String, dynamic> member) {
    HapticFeedback.selectionClick();
    setState(() {
      _activeSpeaker = member['name'] as String;
      _activeSpeechQuote =
          "${member['name']}: '${member['quote']}' ${member['emoji']}";
      _nameController.text = member['name'] as String;
    });
  }

  void _loginAndEnter() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: HuddleTheme.pink,
          content: Text(
            'Drop your student name or campus handle to lock in!',
            style: HuddleTheme.monoLabel(color: Colors.white),
          ),
        ),
      );
      return;
    }

    HapticFeedback.heavyImpact();
    setState(() => _isSubmitting = true);

    // Sync student identity with UserService and Serverpod
    UserService.instance.setUserName(name);

    await Future.delayed(const Duration(milliseconds: 300));

    if (mounted) {
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: HuddleTheme.violet,
          duration: const Duration(seconds: 2),
          content: Row(
            children: [
              const Icon(Icons.bolt_rounded, color: HuddleTheme.volt, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Locked in as $name! Welcome to $_selectedCampus crew.',
                  style: HuddleTheme.monoLabel(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
      context.go('/feed');
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveSeed = _nameController.text.trim().isEmpty
        ? 'Student'
        : _nameController.text.trim();
    final width = MediaQuery.of(context).size.width;
    final isLaptop = width >= 960;

    if (isLaptop) {
      return Scaffold(
        backgroundColor: HuddleTheme.neonBg,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column: Welcome Squad, Headline, Perks (Flex 6)
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildTopBar(context),
                      const SizedBox(height: 18),
                      _buildHeadline(),
                      const SizedBox(height: 18),
                      _buildAvatarWelcomeSquad(),
                      const SizedBox(height: 14),
                      _buildInteractiveSpeechBubble(),
                      const SizedBox(height: 22),
                      _buildHappyLearningHighlights(),
                    ],
                  ),
                ),
                const SizedBox(width: 32),

                // Right Column: Interactive Login Card & Serverpod Footer (Flex 5)
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildLoginCard(effectiveSeed),
                      const SizedBox(height: 18),
                      _buildServerpodFooter(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: HuddleTheme.neonBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. TOP BAR WITH SERVERPOD BADGE & STATUS
                  _buildTopBar(context),
                  const SizedBox(height: 18),

                  // 2. HERO AVATAR SQUAD WELCOME BANNER
                  _buildAvatarWelcomeSquad(),
                  const SizedBox(height: 14),

                  // 3. INTERACTIVE AVATAR SPEECH BUBBLE
                  _buildInteractiveSpeechBubble(),
                  const SizedBox(height: 20),

                  // 4. MAIN GEN Z HEADLINE & SUBTITLE
                  _buildHeadline(),
                  const SizedBox(height: 22),

                  // 5. LOGIN CARD WITH LIVE PICTORIAL AVATAR PREVIEW
                  _buildLoginCard(effectiveSeed),
                  const SizedBox(height: 22),

                  // 6. REACT ICONS & HAPPY LEARNING HIGHLIGHTS
                  _buildHappyLearningHighlights(),
                  const SizedBox(height: 22),

                  // 7. SERVERPOD POWERED FOOTER
                  _buildServerpodFooter(context),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      runSpacing: 6,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ServerpodBadge(size: 30, showLabel: false),
            const SizedBox(width: 8),
            Text(
              'HUDDLE',
              style: HuddleTheme.displayHeading(
                fontSize: 20,
              ).copyWith(color: Colors.white),
            ),
          ],
        ),
        Wrap(
          spacing: 6,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: HuddleTheme.neonCyan,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: HuddleTheme.neonCyan,
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
            Text(
              '1,420 CAMPUS PEERS ACTIVE ❖',
              style: HuddleTheme.monoLabel(
                color: HuddleTheme.neonCyan,
              ).copyWith(fontSize: 10, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAvatarWelcomeSquad() {
    return HuddleCard(
      color: HuddleTheme.neonCard,
      border: HuddleTheme.borderCyanSubtle,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 6,
            children: [
              const HuddleChip.sticker(
                label: 'WELCOME SQUAD',
                variant: HuddleChipVariant.neon,
                angleDegrees: -1.5,
              ),
              Text(
                'TAP AVATAR TO SAY HI',
                style: HuddleTheme.monoLabel(
                  color: HuddleTheme.neonTextMuted,
                ).copyWith(fontSize: 10),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Eye-Catchy Image 2 Anime Avatars Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (final member in _welcomeSquad)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: InkWell(
                      onTap: () => _selectSquadMember(member),
                      borderRadius: BorderRadius.circular(16),
                      child: Column(
                        children: [
                          PictorialAvatar(
                            seed: member['name'] as String,
                            size: 64,
                            vibe: member['vibe'] as AvatarVibe,
                            reactionEmoji: member['emoji'] as String,
                            reactionLabel: member['label'] as String,
                            onTap: () => _selectSquadMember(member),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: _activeSpeaker == member['name']
                                  ? HuddleTheme.neonCyan
                                  : HuddleTheme.neonCardAlt,
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(
                                color: _activeSpeaker == member['name']
                                    ? HuddleTheme.neonCyan
                                    : HuddleTheme.neonCyan.withValues(
                                        alpha: 0.3,
                                      ),
                                width: 1.0,
                              ),
                            ),
                            child: Text(
                              member['name'] as String,
                              style:
                                  HuddleTheme.monoLabel(
                                    color: _activeSpeaker == member['name']
                                        ? HuddleTheme.neonBg
                                        : Colors.white,
                                  ).copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractiveSpeechBubble() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: HuddleTheme.neonCardAlt,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: HuddleTheme.neonCyan, width: 1.5),
        boxShadow: const [HuddleTheme.shadowCyan],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.chat_bubble_outline_rounded,
            color: HuddleTheme.neonCyan,
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _activeSpeechQuote,
              style: HuddleTheme.body14(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ).copyWith(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeadline() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          runSpacing: 6,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                'STUDY TOGETHER.',
                style: HuddleTheme.displayHero(
                  color: HuddleTheme.neonCyan,
                ).copyWith(fontSize: 34),
              ),
            ),
            const HuddleChip.sticker(
              label: '❖ NEON SQUARE',
              variant: HuddleChipVariant.neon,
              angleDegrees: 2.0,
            ),
          ],
        ),
        const SizedBox(height: 4),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            'NEVER CRAM ALONE.',
            style: HuddleTheme.displayHero(
              color: Colors.white,
            ).copyWith(fontSize: 34),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Instant name-based campus login. Join 25-minute Pomodoro study crews, swipe reels with 3-question quizzes, and earn campus karma.',
          style: HuddleTheme.body16(color: HuddleTheme.neonTextMuted),
        ),
      ],
    );
  }

  Widget _buildLoginCard(String effectiveSeed) {
    return HuddleCard(
      color: HuddleTheme.neonCard,
      border: HuddleTheme.borderCyan,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Live Avatar & Welcome Salutation
          Row(
            children: [
              PictorialAvatar(
                seed: effectiveSeed,
                size: 68,
                showBadge: true,
                reactionEmoji: '⚡',
                reactionLabel: 'READY',
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'WHO\'S PULLING UP?',
                      style:
                          HuddleTheme.monoLabel(
                            color: HuddleTheme.neonCyan,
                          ).copyWith(
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Welcome, ${_nameController.text.trim().isEmpty ? "Student" : _nameController.text.trim()}!',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: HuddleTheme.displayHeading(
                        fontSize: 22,
                      ).copyWith(color: Colors.white),
                    ),
                    Text(
                      'Your avatar updates live as you type',
                      style: HuddleTheme.body14(
                        color: HuddleTheme.neonTextMuted,
                      ).copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // 1-Tap Quick Persona Selector
          Text(
            'OR 1-TAP POPULAR STUDENT PERSONAS:',
            style: HuddleTheme.monoLabel(
              color: HuddleTheme.neonCyan,
            ).copyWith(fontSize: 10),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final member in _welcomeSquad)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: InkWell(
                      onTap: () => _selectSquadMember(member),
                      borderRadius: BorderRadius.circular(999),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _nameController.text.trim() == member['name']
                              ? HuddleTheme.neonCyan
                              : HuddleTheme.neonCardAlt,
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: _nameController.text.trim() == member['name']
                                ? HuddleTheme.neonCyan
                                : HuddleTheme.neonCyan.withValues(
                                    alpha: 0.3,
                                  ),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              member['emoji'] as String,
                              style: const TextStyle(fontSize: 12),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              member['name'] as String,
                              style:
                                  HuddleTheme.monoLabel(
                                    color:
                                        _nameController.text.trim() ==
                                            member['name']
                                        ? HuddleTheme.neonBg
                                        : Colors.white,
                                  ).copyWith(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Name Input Box
          const SectionLabel(
            text: 'YOUR CAMPUS NAME OR HANDLE',
            color: HuddleTheme.neonCyan,
          ),
          const SizedBox(height: 6),
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: HuddleTheme.neonBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: HuddleTheme.neonCyan.withValues(alpha: 0.6),
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.alternate_email_rounded,
                  size: 18,
                  color: HuddleTheme.neonCyan,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    style: HuddleTheme.monoLabel(color: Colors.white).copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    decoration: InputDecoration(
                      hintText: 'e.g. Aisha Rahman, Ayaan, Priya...',
                      hintStyle: TextStyle(
                        color: HuddleTheme.neonTextMuted.withValues(alpha: 0.6),
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    onSubmitted: (_) => _loginAndEnter(),
                  ),
                ),
                if (_nameController.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(
                      Icons.clear_rounded,
                      size: 16,
                      color: HuddleTheme.neonTextMuted,
                    ),
                    onPressed: () => _nameController.clear(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Campus Quad Chip Selector
          const SectionLabel(
            text: 'SELECT YOUR CAMPUS QUAD',
            color: HuddleTheme.neonCyan,
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              for (final quad in _campusQuads)
                InkWell(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    setState(() => _selectedCampus = quad);
                  },
                  borderRadius: BorderRadius.circular(999),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: _selectedCampus == quad
                          ? HuddleTheme.neonCyan
                          : HuddleTheme.neonCardAlt,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: _selectedCampus == quad
                            ? HuddleTheme.neonCyan
                            : HuddleTheme.neonCyan.withValues(alpha: 0.3),
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      quad.toUpperCase(),
                      style:
                          HuddleTheme.monoLabel(
                            color: _selectedCampus == quad
                                ? HuddleTheme.neonBg
                                : HuddleTheme.neonTextMuted,
                          ).copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 22),

          // Primary Enter CTA Button
          HuddleButton(
            text: _isSubmitting ? 'LOCKING IN...' : 'LOCK IN & ENTER HUDDLE 🚀',
            icon: Icons.bolt_rounded,
            variant: HuddleButtonVariant.neon,
            height: 52,
            fullWidth: true,
            onPressed: _isSubmitting ? null : _loginAndEnter,
          ),
        ],
      ),
    );
  }

  Widget _buildHappyLearningHighlights() {
    final perks = [
      {
        'icon': Icons.local_fire_department_rounded,
        'emoji': '🔥',
        'color': HuddleTheme.pink,
        'title': '25-MIN POMODORO',
        'desc': 'Server-synchronized timer rings. When one focuses, all focus.',
      },
      {
        'icon': Icons.movie_outlined,
        'emoji': '🧠',
        'color': HuddleTheme.violet,
        'title': 'PEER REELS & QUIZ',
        'desc':
            '45-second micro-lessons with instant 3-question active recall.',
      },
      {
        'icon': Icons.groups_rounded,
        'emoji': '⚡',
        'color': HuddleTheme.teal,
        'title': 'SQUAD MATCHING',
        'desc':
            'Matched by topic, exam target, and study streak. No solo cramming.',
      },
      {
        'icon': Icons.auto_awesome_rounded,
        'emoji': '✨',
        'color': HuddleTheme.highlight,
        'title': 'VERIFIED KARMA',
        'desc': 'Earn real peer reputation and unlocks as you help crew mates.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel(
          text: 'WHY STUDENTS SCREENSHOT HUDDLE',
          color: HuddleTheme.neonCyan,
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: perks.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.8,
          ),
          itemBuilder: (context, idx) {
            final p = perks[idx];
            return HuddleCard(
              color: HuddleTheme.neonCard,
              border: HuddleTheme.borderCyanSubtle,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: HuddleTheme.neonCardAlt,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: HuddleTheme.neonCyan.withValues(alpha: 0.4),
                        width: 1.2,
                      ),
                    ),
                    child: Text(
                      p['emoji'] as String,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          p['title'] as String,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: HuddleTheme.monoLabel(
                            color: Colors.white,
                          ).copyWith(fontSize: 10, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          p['desc'] as String,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: HuddleTheme.body14(
                            color: HuddleTheme.neonTextMuted,
                          ).copyWith(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildServerpodFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: HuddleTheme.neonCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: HuddleTheme.neonCyan.withValues(alpha: 0.4),
          width: 1.5,
        ),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 12,
        runSpacing: 8,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 4,
            children: [
              const ServerpodBadge(size: 24, showLabel: false),
              Text(
                'TYPED ENDPOINTS · LIVE STREAMS',
                style: HuddleTheme.monoLabel(
                  color: HuddleTheme.neonTextMuted,
                ).copyWith(fontSize: 9),
              ),
            ],
          ),
          HuddleButton(
            text: 'Skip to Feed',
            variant: HuddleButtonVariant.neonSubtle,
            height: 32,
            icon: Icons.arrow_forward_rounded,
            onPressed: () => context.go('/feed'),
          ),
        ],
      ),
    );
  }
}
