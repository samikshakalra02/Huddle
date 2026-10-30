import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:huddle_client/huddle_client.dart';
import '../../data/fake_data.dart';
import '../../services/user_service.dart';
import '../../theme.dart';
import '../widgets/huddle_avatar.dart';
import '../widgets/huddle_button.dart';
import '../widgets/huddle_card.dart';
import '../widgets/huddle_chip.dart';
import '../widgets/section_label.dart';
import '../widgets/streak_counter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _endorseTagController = TextEditingController();
  final TextEditingController _endorseQuoteController = TextEditingController();

  // Avatar picker state (12 procedural seeds)
  late List<String> _avatarSeeds;
  String? _previewSeed;
  int _shuffleCount = 0;
  AvatarVibe _selectedVibe = UserService.instance.activeVibe.value;
  Color _selectedAuraColor = HuddleTheme.violet;

  final List<Map<String, dynamic>> _vibeOptions = const [
    {'vibe': AvatarVibe.lofiCoder, 'label': 'LO-FI CODER', 'emoji': '🎧'},
    {'vibe': AvatarVibe.starScholar, 'label': 'STAR SCHOLAR', 'emoji': '⭐'},
    {'vibe': AvatarVibe.neonNeko, 'label': 'NEON NEKO', 'emoji': '🐱'},
    {'vibe': AvatarVibe.cyberVisor, 'label': 'CYBER VISOR', 'emoji': '🕶️'},
    {'vibe': AvatarVibe.lateNightCram, 'label': 'BEANIE CRAM', 'emoji': '🧢'},
    {'vibe': AvatarVibe.campusCheer, 'label': 'CAMPUS CHEER', 'emoji': '💖'},
    {'vibe': AvatarVibe.gamerPro, 'label': 'GAMER PRO', 'emoji': '🎮'},
    {'vibe': AvatarVibe.aiPioneer, 'label': 'AI PIONEER', 'emoji': '🧠'},
  ];

  final List<Map<String, dynamic>> _auraColors = const [
    {'name': 'Violet', 'color': HuddleTheme.violet},
    {'name': 'Teal', 'color': HuddleTheme.teal},
    {'name': 'Pink', 'color': HuddleTheme.pink},
    {'name': 'Volt', 'color': HuddleTheme.volt},
    {'name': 'Yellow', 'color': HuddleTheme.highlight},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _generateAvatarSeeds();
    _previewSeed = UserService.instance.effectiveAvatarSeed;
  }

  @override
  void dispose() {
    _tabController.dispose();
    _goalController.dispose();
    _endorseTagController.dispose();
    _endorseQuoteController.dispose();
    super.dispose();
  }

  void _generateAvatarSeeds() {
    final rng = Random(_shuffleCount + 42);
    const prefixes = [
      'alpha',
      'bravo',
      'cadet',
      'delta',
      'echo',
      'falcon',
      'gamma',
      'helix',
      'indigo',
      'jolt',
      'krypton',
      'luna',
      'matrix',
      'nebula',
      'orbit',
      'pulse',
      'quark',
      'radar',
      'surge',
      'titan',
      'ultra',
      'vortex',
      'wave',
      'zenith',
    ];
    final shuffled = List<String>.from(prefixes)..shuffle(rng);
    _avatarSeeds = List.generate(
      12,
      (i) => '${shuffled[i % shuffled.length]}-${i + 1}',
    );
  }

  void _shuffleSeeds() {
    HapticFeedback.lightImpact();
    setState(() {
      _shuffleCount++;
      _generateAvatarSeeds();
      _previewSeed = _avatarSeeds.first;
    });
  }

  void _saveAvatarSeed(String seed) {
    HapticFeedback.mediumImpact();
    UserService.instance.setAvatarSeed(seed);
    UserService.instance.setAvatarVibe(_selectedVibe);
    setState(() {
      _previewSeed = seed;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: HuddleTheme.ink,
        duration: const Duration(seconds: 2),
        content: Text(
          'Neon Cartoon Avatar locked in for campus profile!',
          style: HuddleTheme.monoLabel(color: Colors.white),
        ),
      ),
    );
  }

  void _openAvatarStudioModal() {
    HapticFeedback.selectionClick();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (modalContext, setModalState) {
            final activeSeed =
                _previewSeed ?? UserService.instance.effectiveAvatarSeed;

            return Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              decoration: BoxDecoration(
                color: HuddleTheme.neonCard,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                border: Border.all(color: HuddleTheme.neonCyan, width: 1.5),
                boxShadow: const [HuddleTheme.shadowCyanGlow],
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 44,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'NEON AVATAR STUDIO',
                              style: HuddleTheme.monoLabel(
                                color: HuddleTheme.neonCyan,
                              ).copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                          HuddleButton(
                            text: 'Shuffle (12)',
                            icon: Icons.shuffle_outlined,
                            variant: HuddleButtonVariant.neonSubtle,
                            height: 32,
                            onPressed: () {
                              _shuffleSeeds();
                              setModalState(() {});
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Select anime cartoon persona vibe, aura glow, and seed preset.',
                        style: HuddleTheme.body14(
                          color: HuddleTheme.neonTextMuted,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Live Preview Avatar
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _selectedAuraColor,
                              width: 2.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: _selectedAuraColor.withValues(
                                  alpha: 0.35,
                                ),
                                blurRadius: 14,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: HuddleAvatar(
                            seed: activeSeed,
                            size: 76,
                            vibe: _selectedVibe,
                            neonColor: _selectedAuraColor,
                            showOnline: true,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // 1. Choose Vibe
                      Text(
                        'AVATAR VIBE',
                        style: HuddleTheme.monoLabel(
                          color: Colors.white,
                        ).copyWith(fontSize: 11, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (final opt in _vibeOptions)
                              Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: InkWell(
                                  onTap: () {
                                    HapticFeedback.selectionClick();
                                    setState(() {
                                      _selectedVibe = opt['vibe'] as AvatarVibe;
                                    });
                                    setModalState(() {});
                                  },
                                  borderRadius: BorderRadius.circular(999),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _selectedVibe == opt['vibe']
                                          ? _selectedAuraColor
                                          : HuddleTheme.neonCardAlt,
                                      borderRadius: BorderRadius.circular(999),
                                      border: Border.all(
                                        color: _selectedVibe == opt['vibe']
                                            ? Colors.white
                                            : Colors.white12,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          opt['emoji'] as String,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          opt['label'] as String,
                                          style: HuddleTheme.monoLabel(
                                            color: Colors.white,
                                          ).copyWith(
                                            fontSize: 10,
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
                      const SizedBox(height: 14),

                      // 2. Choose Aura Color
                      Text(
                        'AURA COLOR',
                        style: HuddleTheme.monoLabel(
                          color: Colors.white,
                        ).copyWith(fontSize: 11, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          for (final aura in _auraColors)
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: InkWell(
                                onTap: () {
                                  HapticFeedback.selectionClick();
                                  setState(() {
                                    _selectedAuraColor = aura['color'] as Color;
                                  });
                                  setModalState(() {});
                                },
                                borderRadius: BorderRadius.circular(999),
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: aura['color'] as Color,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: _selectedAuraColor == aura['color']
                                          ? Colors.white
                                          : Colors.transparent,
                                      width: 2.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // 3. Grid of 12 avatar seeds
                      Text(
                        'PRESETS (12 VARIANTS)',
                        style: HuddleTheme.monoLabel(
                          color: Colors.white,
                        ).copyWith(fontSize: 11, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _avatarSeeds.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 6,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 1.0,
                            ),
                        itemBuilder: (context, idx) {
                          final seed = _avatarSeeds[idx];
                          final isSelected = seed == activeSeed;

                          return InkWell(
                            onTap: () {
                              HapticFeedback.selectionClick();
                              setState(() => _previewSeed = seed);
                              setModalState(() {});
                            },
                            borderRadius: BorderRadius.circular(999),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected
                                      ? HuddleTheme.neonCyan
                                      : Colors.transparent,
                                  width: 2.5,
                                ),
                              ),
                              padding: const EdgeInsets.all(2),
                              child: HuddleAvatar(
                                seed: seed,
                                size: 40,
                                vibe: _selectedVibe,
                                neonColor: _selectedAuraColor,
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: HuddleButton(
                          text: 'Lock In Look',
                          variant: HuddleButtonVariant.neon,
                          icon: Icons.check_outlined,
                          onPressed: () {
                            _saveAvatarSeed(activeSeed);
                            Navigator.pop(ctx);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showEditGoalDialog(StudentPersona persona) {
    _goalController.text = persona.currentGoal;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
          ),
          decoration: BoxDecoration(
            color: HuddleTheme.cardBackground,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            border: Border.all(color: HuddleTheme.cardBorder, width: 1.5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: HuddleTheme.ink.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const SectionLabel(text: 'UPDATE STUDY GOAL'),
              const SizedBox(height: 8),
              Text(
                'Visible to your study squads and peers focusing with you.',
                style: HuddleTheme.body14(
                  color: HuddleTheme.ink.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: HuddleTheme.background,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: HuddleTheme.cardBorder, width: 1.5),
                ),
                child: TextField(
                  controller: _goalController,
                  maxLines: 2,
                  style: HuddleTheme.body14(),
                  decoration: const InputDecoration(
                    hintText: 'e.g. Finish mock exam prep & DBMS chapter 4...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: HuddleButton(
                  text: 'Lock In New Goal',
                  icon: Icons.check_outlined,
                  variant: HuddleButtonVariant.accent,
                  onPressed: () {
                    final newGoal = _goalController.text.trim();
                    if (newGoal.isNotEmpty) {
                      UserService.instance.updateCurrentGoal(newGoal);
                      Navigator.pop(ctx);
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEndorseDialog(StudentPersona persona) {
    _endorseTagController.text = 'SQUAD ANCHOR';
    _endorseQuoteController.clear();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
          ),
          decoration: BoxDecoration(
            color: HuddleTheme.cardBackground,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            border: Border.all(color: HuddleTheme.cardBorder, width: 1.5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: HuddleTheme.ink.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const HuddleChip(
                    label: 'PEER KARMA',
                    variant: HuddleChipVariant.highlight,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'ENDORSE ${persona.name.toUpperCase()}',
                    style: HuddleTheme.monoLabel(),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Give a campus badge and short quote for their study impact.',
                style: HuddleTheme.body14(
                  color: HuddleTheme.ink.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 14),
              const SectionLabel(text: 'STICKER TAG'),
              const SizedBox(height: 6),
              Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: HuddleTheme.background,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: HuddleTheme.cardBorder, width: 1.5),
                ),
                child: TextField(
                  controller: _endorseTagController,
                  style: HuddleTheme.monoLabel(),
                  decoration: const InputDecoration(
                    hintText: 'e.g. SYSTEMS GENIUS',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              const SectionLabel(text: 'PEER QUOTE'),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: HuddleTheme.background,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: HuddleTheme.cardBorder, width: 1.5),
                ),
                child: TextField(
                  controller: _endorseQuoteController,
                  maxLines: 2,
                  style: HuddleTheme.body14(),
                  decoration: const InputDecoration(
                    hintText:
                        'e.g. Always explains tough concepts clearly during sprints...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: HuddleButton(
                  text: 'Submit Endorsement (+0.02 Karma)',
                  icon: Icons.star_outlined,
                  variant: HuddleButtonVariant.accent,
                  onPressed: () {
                    final tag = _endorseTagController.text.trim();
                    final quote = _endorseQuoteController.text.trim();
                    if (tag.isNotEmpty && quote.isNotEmpty) {
                      UserService.instance.endorseCurrentPersona(
                        tag: tag,
                        quote: quote,
                        authorName: 'Campus Peer',
                      );
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: HuddleTheme.ink,
                          content: Text(
                            'Endorsement sent to ${persona.name}!',
                            style: HuddleTheme.monoLabel(color: Colors.white),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HuddleTheme.neonBg,
      appBar: AppBar(
        backgroundColor: HuddleTheme.neonBg,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'CAMPUS KARMA',
          style: HuddleTheme.monoLabel(
            color: Colors.white,
          ).copyWith(letterSpacing: 1.0),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_outlined),
            color: HuddleTheme.neonCyan,
            tooltip: 'Sync with Serverpod',
            onPressed: () async {
              await UserService.instance.refreshFromServer();
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: HuddleTheme.neonCardAlt,
                  duration: const Duration(seconds: 1),
                  content: Text(
                    'Synced with Serverpod profile service',
                    style: HuddleTheme.monoLabel(color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ValueListenableBuilder<StudentPersona>(
          valueListenable: UserService.instance.currentPersona,
          builder: (context, persona, _) {
            final effectiveSeed =
                _previewSeed ?? UserService.instance.effectiveAvatarSeed;
            final isLaptop = MediaQuery.of(context).size.width >= 960;

            if (isLaptop) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 20,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Column (380px): Identity, Persona Switcher & Peer Endorsements
                    SizedBox(
                      width: 380,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildStudentHeroCard(persona, effectiveSeed),
                          const SizedBox(height: 18),
                          _buildPersonaSelector(persona),
                          const SizedBox(height: 20),
                          _buildEndorsementsSection(persona),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),

                    // Right Column (Expanded): Karma Header, Metrics, Badges, Tabs
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildKarmaHeader(persona),
                          const SizedBox(height: 20),
                          _buildMetricsBreakdown(persona),
                          const SizedBox(height: 22),
                          _buildBadgesGrid(persona),
                          const SizedBox(height: 22),
                          _buildTabsSection(persona),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. HERO STUDENT IDENTITY CARD
                  _buildStudentHeroCard(persona, effectiveSeed),
                  const SizedBox(height: 16),

                  // 2. SWITCH PERSONAS ROW
                  _buildPersonaSelector(persona),
                  const SizedBox(height: 18),

                  // 3. VERIFIED KARMA SCORE & STREAK HEADER
                  _buildKarmaHeader(persona),
                  const SizedBox(height: 18),

                  // 4. VERIFIED METRICS BREAKDOWN (4 CARDS)
                  _buildMetricsBreakdown(persona),
                  const SizedBox(height: 20),

                  // 5. BADGES GRID
                  _buildBadgesGrid(persona),
                  const SizedBox(height: 20),

                  // 6. TABS: MY REELS & GOALS
                  _buildTabsSection(persona),
                  const SizedBox(height: 20),

                  // 7. PEER ENDORSEMENTS
                  _buildEndorsementsSection(persona),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // 1. Hero Identity Card with 100px Neon Cartoon Avatar & Quick Actions
  Widget _buildStudentHeroCard(StudentPersona persona, String seed) {
    return HuddleCard(
      color: HuddleTheme.neonCard,
      border: HuddleTheme.borderCyanSubtle,
      boxShadow: const [HuddleTheme.shadowCyan],
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Top Chips: Verified Student & Campus
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 6,
            children: [
              const HuddleChip.sticker(
                label: 'VERIFIED STUDENT',
                variant: HuddleChipVariant.neon,
                angleDegrees: -1.5,
              ),
              HuddleChip(
                label: persona.campus.toUpperCase(),
                variant: HuddleChipVariant.neonDark,
              ),
            ],
          ),
          const SizedBox(height: 18),

          // 100px Hero Neon Cartoon Character with glowing aura
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: _selectedAuraColor.withValues(alpha: 0.35),
                      blurRadius: 16,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: HuddleAvatar(
                  seed: seed,
                  size: 100,
                  vibe: _selectedVibe,
                  neonColor: _selectedAuraColor,
                  showOnline: true,
                ),
              ),
              InkWell(
                onTap: _openAvatarStudioModal,
                borderRadius: BorderRadius.circular(999),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _selectedAuraColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: const [HuddleTheme.shadowCyan],
                  ),
                  child: const Icon(
                    Icons.palette_outlined,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Name & Handle
          Text(
            persona.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: HuddleTheme.displayHeading(
              fontSize: 22,
            ).copyWith(color: Colors.white),
          ),
          const SizedBox(height: 2),
          Text(
            persona.handle,
            style: HuddleTheme.monoLabel(color: HuddleTheme.neonCyan).copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),

          // Major and Year
          Text(
            '${persona.major} · ${persona.year}',
            textAlign: TextAlign.center,
            style: HuddleTheme.body14(
              color: HuddleTheme.neonTextMuted,
            ).copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 14),

          // Bio Quote
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: HuddleTheme.neonCardAlt,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: HuddleTheme.neonCyan.withValues(alpha: 0.3),
                width: 1.5,
              ),
            ),
            child: Text(
              '"${persona.bio}"',
              textAlign: TextAlign.center,
              style: HuddleTheme.body14(color: Colors.white).copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Action buttons: Customize Look & Endorse Peer
          Row(
            children: [
              Expanded(
                child: HuddleButton(
                  text: 'Customize Look',
                  icon: Icons.palette_outlined,
                  variant: HuddleButtonVariant.neonSubtle,
                  height: 38,
                  onPressed: _openAvatarStudioModal,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: HuddleButton(
                  text: 'Endorse Peer',
                  icon: Icons.star_outlined,
                  variant: HuddleButtonVariant.neon,
                  height: 38,
                  onPressed: () => _showEndorseDialog(persona),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 2. Persona Selector
  Widget _buildPersonaSelector(StudentPersona current) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(
          text: 'SWITCH CAMPUS PERSONA',
          color: HuddleTheme.neonCyan,
          trailing: Text(
            '${FakeData.personas.length} students',
            style: HuddleTheme.monoLabel(
              color: HuddleTheme.neonTextMuted,
            ).copyWith(fontSize: 10),
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final p in FakeData.personas)
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      UserService.instance.selectPersona(p);
                      setState(() {
                        _previewSeed = p.name;
                      });
                    },
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: p.name == current.name
                            ? HuddleTheme.neonCyan
                            : HuddleTheme.neonCard,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: p.name == current.name
                              ? HuddleTheme.neonCyan
                              : HuddleTheme.neonCyan.withValues(alpha: 0.3),
                          width: 1.5,
                        ),
                        boxShadow: p.name == current.name
                            ? const [HuddleTheme.shadowCyan]
                            : null,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          HuddleAvatar(
                            seed: p.name,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            p.name.split(' ').first,
                            style:
                                HuddleTheme.monoLabel(
                                  color: p.name == current.name
                                      ? HuddleTheme.neonBg
                                      : Colors.white,
                                ).copyWith(
                                  fontSize: 12,
                                  fontWeight: p.name == current.name
                                      ? FontWeight.w700
                                      : FontWeight.w500,
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
      ],
    );
  }

  // 3. Verified Karma & Streak Header
  Widget _buildKarmaHeader(StudentPersona persona) {
    return HuddleCard(
      color: HuddleTheme.neonCard,
      border: HuddleTheme.borderCyanSubtle,
      boxShadow: const [HuddleTheme.shadowCyan],
      padding: const EdgeInsets.all(18),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 560;
          if (isNarrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.verified_outlined,
                          size: 18,
                          color: HuddleTheme.neonCyan,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'VERIFIED KARMA',
                          style: HuddleTheme.monoLabel(
                            color: HuddleTheme.neonCyan,
                          ).copyWith(
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    HuddleChip(
                      label: persona.karmaRank,
                      variant: HuddleChipVariant.neonDark,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          persona.karmaScore.toStringAsFixed(2),
                          style: HuddleTheme.displayHeading(
                            fontSize: 30,
                          ).copyWith(color: Colors.white),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '/ 5.00',
                          style: HuddleTheme.monoLabel(
                            color: HuddleTheme.neonTextMuted,
                          ).copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'STUDY STREAK',
                          style: HuddleTheme.monoLabel(
                            color: HuddleTheme.neonTextMuted,
                          ).copyWith(fontSize: 10),
                        ),
                        const SizedBox(height: 4),
                        StreakCounter(streakDays: persona.streakDays),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    for (int i = 0; i < 5; i++)
                      const Text(
                        '◆ ',
                        style: TextStyle(
                          color: HuddleTheme.neonCyan,
                          fontSize: 13,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                const _NeonEqualizerGraph(height: 38),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left: Karma Score & Verified Badge
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.verified_outlined,
                              size: 18,
                              color: HuddleTheme.neonCyan,
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                'VERIFIED KARMA',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: HuddleTheme.monoLabel(
                                  color: HuddleTheme.neonCyan,
                                ).copyWith(
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.end,
                          children: [
                            Text(
                              persona.karmaScore.toStringAsFixed(2),
                              style: HuddleTheme.displayHeading(
                                fontSize: 30,
                              ).copyWith(color: Colors.white),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '/ 5.00',
                              style: HuddleTheme.monoLabel(
                                color: HuddleTheme.neonTextMuted,
                              ).copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 6,
                          runSpacing: 4,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                for (int i = 0; i < 5; i++)
                                  const Text(
                                    '◆ ',
                                    style: TextStyle(
                                      color: HuddleTheme.neonCyan,
                                      fontSize: 13,
                                    ),
                                  ),
                              ],
                            ),
                            HuddleChip(
                              label: persona.karmaRank,
                              variant: HuddleChipVariant.neonDark,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width: 1,
                    height: 72,
                    color: HuddleTheme.neonCyan.withValues(alpha: 0.25),
                  ),
                  const SizedBox(width: 16),

                  // Right: Study Streak
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'STUDY STREAK',
                        style: HuddleTheme.monoLabel(
                          color: HuddleTheme.neonTextMuted,
                        ).copyWith(fontSize: 10),
                      ),
                      const SizedBox(height: 6),
                      StreakCounter(streakDays: persona.streakDays),
                      const SizedBox(height: 4),
                      Text(
                        'Active daily',
                        style: HuddleTheme.body14(
                          color: HuddleTheme.neonTextMuted,
                        ).copyWith(fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const _NeonEqualizerGraph(height: 38),
            ],
          );
        },
      ),
    );
  }

  // 4. Verified Metrics Breakdown (4 Clean Cards)
  Widget _buildMetricsBreakdown(StudentPersona persona) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel(
          text: 'VERIFIED STUDY BREAKDOWN',
          color: HuddleTheme.neonCyan,
        ),
        const SizedBox(height: 10),
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 600;
            return GridView.count(
              crossAxisCount: isWide ? 4 : 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: isWide ? 1.6 : 1.8,
              children: [
                _buildMetricTile(
                  label: 'HOURS FOCUSED',
                  value: '${persona.focusHours.toStringAsFixed(1)}h',
                  icon: Icons.timer_outlined,
                ),
                _buildMetricTile(
                  label: 'QUIZZES ACED',
                  value: '${persona.quizzesAced}',
                  icon: Icons.check_circle_outline,
                ),
                _buildMetricTile(
                  label: 'SQUADS JOINED',
                  value: '${persona.squadsJoined}',
                  icon: Icons.group_outlined,
                ),
                _buildMetricTile(
                  label: 'REELS WATCHED',
                  value: '${(persona.quizzesAced * 1.5).round() + 8}',
                  icon: Icons.movie_outlined,
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildMetricTile({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return HuddleCard(
      color: HuddleTheme.neonCard,
      border: HuddleTheme.borderCyanSubtle,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: HuddleTheme.neonCardAlt,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: HuddleTheme.neonCyan.withValues(alpha: 0.4),
                width: 1.2,
              ),
            ),
            child: Icon(icon, size: 20, color: HuddleTheme.neonCyan),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    value,
                    style: HuddleTheme.monoTimer(
                      fontSize: 18,
                    ).copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: HuddleTheme.monoLabel(
                      color: HuddleTheme.neonTextMuted,
                    ).copyWith(fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 5. Badges Grid (Clean responsive achievement cards)
  Widget _buildBadgesGrid(StudentPersona persona) {
    final defaultBadges = [
      {
        'title': 'Night Owl',
        'desc': 'Late-night Pomodoro sprint',
        'date': 'Oct 28',
        'icon': Icons.nightlight_outlined,
      },
      {
        'title': 'Quiz Master',
        'desc': '10 Try It quizzes aced',
        'date': 'Oct 25',
        'icon': Icons.psychology_outlined,
      },
      {
        'title': 'Squad Anchor',
        'desc': 'Kept crew focused 10+ hrs',
        'date': 'Oct 22',
        'icon': Icons.anchor_outlined,
      },
      {
        'title': 'First Sprint',
        'desc': 'Completed 1st 25m focus',
        'date': 'Oct 15',
        'icon': Icons.timer_outlined,
      },
      {
        'title': 'Karma 4.5+',
        'desc': 'Top 5% peer contributor',
        'date': 'Oct 18',
        'icon': Icons.star_outlined,
      },
      {
        'title': 'Bio Ace',
        'desc': 'Aced Krebs Cycle quiz',
        'date': 'Oct 29',
        'icon': Icons.biotech_outlined,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(
          text: 'EARNED BADGES',
          color: HuddleTheme.neonCyan,
          trailing: Text(
            '${defaultBadges.length} unlocked',
            style: HuddleTheme.monoLabel(
              color: HuddleTheme.neonTextMuted,
            ).copyWith(fontSize: 10),
          ),
        ),
        const SizedBox(height: 10),
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 600;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: defaultBadges.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isWide ? 3 : 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: isWide ? 2.1 : 1.8,
              ),
              itemBuilder: (context, idx) {
                final b = defaultBadges[idx];
                return HuddleCard(
                  color: HuddleTheme.neonCard,
                  border: HuddleTheme.borderCyanSubtle,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: HuddleTheme.neonCardAlt,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: HuddleTheme.neonCyan.withValues(alpha: 0.4),
                            width: 1.5,
                          ),
                        ),
                        child: Icon(
                          b['icon'] as IconData,
                          size: 18,
                          color: HuddleTheme.neonCyan,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                b['title'] as String,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: HuddleTheme.monoLabel(
                                  color: Colors.white,
                                ).copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11,
                                ),
                              ),
                              Text(
                                b['desc'] as String,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: HuddleTheme.body14(
                                  color: HuddleTheme.neonTextMuted,
                                ).copyWith(fontSize: 10),
                              ),
                              Text(
                                b['date'] as String,
                                style: HuddleTheme.monoLabel(
                                  color: HuddleTheme.neonCyan,
                                ).copyWith(fontSize: 9),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  // 6. Tabs Section: "My Reels" and "Goals"
  Widget _buildTabsSection(StudentPersona persona) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 42,
          decoration: BoxDecoration(
            color: HuddleTheme.neonCardAlt,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: HuddleTheme.neonCyan.withValues(alpha: 0.4),
              width: 1.5,
            ),
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: HuddleTheme.neonCyan,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [HuddleTheme.shadowCyan],
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: HuddleTheme.neonBg,
            unselectedLabelColor: HuddleTheme.neonTextMuted,
            labelStyle: HuddleTheme.monoLabel().copyWith(
              fontWeight: FontWeight.w700,
            ),
            unselectedLabelStyle: HuddleTheme.monoLabel(),
            tabs: const [
              Tab(text: 'MY REELS'),
              Tab(text: 'GOALS & SPRINT'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 240,
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildMyReelsTab(),
              _buildGoalsTab(persona),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMyReelsTab() {
    final reels = FakeData.reels;

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: reels.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, idx) {
        final reel = reels[idx];

        return HuddleCard(
          color: HuddleTheme.neonCard,
          border: HuddleTheme.borderCyanSubtle,
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: HuddleTheme.neonCardAlt,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: HuddleTheme.neonCyan.withValues(alpha: 0.4),
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.play_arrow_outlined,
                    color: HuddleTheme.neonCyan,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reel.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: HuddleTheme.body14(color: Colors.white).copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Wrap(
                      spacing: 8,
                      runSpacing: 2,
                      children: [
                        Text(
                          '${reel.durationSeconds}s · ${reel.subject}',
                          style: HuddleTheme.monoLabel(
                            color: HuddleTheme.neonTextMuted,
                          ).copyWith(fontSize: 10),
                        ),
                        Text(
                          '${reel.quizQuestions.length} Questions',
                          style: HuddleTheme.monoLabel(
                            color: HuddleTheme.neonCyan,
                          ).copyWith(fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              HuddleButton(
                text: 'View',
                variant: HuddleButtonVariant.neonSubtle,
                height: 32,
                onPressed: () => context.go('/reels/${reel.id}'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGoalsTab(StudentPersona persona) {
    return HuddleCard(
      color: HuddleTheme.neonCard,
      border: HuddleTheme.borderCyanSubtle,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionLabel(
            text: 'ACTIVE STUDY GOAL',
            color: HuddleTheme.neonCyan,
            trailing: HuddleButton(
              text: 'Edit Goal',
              icon: Icons.edit_outlined,
              variant: HuddleButtonVariant.neonSubtle,
              height: 30,
              onPressed: () => _showEditGoalDialog(persona),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            persona.currentGoal,
            style: HuddleTheme.body14(
              color: Colors.white,
            ).copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Text(
            'SPRINT PROGRESS · 75% COMPLETE',
            style: HuddleTheme.monoLabel(
              color: HuddleTheme.neonTextMuted,
            ).copyWith(fontSize: 10),
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: 0.75,
              minHeight: 8,
              backgroundColor: HuddleTheme.neonCardAlt,
              color: HuddleTheme.neonCyan,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.lightbulb_outlined,
                size: 16,
                color: HuddleTheme.neonCyan,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Daily focus target: 2 Pomodoros with squad',
                  style: HuddleTheme.body14(
                    color: HuddleTheme.neonTextMuted,
                  ).copyWith(fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 7. Peer Endorsements
  Widget _buildEndorsementsSection(StudentPersona persona) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(
          text: 'PEER ENDORSEMENTS',
          color: HuddleTheme.neonCyan,
          trailing: Text(
            '${persona.endorsements.length} quotes',
            style: HuddleTheme.monoLabel(
              color: HuddleTheme.neonTextMuted,
            ).copyWith(fontSize: 10),
          ),
        ),
        const SizedBox(height: 8),
        for (final e in persona.endorsements.take(3))
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: HuddleCard(
              color: HuddleTheme.neonCard,
              border: HuddleTheme.borderCyanSubtle,
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      HuddleChip(
                        label: e.tag,
                        variant: HuddleChipVariant.neonDark,
                      ),
                      Text(
                        e.timeAgo,
                        style: HuddleTheme.monoLabel(
                          color: HuddleTheme.neonTextMuted,
                        ).copyWith(fontSize: 10),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '"${e.quote}"',
                    style: HuddleTheme.body14(color: Colors.white).copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '— ${e.authorName} (${e.authorMajor})',
                    style: HuddleTheme.monoLabel(
                      color: HuddleTheme.neonCyan,
                    ).copyWith(fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

/// Image 1 signature multi-color Neon Frequency Equalizer Wave chart
class _NeonEqualizerGraph extends StatelessWidget {
  final double height;
  const _NeonEqualizerGraph({this.height = 56});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: _NeonEqualizerGraphPainter(),
      ),
    );
  }
}

class _NeonEqualizerGraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = const Color(0xFF23194A)
      ..strokeWidth = 1.0;
    canvas.drawLine(
      Offset(0, size.height * 0.3),
      Offset(size.width, size.height * 0.3),
      gridPaint,
    );
    canvas.drawLine(
      Offset(0, size.height * 0.65),
      Offset(size.width, size.height * 0.65),
      gridPaint,
    );

    final path = Path();
    final points = [
      Offset(0, size.height * 0.85),
      Offset(size.width * 0.08, size.height * 0.70),
      Offset(size.width * 0.16, size.height * 0.35),
      Offset(size.width * 0.24, size.height * 0.75),
      Offset(size.width * 0.32, size.height * 0.20),
      Offset(size.width * 0.40, size.height * 0.60),
      Offset(size.width * 0.48, size.height * 0.15),
      Offset(size.width * 0.58, size.height * 0.50),
      Offset(size.width * 0.68, size.height * 0.25),
      Offset(size.width * 0.78, size.height * 0.65),
      Offset(size.width * 0.88, size.height * 0.40),
      Offset(size.width, size.height * 0.60),
    ];

    path.moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFFE024C3).withValues(alpha: 0.30),
          const Color(0xFF00F0FF).withValues(alpha: 0.08),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawPath(fillPath, fillPaint);

    final linePaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFF00F0FF),
          Color(0xFFFF2A85),
          Color(0xFF8B5CF6),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(path, linePaint);

    final peakIndices = [4, 6, 8];
    final peakColors = [
      const Color(0xFF00F0FF),
      const Color(0xFFFF2A85),
      const Color(0xFF8B5CF6),
    ];
    for (int i = 0; i < peakIndices.length; i++) {
      final p = points[peakIndices[i]];
      final c = peakColors[i];
      canvas.drawCircle(p, 5.0, Paint()..color = c.withValues(alpha: 0.5));
      canvas.drawCircle(p, 2.5, Paint()..color = Colors.white);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
