import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:huddle_client/huddle_client.dart';
import '../../data/fake_data.dart';
import '../../services/api_service.dart';
import '../../services/user_service.dart';
import '../../theme.dart';
import '../widgets/avatar_stack.dart';
import '../widgets/event_card.dart';
import '../widgets/huddle_avatar.dart';
import '../widgets/huddle_button.dart';
import '../widgets/huddle_chip.dart';
import '../widgets/reel_card.dart';
import '../widgets/section_label.dart';
import '../widgets/serverpod_badge.dart';
import '../widgets/ticker.dart';
import 'try_it_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  String? _errorMessage;
  List<Reel> _reels = [];
  List<CampusEvent> _events = [];
  String _selectedCategory = 'All';

  final List<Map<String, dynamic>> _categories = [
    {'name': 'All', 'icon': Icons.grid_view_rounded},
    {'name': 'DSA', 'icon': Icons.code_rounded},
    {'name': 'ML Lab', 'icon': Icons.psychology_rounded},
    {'name': 'DBMS', 'icon': Icons.dataset_rounded},
    {'name': 'OS Systems', 'icon': Icons.memory_rounded},
    {'name': 'Interview', 'icon': Icons.work_rounded},
  ];

  @override
  void initState() {
    super.initState();
    _loadFeed();
  }

  Future<void> _loadFeed({bool forceRefresh = false}) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final feed = await ApiService.instance.getFeed(
        forceRefresh: forceRefresh,
      );
      if (mounted) {
        setState(() {
          _reels = feed.reels.isNotEmpty ? feed.reels : FakeData.reels;
          _events = feed.events.isNotEmpty ? feed.events : FakeData.events;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _reels = FakeData.reels;
          _events = FakeData.events;
          _isLoading = false;
        });
      }
    }
  }

  void _onStudyTogether(String topic) {
    context.go('/match?topic=${Uri.encodeComponent(topic)}');
  }

  void _openQuiz(Reel reel) {
    TryItSheet.show(
      context,
      reel: reel,
      onFindSquad: _onStudyTogether,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktopThreeCol = width >= 1350;
    final isTwoColumn = width >= 900;
    final isMobile = width < 600;

    return Scaffold(
      backgroundColor: HuddleTheme.neonBg,
      appBar: isMobile
          ? AppBar(
              backgroundColor: HuddleTheme.neonBg,
              titleSpacing: 16,
              title: const ServerpodBadge(height: 28, showLabel: false),
              actions: [
                IconButton(
                  tooltip: 'Search topics and squads',
                  icon: const Icon(Icons.search_rounded),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Search campus reels and squads',
                          style: HuddleTheme.monoLabel(color: Colors.white),
                        ),
                        backgroundColor: HuddleTheme.ink,
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),
                IconButton(
                  tooltip: 'Campus notifications',
                  icon: const Icon(Icons.notifications_none_rounded),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'All caught up! 8 squad sessions active now.',
                          style: HuddleTheme.monoLabel(color: Colors.white),
                        ),
                        backgroundColor: HuddleTheme.ink,
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),
                ValueListenableBuilder<String>(
                  valueListenable: UserService.instance.currentUser,
                  builder: (context, name, _) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12, left: 4),
                      child: InkWell(
                        onTap: () => context.go('/login'),
                        borderRadius: BorderRadius.circular(999),
                        child: HuddleAvatar(
                          seed: UserService.instance.effectiveAvatarSeed,
                          size: 28,
                          showOnline: true,
                        ),
                      ),
                    );
                  },
                ),
              ],
            )
          : null,
      body: SafeArea(
        child: Column(
          children: [
            // Live Ticker Strip
            Ticker(items: FakeData.tickerItems),

            // Pull to refresh feed
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => _loadFeed(forceRefresh: true),
                color: HuddleTheme.ink,
                backgroundColor: HuddleTheme.highlight,
                child: isDesktopThreeCol
                    ? _buildThreeColumnFeed()
                    : isTwoColumn
                    ? _buildTwoColumnFeed()
                    : _buildSingleColumnFeed(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // PHONE (<720): Single Column Layout
  Widget _buildSingleColumnFeed() {
    if (_isLoading) return _buildSkeletonLoader();
    if (_errorMessage != null) return _buildErrorState();
    if (_reels.isEmpty && _events.isEmpty) return _buildEmptyState();

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      children: [
        _buildHeroHeader(),
        const SizedBox(height: 14),
        _buildStatsMetricGrid(),
        const SizedBox(height: 16),
        _buildCategoriesRow(),
        const SizedBox(height: 16),
        _buildQuickCtaBar(),
        const SizedBox(height: 24),

        // Mixed Interleaved Vertical Feed
        const SectionLabel(
          text: 'CAMPUS FEED (REELS & EVENTS)',
          icon: Icons.dynamic_feed_rounded,
        ),
        const SizedBox(height: 12),

        ..._buildInterleavedFeedItems(isTwoColumn: false),

        const SizedBox(height: 24),
      ],
    );
  }

  // TABLET / MID SCREEN (720 - 1149): Two Column Layout
  Widget _buildTwoColumnFeed() {
    if (_isLoading) return _buildSkeletonLoader();
    if (_errorMessage != null) return _buildErrorState();
    if (_reels.isEmpty && _events.isEmpty) return _buildEmptyState();

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      children: [
        _buildHeroHeader(),
        const SizedBox(height: 16),
        _buildStatsMetricGrid(),
        const SizedBox(height: 18),
        _buildCategoriesRow(),
        const SizedBox(height: 18),
        _buildQuickCtaBar(),
        const SizedBox(height: 32),

        // Two Column Grid: Left Reels, Right Events
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column: Peer Reels
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionLabel(
                    text: 'PEER REELS (30-60S QUIZ)',
                    icon: Icons.movie_rounded,
                  ),
                  const SizedBox(height: 12),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _filteredReels.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      final reel = _filteredReels[index];
                      return ReelCard(
                        reel: reel,
                        onStudyTogether: _onStudyTogether,
                        onOpenQuiz: () => _openQuiz(reel),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),

            // Right Column: Campus Events
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionLabel(
                    text: 'CAMPUS EVENTS & WORKSHOPS',
                    icon: Icons.event_rounded,
                  ),
                  const SizedBox(height: 12),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _events.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      return EventCard(event: _events[index]);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // LAPTOP & DESKTOP (>= 1150): Full-Screen Three Column Layout
  Widget _buildThreeColumnFeed() {
    if (_isLoading) return _buildSkeletonLoader();
    if (_errorMessage != null) return _buildErrorState();
    if (_reels.isEmpty && _events.isEmpty) return _buildEmptyState();

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
      children: [
        _buildHeroHeader(),
        const SizedBox(height: 16),
        _buildStatsMetricGrid(),
        const SizedBox(height: 20),
        _buildCategoriesRow(),
        const SizedBox(height: 18),
        _buildQuickCtaBar(),
        const SizedBox(height: 28),

        // Three Column Grid: Left Reels (flex 4), Center Events (flex 4), Right Live Squads & Leaderboard (flex 3)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Column 1: Peer Reels
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionLabel(
                    text: 'PEER REELS (30-60S QUIZ)',
                    icon: Icons.movie_rounded,
                  ),
                  const SizedBox(height: 12),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _filteredReels.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      final reel = _filteredReels[index];
                      return ReelCard(
                        reel: reel,
                        onStudyTogether: _onStudyTogether,
                        onOpenQuiz: () => _openQuiz(reel),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),

            // Column 2: Campus Events
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionLabel(
                    text: 'CAMPUS EVENTS & WORKSHOPS',
                    icon: Icons.event_rounded,
                  ),
                  const SizedBox(height: 12),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _events.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      return EventCard(event: _events[index]);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),

            // Column 3: Live Squads & Leaderboard
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionLabel(
                    text: 'ACTIVE SQUAD CREWS',
                    icon: Icons.groups_rounded,
                  ),
                  const SizedBox(height: 12),
                  ...FakeData.squadSuggestions.take(4).map(
                        (s) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildSquadSidebarCard(s),
                        ),
                      ),
                  const SizedBox(height: 16),
                  const SectionLabel(
                    text: 'CAMPUS STUDY LEADERS',
                    icon: Icons.emoji_events_rounded,
                  ),
                  const SizedBox(height: 12),
                  _buildLeaderboardCard(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // NEON STATS METRICS GRID (IMAGE 1 SPEC)
  Widget _buildStatsMetricGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final itemWidth = w >= 900
            ? (w - 36) / 4
            : (w - 12) / 2;

        final metrics = [
          {
            'label': 'SQUADS ACTIVE',
            'value': '8 CREWS',
            'sub': '18 focusing right now',
            'icon': Icons.groups_rounded,
            'color': HuddleTheme.neonCyan,
          },
          {
            'label': 'FOCUS MINS TODAY',
            'value': '2,840 MIN',
            'sub': 'Across 4 campuses',
            'icon': Icons.timer_outlined,
            'color': HuddleTheme.neonMagenta,
          },
          {
            'label': 'CAMPUS REELS',
            'value': '12 REELS',
            'sub': 'With 3-question quiz',
            'icon': Icons.smart_display_rounded,
            'color': HuddleTheme.neonViolet,
          },
          {
            'label': 'LIVE EVENTS',
            'value': '8 WORKSHOPS',
            'sub': 'ACM, GDSC & Labs',
            'icon': Icons.event_available_rounded,
            'color': HuddleTheme.neonSky,
          },
        ];

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: metrics.map((m) {
            final color = m['color'] as Color;
            return SizedBox(
              width: itemWidth,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: HuddleTheme.neonCard,
                  borderRadius: HuddleTheme.radius14,
                  border: Border.all(
                    color: color.withValues(alpha: 0.5),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.15),
                      offset: const Offset(0, 2),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: color, width: 1.5),
                      ),
                      child: Icon(
                        m['icon'] as IconData,
                        color: color,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            m['label'] as String,
                            style: HuddleTheme.monoLabel(
                              color: HuddleTheme.neonTextMuted,
                            ).copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            m['value'] as String,
                            style: HuddleTheme.heading20(
                              color: Colors.white,
                            ).copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            m['sub'] as String,
                            style: HuddleTheme.body14(
                              color: Colors.white60,
                            ).copyWith(fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildSquadSidebarCard(SquadSuggestion s) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: HuddleTheme.neonCard,
        borderRadius: HuddleTheme.radius14,
        border: Border.all(
          color: HuddleTheme.neonCyan.withValues(alpha: 0.35),
          width: 1.5,
        ),
        boxShadow: const [HuddleTheme.shadowCyan],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  s.squad.name,
                  style: HuddleTheme.heading20(
                    color: Colors.white,
                  ).copyWith(fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              HuddleChip(
                label: s.squad.topic,
                variant: HuddleChipVariant.neon,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              AvatarStack(
                names: FakeData.roomMembers
                    .map((m) => m.userName)
                    .take(s.memberCount)
                    .toList(),
                avatarSize: 26,
                maxVisible: 3,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${s.memberCount} peers focusing',
                  style: HuddleTheme.monoLabel(
                    color: HuddleTheme.neonTextMuted,
                  ).copyWith(fontSize: 11),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
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
                    Icons.local_fire_department_rounded,
                    size: 16,
                    color: HuddleTheme.neonMagenta,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${s.squad.streak}d streak',
                    style: HuddleTheme.monoLabel(
                      color: HuddleTheme.neonMagenta,
                    ).copyWith(fontSize: 11),
                  ),
                ],
              ),
              SizedBox(
                height: 28,
                child: HuddleButton(
                  text: 'Enter Room',
                  variant: HuddleButtonVariant.neonSubtle,
                  onPressed: () => context.go('/room/${s.squad.id}'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboardCard() {
    final leaders = [
      {
        'name': 'Aisha Rahman',
        'karma': '1,420',
        'streak': '14d',
        'focus': '48h',
      },
      {'name': 'Dev Patel', 'karma': '1,180', 'streak': '11d', 'focus': '42h'},
      {'name': 'Maya Chen', 'karma': '960', 'streak': '9d', 'focus': '35h'},
      {'name': 'Liam Vance', 'karma': '840', 'streak': '7d', 'focus': '30h'},
    ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: HuddleTheme.neonCard,
        borderRadius: HuddleTheme.radius14,
        border: Border.all(
          color: HuddleTheme.neonViolet.withValues(alpha: 0.4),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          for (int i = 0; i < leaders.length; i++) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: i == 0
                          ? HuddleTheme.neonMagenta
                          : HuddleTheme.neonCardAlt,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${i + 1}',
                      style: HuddleTheme.monoLabel(
                        color: Colors.white,
                      ).copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  HuddleAvatar(seed: leaders[i]['name']!, size: 26),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          leaders[i]['name']!,
                          style: HuddleTheme.body14(
                            color: Colors.white,
                          ).copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${leaders[i]['focus']} logged',
                          style: HuddleTheme.monoLabel(
                            color: HuddleTheme.neonTextMuted,
                          ).copyWith(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${leaders[i]['karma']} KP',
                          style: HuddleTheme.monoLabel(
                            color: HuddleTheme.neonCyan,
                          ).copyWith(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                        ),
                        Text(
                          '🔥 ${leaders[i]['streak']}',
                          style: HuddleTheme.monoLabel(
                            color: HuddleTheme.neonMagenta,
                          ).copyWith(fontSize: 10),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (i < leaders.length - 1)
              const Divider(color: Colors.white12, height: 10),
          ],
        ],
      ),
    );
  }

  List<Reel> get _filteredReels {
    if (_selectedCategory == 'All') return _reels;
    return _reels.where((r) {
      final subject = r.subject.toLowerCase();
      final cat = _selectedCategory.toLowerCase();
      return subject.contains(cat) || cat.contains(subject);
    }).toList();
  }

  List<Widget> _buildInterleavedFeedItems({required bool isTwoColumn}) {
    final filtered = _filteredReels;
    final items = <Widget>[];
    final maxLen = filtered.length > _events.length
        ? filtered.length
        : _events.length;

    for (int i = 0; i < maxLen; i++) {
      if (i < filtered.length) {
        final reel = filtered[i];
        items.add(
          ReelCard(
            reel: reel,
            onStudyTogether: _onStudyTogether,
            onOpenQuiz: () => _openQuiz(reel),
          ),
        );
        items.add(const SizedBox(height: 18));
      }
      if (i < _events.length) {
        items.add(EventCard(event: _events[i]));
        items.add(const SizedBox(height: 18));
      }
    }

    return items;
  }

  Widget _buildHeroHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // One tilted sticker chip per screen max
        const HuddleChip.sticker(
          label: 'CAMPUS SQUAD LIVE',
          variant: HuddleChipVariant.neon,
        ),
        const SizedBox(height: 10),
        Text(
          'Find your squad',
          style: HuddleTheme.displayHero(color: Colors.white),
        ),
        const SizedBox(height: 6),
        Text(
          '30-60s micro-lessons · Synced rooms · Live campus crews',
          style: HuddleTheme.body16(color: HuddleTheme.neonTextMuted).copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesRow() {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: _categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final cat = _categories[index];
          final name = cat['name'] as String;
          final icon = cat['icon'] as IconData;
          final isSelected = name == _selectedCategory;

          return HuddleChip(
            label: name,
            icon: icon,
            variant: isSelected
                ? HuddleChipVariant.neon
                : HuddleChipVariant.neonDark,
            onTap: () {
              setState(() => _selectedCategory = name);
            },
          );
        },
      ),
    );
  }

  Widget _buildQuickCtaBar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 420;
        return Wrap(
          spacing: 12,
          runSpacing: 10,
          children: [
            SizedBox(
              width: isNarrow
                  ? double.infinity
                  : (constraints.maxWidth - 12) / 2,
              child: HuddleButton(
                text: 'Join Squad Room',
                icon: Icons.timer_outlined,
                variant: HuddleButtonVariant.neon,
                onPressed: () => context.go('/room/1'),
              ),
            ),
            SizedBox(
              width: isNarrow
                  ? double.infinity
                  : (constraints.maxWidth - 12) / 2,
              child: HuddleButton(
                text: 'Browse Match Deck',
                icon: Icons.view_carousel_outlined,
                variant: HuddleButtonVariant.neonSubtle,
                onPressed: () => context.go('/match'),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSkeletonLoader() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          width: 120,
          height: 24,
          decoration: BoxDecoration(
            color: HuddleTheme.ink.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          height: 48,
          decoration: BoxDecoration(
            color: HuddleTheme.ink.withValues(alpha: 0.1),
            borderRadius: HuddleTheme.radius14,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          height: 380,
          decoration: BoxDecoration(
            color: HuddleTheme.ink.withValues(alpha: 0.08),
            borderRadius: HuddleTheme.radius14,
            border: Border.all(color: HuddleTheme.ink, width: 1.5),
          ),
          alignment: Alignment.center,
          child: Text(
            'LOADING CAMPUS SQUADS...',
            style: HuddleTheme.monoLabel(),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: HuddleTheme.highlight,
                shape: BoxShape.circle,
                border: Border.all(color: HuddleTheme.ink, width: 1.5),
              ),
              child: const Icon(
                Icons.wifi_off_rounded,
                size: 36,
                color: HuddleTheme.ink,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'COULD NOT LOAD FEED',
              style: HuddleTheme.heading20(),
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage ?? 'Check your campus connection or run Serverpod',
              textAlign: TextAlign.center,
              style: HuddleTheme.body14(),
            ),
            const SizedBox(height: 20),
            HuddleButton(
              text: 'Run it back',
              icon: Icons.refresh_rounded,
              variant: HuddleButtonVariant.accent,
              onPressed: () => _loadFeed(forceRefresh: true),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.groups_rounded, size: 48, color: HuddleTheme.ink),
            const SizedBox(height: 14),
            Text('NO SQUADS LIVE YET', style: HuddleTheme.heading20()),
            const SizedBox(height: 6),
            Text(
              'Be the first to start a focus room or post a 45s reel.',
              textAlign: TextAlign.center,
              style: HuddleTheme.body14(),
            ),
            const SizedBox(height: 18),
            HuddleButton(
              text: 'Refresh Feed',
              icon: Icons.refresh_rounded,
              variant: HuddleButtonVariant.accent,
              onPressed: () => _loadFeed(forceRefresh: true),
            ),
          ],
        ),
      ),
    );
  }
}
