import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../data/fake_data.dart';
import '../../theme.dart';
import '../widgets/event_card.dart';
import '../widgets/huddle_avatar.dart';
import '../widgets/huddle_button.dart';
import '../widgets/huddle_card.dart';
import '../widgets/huddle_chip.dart';
import '../widgets/reel_card.dart';
import '../widgets/section_label.dart';
import '../widgets/serverpod_badge.dart';
import '../widgets/ticker.dart';
import '../widgets/timer_ring.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HuddleTheme.neonBg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Brand Bar with Serverpod Badge
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: HuddleTheme.neonCard,
                  border: Border(
                    bottom: BorderSide(
                      color: HuddleTheme.neonCyan.withValues(alpha: 0.3),
                      width: 1.5,
                    ),
                  ),
                ),
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 12,
                  runSpacing: 10,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        const ServerpodBadge(size: 28, showLabel: false),
                        Text(
                          'HUDDLE',
                          style: HuddleTheme.displayHeading(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        const HuddleChip(
                          label: 'CAMPUS',
                          variant: HuddleChipVariant.neon,
                        ),
                      ],
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        HuddleButton(
                          text: 'Explore reels',
                          variant: HuddleButtonVariant.neonSubtle,
                          height: 38,
                          icon: Icons.movie_outlined,
                          onPressed: () => context.go('/reels/1'),
                        ),
                        HuddleButton(
                          text: 'Log In / Lock In',
                          icon: Icons.bolt_rounded,
                          variant: HuddleButtonVariant.neon,
                          height: 38,
                          onPressed: () => context.go('/login'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Live Ticker Strip
              const Ticker(
                items: [
                  '🔥 14-DAY STREAK ON LEETCODE SPRINT',
                  '⚡ 3 OF 4 FOCUSING IN SQUAD ROOM',
                  '🍕 HACK NIGHT STARTS IN 3 HOURS',
                  '🧠 28 STUDENTS ACED OS DEADLOCK QUIZ',
                  '🚀 POWERED BY SERVERPOD REALTIME STREAMS',
                ],
              ),

              // Hero Section
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 40,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1600),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const HuddleChip.sticker(
                          label: 'STUDENT PEER LEARNING',
                          variant: HuddleChipVariant.neon,
                          angleDegrees: -2.0,
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'Study squads\nthat actually\nlock in.',
                          style: HuddleTheme.displayHero(
                            fontSize: 48,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 18),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 680),
                          child: Text(
                            'Peer-created 30-60s micro-lessons, live 25-minute Pomodoro study rooms, and match decks by exam deadline.',
                            style: HuddleTheme.body16().copyWith(
                              fontSize: 18,
                              height: 1.5,
                              color: HuddleTheme.neonTextMuted,
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),

                        // Two Strong CTAs
                        Wrap(
                          spacing: 14,
                          runSpacing: 12,
                          children: [
                            HuddleButton(
                              text: 'Find your squad',
                              icon: Icons.bolt_outlined,
                              variant: HuddleButtonVariant.neon,
                              height: 48,
                              onPressed: () => context.go('/match'),
                            ),
                            HuddleButton(
                              text: 'Watch peer reels',
                              icon: Icons.play_arrow_outlined,
                              variant: HuddleButtonVariant.neonSubtle,
                              height: 48,
                              onPressed: () => context.go('/reels/1'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Real App Mockup Built from Real Widgets (Not an image screenshot)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1600),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionLabel(
                          text: 'LIVE APP PREVIEW · REAL WIDGETS',
                          color: HuddleTheme.neonCyan,
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: HuddleTheme.neonCard,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: HuddleTheme.neonCyan.withValues(alpha: 0.3),
                              width: 1.5,
                            ),
                            boxShadow: const [HuddleTheme.shadowCyanGlow],
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Mockup 1: Real ReelCard
                                SizedBox(
                                  width: 320,
                                  child: ReelCard(reel: FakeData.reels.first),
                                ),
                                const SizedBox(width: 16),

                                // Mockup 2: Real Squad Room Pomodoro Card
                                SizedBox(
                                  width: 320,
                                  child: HuddleCard(
                                    color: HuddleTheme.neonCardAlt,
                                    border: HuddleTheme.borderCyanSubtle,
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                'SYSTEMS SPRINT',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: HuddleTheme.monoLabel(
                                                  color: Colors.white,
                                                ).copyWith(
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            const HuddleChip(
                                              label: 'LOCKED IN',
                                              variant: HuddleChipVariant.neon,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        const Center(
                                          child: TimerRing(
                                            totalSeconds: 1500,
                                            remainingSeconds: 1120,
                                            size: 110,
                                            isFocusing: true,
                                            isNeon: true,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          '4 OF 5 FOCUSING',
                                          style: HuddleTheme.monoLabel(
                                            color: HuddleTheme.neonTextMuted,
                                          ).copyWith(fontSize: 10),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            for (final name in [
                                              'Aisha',
                                              'Ayaan',
                                              'Maya',
                                              'Rohan',
                                            ])
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 8,
                                                ),
                                                child: HuddleAvatar(
                                                  seed: name,
                                                  size: 32,
                                                  isFocusing: name != 'Rohan',
                                                ),
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 14),
                                        HuddleButton(
                                          text: 'Join Room',
                                          variant: HuddleButtonVariant.neon,
                                          height: 38,
                                          onPressed: () =>
                                              context.go('/room/1'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),

                                // Mockup 3: Real EventCard
                                SizedBox(
                                  width: 320,
                                  child: EventCard(
                                    event: FakeData.events.first,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 48),

              // 3 Feature Blocks
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1600),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionLabel(
                          text: 'WHY STUDENTS SCREENSHOT HUDDLE',
                          color: HuddleTheme.neonCyan,
                        ),
                        const SizedBox(height: 16),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final isWide = constraints.maxWidth >= 768;
                            return Flex(
                              direction: isWide
                                  ? Axis.horizontal
                                  : Axis.vertical,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Block 1: Squad Rooms
                                Expanded(
                                  flex: isWide ? 1 : 0,
                                  child: _buildFeatureCard(
                                    step: '01',
                                    title: 'Squad Rooms',
                                    description:
                                        'Synchronized 25-minute Pomodoro timer, live WebSocket chat, member focus rings, and rolling streak counters.',
                                    icon: Icons.timer_outlined,
                                  ),
                                ),
                                SizedBox(
                                  width: isWide ? 16 : 0,
                                  height: isWide ? 0 : 16,
                                ),

                                // Block 2: 45s Peer Reels
                                Expanded(
                                  flex: isWide ? 1 : 0,
                                  child: _buildFeatureCard(
                                    step: '02',
                                    title: '45s Peer Reels',
                                    description:
                                        'Student-taught micro-lessons with a 3-question "Try it" quiz to verify active recall right after watching.',
                                    icon: Icons.movie_outlined,
                                  ),
                                ),
                                SizedBox(
                                  width: isWide ? 16 : 0,
                                  height: isWide ? 0 : 16,
                                ),

                                // Block 3: Campus Events
                                Expanded(
                                  flex: isWide ? 1 : 0,
                                  child: _buildFeatureCard(
                                    step: '03',
                                    title: 'Campus Events',
                                    description:
                                        'Interleaved hackathons and study sessions with live attendee counts and instant one-tap RSVP toggle.',
                                    icon: Icons.event_outlined,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 48),

              // 4-step "How It Works" Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1600),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionLabel(
                          text: 'HOW IT WORKS IN 4 STEPS',
                          color: HuddleTheme.neonCyan,
                        ),
                        const SizedBox(height: 16),
                        HuddleCard(
                          color: HuddleTheme.neonCard,
                          border: HuddleTheme.borderCyanSubtle,
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildStepRow(
                                step: '1',
                                title: 'Pick your subject',
                                detail:
                                    'Filter by Operating Systems, DBMS, Machine Learning, or Algorithms based on your exam deadlines.',
                              ),
                              Divider(
                                height: 32,
                                thickness: 1,
                                color: HuddleTheme.neonCyan.withValues(alpha: 0.2),
                              ),
                              _buildStepRow(
                                step: '2',
                                title: 'Swipe squads',
                                detail:
                                    'Swipe right to join, left to skip. Check transparent "why you matched" tags based on exam deadline and time slot.',
                              ),
                              Divider(
                                height: 32,
                                thickness: 1,
                                color: HuddleTheme.neonCyan.withValues(alpha: 0.2),
                              ),
                              _buildStepRow(
                                step: '3',
                                title: 'Lock in together',
                                detail:
                                    'Synchronized 25-minute Pomodoro timer counts down together in the live room with sticker chat reactions.',
                              ),
                              Divider(
                                height: 32,
                                thickness: 1,
                                color: HuddleTheme.neonCyan.withValues(alpha: 0.2),
                              ),
                              _buildStepRow(
                                step: '4',
                                title: 'Earn verified karma',
                                detail:
                                    'Ace quizzes, maintain daily streaks, and collect peer endorsements for your campus profile.',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 48),

              // "Built with Serverpod" Highlight Strip
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1600),
                    child: InkWell(
                      onTap: () => ServerpodBadge.showServerpodSheet(context),
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: HuddleTheme.neonCard,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: HuddleTheme.neonCyan,
                            width: 1.5,
                          ),
                          boxShadow: const [HuddleTheme.shadowCyanGlow],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 54,
                              height: 54,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: SvgPicture.asset(
                                'assets/images/serverpod.svg',
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(width: 18),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    spacing: 8,
                                    runSpacing: 4,
                                    children: [
                                      Text(
                                        'BUILT WITH SERVERPOD',
                                        style: HuddleTheme.monoLabel(
                                          color: HuddleTheme.neonCyan,
                                        ).copyWith(
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                      const HuddleChip(
                                        label: 'FULL-STACK DART',
                                        variant: HuddleChipVariant.neon,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'End-to-end typed Dart endpoints, real-time WebSocket streams, PostgreSQL ORM, and zero serialization boilerplate. Hosted on Serverpod Cloud.',
                                    style: HuddleTheme.body14(
                                      color: Colors.white.withValues(
                                        alpha: 0.85,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: HuddleTheme.neonCyan,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 48),

              // Clean Footer
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 28,
                ),
                decoration: BoxDecoration(
                  color: HuddleTheme.neonCard,
                  border: Border(
                    top: BorderSide(
                      color: HuddleTheme.neonCyan.withValues(alpha: 0.3),
                      width: 1.5,
                    ),
                  ),
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1600),
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 16,
                      runSpacing: 14,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 10,
                          runSpacing: 6,
                          children: [
                            const ServerpodBadge(size: 24, showLabel: false),
                            Text(
                              'Huddle Campus Peer Learning',
                              style: HuddleTheme.body14(color: Colors.white).copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '1,420 students · 380 squads · 12,400 focus minutes logged',
                          style: HuddleTheme.monoLabel().copyWith(
                            fontSize: 11,
                            color: HuddleTheme.neonTextMuted,
                          ),
                        ),
                        HuddleButton(
                          text: 'Launch Feed',
                          icon: Icons.bolt_outlined,
                          variant: HuddleButtonVariant.neon,
                          height: 36,
                          onPressed: () => context.go('/feed'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required String step,
    required String title,
    required String description,
    required IconData icon,
  }) {
    return HuddleCard(
      color: HuddleTheme.neonCard,
      border: HuddleTheme.borderCyanSubtle,
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HuddleChip(
                label: '$step · FEATURE',
                variant: HuddleChipVariant.neon,
              ),
              Icon(icon, size: 22, color: HuddleTheme.neonCyan),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: HuddleTheme.displayHeading(fontSize: 18, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: HuddleTheme.body14(
              color: HuddleTheme.neonTextMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepRow({
    required String step,
    required String title,
    required String detail,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: HuddleTheme.neonCyan,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              step,
              style: HuddleTheme.monoLabel(color: HuddleTheme.neonBg).copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: HuddleTheme.displayHeading(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 4),
              Text(
                detail,
                style: HuddleTheme.body14(
                  color: HuddleTheme.neonTextMuted,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
