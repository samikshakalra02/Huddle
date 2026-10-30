import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:huddle_client/huddle_client.dart';
import '../../data/fake_data.dart';
import '../../services/api_service.dart';
import '../../services/user_service.dart';
import '../../theme.dart';
import '../widgets/avatar_stack.dart';
import '../widgets/huddle_button.dart';
import '../widgets/huddle_card.dart';
import '../widgets/huddle_chip.dart';

class SquadMatchScreen extends StatefulWidget {
  final String topic;

  const SquadMatchScreen({super.key, this.topic = 'DSA'});

  @override
  State<SquadMatchScreen> createState() => _SquadMatchScreenState();
}

class _SquadMatchScreenState extends State<SquadMatchScreen> {
  bool _isLoading = true;
  String? _errorMessage;
  List<SquadSuggestion> _deck = [];
  int _cardIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchSuggestions();
  }

  Future<void> _fetchSuggestions() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _cardIndex = 0;
    });

    try {
      final res = await ApiService.instance.suggestSquads(
        topic: widget.topic.isEmpty ? 'DSA' : widget.topic,
        exam: 'Placements',
        timeSlot: '6:00 - 8:00 PM',
      );
      if (mounted) {
        setState(() {
          _deck = res.isNotEmpty ? res : FakeData.squadSuggestions;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _deck = FakeData.squadSuggestions;
          _isLoading = false;
        });
      }
    }
  }

  void _shuffleDeck() {
    HapticFeedback.mediumImpact();
    setState(() {
      _deck.shuffle();
      _cardIndex = 0;
    });
  }

  void _skipCard() {
    HapticFeedback.lightImpact();
    if (_cardIndex < _deck.length - 1) {
      setState(() => _cardIndex++);
    } else {
      setState(() => _cardIndex = _deck.length); // Deck completed
    }
  }

  void _joinSquad(Squad squad) async {
    HapticFeedback.heavyImpact();
    final squadId = squad.id ?? 1;
    final userName = UserService.instance.currentUser.value;

    await ApiService.instance.joinSquad(squadId: squadId, userName: userName);

    if (mounted) {
      context.go('/room/$squadId');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HuddleTheme.neonBg,
      appBar: AppBar(
        backgroundColor: HuddleTheme.neonBg,
        title: Text(
          'SQUAD MATCH DECK',
          style: HuddleTheme.monoLabel(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/feed'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle_rounded, color: HuddleTheme.neonCyan),
            tooltip: 'Shuffle deck',
            onPressed: _shuffleDeck,
          ),
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? _buildLoadingState()
            : _errorMessage != null
            ? _buildErrorState()
            : _buildDeckView(),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: HuddleTheme.neonCard,
              shape: BoxShape.circle,
              border: Border.all(color: HuddleTheme.neonCyan, width: 1.5),
              boxShadow: const [HuddleTheme.shadowCyanGlow],
            ),
            child: const Icon(
              Icons.groups_rounded,
              size: 36,
              color: HuddleTheme.neonCyan,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'MATCHING SQUADS...',
            style: HuddleTheme.monoLabel(color: HuddleTheme.neonTextMuted),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.wifi_off_rounded,
              size: 40,
              color: HuddleTheme.neonMagenta,
            ),
            const SizedBox(height: 16),
            Text(
              'COULD NOT LOAD SQUADS',
              style: HuddleTheme.heading20(color: Colors.white),
            ),
            const SizedBox(height: 16),
            HuddleButton(
              text: 'Retry',
              icon: Icons.refresh_rounded,
              variant: HuddleButtonVariant.neon,
              onPressed: _fetchSuggestions,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeckView() {
    if (_deck.isEmpty || _cardIndex >= _deck.length) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: HuddleTheme.neonCard,
                  shape: BoxShape.circle,
                  border: Border.all(color: HuddleTheme.neonCyan, width: 1.5),
                  boxShadow: const [HuddleTheme.shadowCyanGlow],
                ),
                child: const Icon(
                  Icons.done_all_rounded,
                  size: 40,
                  color: HuddleTheme.neonCyan,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'YOU SAW THE ENTIRE DECK',
                style: HuddleTheme.heading20(color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'Reshuffle the deck or change your topic criteria.',
                style: HuddleTheme.body14(color: HuddleTheme.neonTextMuted),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              HuddleButton(
                text: 'Reshuffle Deck',
                icon: Icons.shuffle_rounded,
                variant: HuddleButtonVariant.neon,
                onPressed: _shuffleDeck,
              ),
            ],
          ),
        ),
      );
    }

    final suggestion = _deck[_cardIndex];
    final squad = suggestion.squad;

    // Deterministic squad member names for avatar stack
    final memberNames = [
      'Ayaan',
      'Priya',
      'Marcus',
      'Sarah',
      'Aisha',
    ].take(suggestion.memberCount).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        final isLaptop = constraints.maxWidth >= 900;

        if (isLaptop) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Pane: Featured Swipe Card (Flex 7)
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildDeckHeader(suggestion),
                      const SizedBox(height: 14),
                      _buildSwipeCard(squad, suggestion, memberNames),
                      const SizedBox(height: 20),
                      _buildActionButtons(squad),
                    ],
                  ),
                ),
                const SizedBox(width: 28),

                // Right Pane: Match Radar & Deck Queue (Flex 5)
                Expanded(
                  flex: 5,
                  child: _buildDeckRadarSidebar(),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildDeckHeader(suggestion),
                  const SizedBox(height: 14),
                  _buildSwipeCard(squad, suggestion, memberNames),
                  const SizedBox(height: 20),
                  _buildActionButtons(squad),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDeckHeader(SquadSuggestion suggestion) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: [
        Text(
          'CARD ${_cardIndex + 1} OF ${_deck.length}',
          style: HuddleTheme.monoLabel(
            color: HuddleTheme.neonTextMuted,
          ),
        ),
        HuddleChip.sticker(
          label: '${suggestion.matchScore}% MATCH',
          variant: HuddleChipVariant.neon,
        ),
      ],
    );
  }

  Widget _buildSwipeCard(
    Squad squad,
    SquadSuggestion suggestion,
    List<String> memberNames,
  ) {
    return Semantics(
      label:
          'Squad match: ${squad.name}. ${suggestion.matchScore}% match. Why you matched: ${suggestion.matchReason}. Swipe right to join, left to skip.',
      child: Dismissible(
        key: ValueKey(squad.id ?? _cardIndex),
        direction: DismissDirection.horizontal,
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            _skipCard();
          } else {
            _joinSquad(squad);
          }
        },
        background: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 32),
          decoration: BoxDecoration(
            color: HuddleTheme.neonCyan.withValues(alpha: 0.2),
            borderRadius: HuddleTheme.radius14,
            border: Border.all(
              color: HuddleTheme.neonCyan,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.check_rounded,
                size: 32,
                color: HuddleTheme.neonCyan,
              ),
              const SizedBox(width: 8),
              Text(
                'JOIN SQUAD',
                style: HuddleTheme.monoLabel(
                  color: HuddleTheme.neonCyan,
                ),
              ),
            ],
          ),
        ),
        secondaryBackground: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 32),
          decoration: BoxDecoration(
            color: HuddleTheme.neonMagenta.withValues(alpha: 0.2),
            borderRadius: HuddleTheme.radius14,
            border: Border.all(
              color: HuddleTheme.neonMagenta,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'SKIP',
                style: HuddleTheme.monoLabel(
                  color: HuddleTheme.neonMagenta,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.close_rounded,
                size: 32,
                color: HuddleTheme.neonMagenta,
              ),
            ],
          ),
        ),
        child: HuddleCard(
          color: HuddleTheme.neonCard,
          border: HuddleTheme.borderCyanSubtle,
          boxShadow: const [HuddleTheme.shadowCyanGlow],
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Squad Name & Topic
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          squad.name,
                          style: HuddleTheme.heading28(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          squad.topic,
                          style: HuddleTheme.body16(
                            color: HuddleTheme.neonCyan,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  HuddleChip(
                    label: squad.targetExam,
                    variant: HuddleChipVariant.neon,
                    icon: Icons.flag_rounded,
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // "Why You Matched" Callout Card
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: HuddleTheme.neonCardAlt,
                  borderRadius: HuddleTheme.radius14,
                  border: Border.all(
                    color: HuddleTheme.neonCyan.withValues(alpha: 0.35),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.auto_awesome_rounded,
                      color: HuddleTheme.neonCyan,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'WHY YOU MATCHED',
                            style: HuddleTheme.monoLabel(
                              color: HuddleTheme.neonCyan,
                            ).copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            suggestion.matchReason,
                            style: HuddleTheme.body14(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // Members AvatarStack Row
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 12,
                runSpacing: 10,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'STUDY CREW (${suggestion.memberCount}/${squad.maxMembers})',
                        style: HuddleTheme.monoLabel(
                          color: HuddleTheme.neonTextMuted,
                        ).copyWith(fontSize: 10),
                      ),
                      const SizedBox(height: 6),
                      AvatarStack(
                        names: memberNames,
                        avatarSize: 32,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DAILY STREAK',
                        style: HuddleTheme.monoLabel(
                          color: HuddleTheme.neonTextMuted,
                        ).copyWith(fontSize: 10),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.local_fire_department_rounded,
                            size: 18,
                            color: HuddleTheme.neonMagenta,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${squad.streak} DAYS',
                            style: HuddleTheme.monoLabel(
                              color: HuddleTheme.neonMagenta,
                            ).copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Details: Time Slot & Current Goal
              _detailRow(
                Icons.schedule_rounded,
                'TIME SLOT',
                squad.timeSlot,
              ),
              const SizedBox(height: 8),
              _detailRow(
                Icons.track_changes_rounded,
                'SPRINT GOAL',
                '${squad.goal} (${squad.currentGoalCount} completed)',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(Squad squad) {
    return Row(
      children: [
        Expanded(
          child: HuddleButton(
            text: 'Skip',
            icon: Icons.close_rounded,
            variant: HuddleButtonVariant.neonSubtle,
            onPressed: _skipCard,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: HuddleButton(
            text: 'Join Squad',
            icon: Icons.groups_rounded,
            variant: HuddleButtonVariant.neon,
            onPressed: () => _joinSquad(squad),
          ),
        ),
      ],
    );
  }

  Widget _buildDeckRadarSidebar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        HuddleCard(
          color: HuddleTheme.neonCard,
          border: HuddleTheme.borderCyanSubtle,
          boxShadow: const [HuddleTheme.shadowCyanGlow],
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'STUDY RADAR',
                    style: HuddleTheme.monoLabel(color: HuddleTheme.neonCyan).copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const HuddleChip(
                    label: 'LIVE',
                    variant: HuddleChipVariant.neon,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'TARGET EXAM · PLACEMENTS',
                style: HuddleTheme.monoLabel(color: Colors.white).copyWith(fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                'Matching ${widget.topic} candidates in your campus quad.',
                style: HuddleTheme.body14(color: HuddleTheme.neonTextMuted),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: [
                  HuddleChip(
                    label: widget.topic,
                    variant: HuddleChipVariant.neon,
                    icon: Icons.code_rounded,
                  ),
                  const HuddleChip(
                    label: '6:00 - 8:00 PM',
                    variant: HuddleChipVariant.neonDark,
                    icon: Icons.schedule_rounded,
                  ),
                  const HuddleChip(
                    label: '25m Pomodoro',
                    variant: HuddleChipVariant.neonDark,
                    icon: Icons.timer_outlined,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'UPCOMING IN THIS DECK',
          style: HuddleTheme.monoLabel(color: HuddleTheme.neonCyan).copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        for (int i = 0; i < _deck.length; i++)
          if (i != _cardIndex)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: InkWell(
                onTap: () => setState(() => _cardIndex = i),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: HuddleTheme.neonCardAlt,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: HuddleTheme.neonCyan.withValues(alpha: 0.25),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _deck[i].squad.name,
                              style: HuddleTheme.body14(color: Colors.white)
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              _deck[i].squad.topic,
                              style: HuddleTheme.monoLabel(
                                color: HuddleTheme.neonCyan,
                              ).copyWith(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      HuddleChip(
                        label: '${_deck[i].matchScore}%',
                        variant: HuddleChipVariant.neonDark,
                      ),
                    ],
                  ),
                ),
              ),
            ),
      ],
    );
  }

  Widget _detailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: HuddleTheme.neonCyan),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: HuddleTheme.monoLabel(
            color: HuddleTheme.neonTextMuted,
          ).copyWith(fontSize: 11),
        ),
        Expanded(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: HuddleTheme.body14(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
