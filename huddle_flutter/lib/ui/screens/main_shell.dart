import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../services/api_service.dart';
import '../../services/user_service.dart';
import '../../theme.dart';
import '../widgets/huddle_avatar.dart';
import '../widgets/huddle_chip.dart';
import '../widgets/serverpod_badge.dart';

class MainShell extends StatelessWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/feed')) return 0;
    if (location.startsWith('/reels')) return 1;
    if (location.startsWith('/match')) return 2;
    if (location.startsWith('/room')) return 3;
    if (location.startsWith('/profile')) return 4;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/feed');
        break;
      case 1:
        context.go('/reels/1');
        break;
      case 2:
        context.go('/match');
        break;
      case 3:
        context.go('/room/1');
        break;
      case 4:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1024;
    final isTablet = width >= 600 && width < 1024;
    final selectedIndex = _calculateSelectedIndex(context);

    // Global keyboard shortcuts (1..5) to switch tabs on desktop/tablet
    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.digit1): () =>
            _onItemTapped(0, context),
        const SingleActivator(LogicalKeyboardKey.digit2): () =>
            _onItemTapped(1, context),
        const SingleActivator(LogicalKeyboardKey.digit3): () =>
            _onItemTapped(2, context),
        const SingleActivator(LogicalKeyboardKey.digit4): () =>
            _onItemTapped(3, context),
        const SingleActivator(LogicalKeyboardKey.digit5): () =>
            _onItemTapped(4, context),
      },
      child: Focus(
        autofocus: true,
        child: isDesktop
            ? _buildDesktopLayout(context, selectedIndex)
            : isTablet
            ? _buildTabletLayout(context, selectedIndex)
            : _buildMobileLayout(context, selectedIndex),
      ),
    );
  }

  // DESKTOP (>1024): Left Sidebar (240px) + Max 1180px Content Area
  Widget _buildDesktopLayout(BuildContext context, int selectedIndex) {
    return Scaffold(
      backgroundColor: HuddleTheme.neonBg,
      body: Row(
        children: [
          // Left Sidebar (240px wide)
          Container(
            width: 240,
            decoration: BoxDecoration(
              color: HuddleTheme.neonCard,
              border: Border(
                right: BorderSide(
                  color: HuddleTheme.neonCyan.withValues(alpha: 0.25),
                  width: 1.5,
                ),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Brand Header with Serverpod Logo + HUDDLE wordmark
                InkWell(
                  onTap: () => context.go('/'),
                  borderRadius: BorderRadius.circular(12),
                  child: Row(
                    children: [
                      const ServerpodBadge(size: 28),
                      const SizedBox(width: 10),
                      Text(
                        'HUDDLE',
                        style: HuddleTheme.displayHeading(
                          fontSize: 18,
                        ).copyWith(color: Colors.white),
                      ),
                      const SizedBox(width: 8),
                      const HuddleChip(
                        label: 'CAMPUS',
                        variant: HuddleChipVariant.neonDark,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Navigation Items List
                _desktopSidebarItem(
                  context,
                  0,
                  'Home Feed',
                  Icons.dynamic_feed_outlined,
                  selectedIndex,
                ),
                const SizedBox(height: 6),
                _desktopSidebarItem(
                  context,
                  1,
                  'Peer Reels',
                  Icons.movie_outlined,
                  selectedIndex,
                ),
                const SizedBox(height: 6),
                _desktopSidebarItem(
                  context,
                  2,
                  'Squad Match',
                  Icons.view_carousel_outlined,
                  selectedIndex,
                ),
                const SizedBox(height: 6),
                _desktopSidebarItem(
                  context,
                  3,
                  'Focus Room',
                  Icons.timer_outlined,
                  selectedIndex,
                ),
                const SizedBox(height: 6),
                _desktopSidebarItem(
                  context,
                  4,
                  'Campus Karma',
                  Icons.person_outline,
                  selectedIndex,
                ),

                const Spacer(),

                // Connection Status Pill
                ValueListenableBuilder<bool>(
                  valueListenable: ApiService.instance.isServerAvailable,
                  builder: (context, isOnline, _) {
                    return InkWell(
                      onTap: () async {
                        final connected = await ApiService.instance
                            .checkConnection(force: true);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                connected
                                    ? 'LOCKED IN · SERVERPOD ONLINE'
                                    : 'SERVERPOD OFFLINE · RUNNING ON DEMO DATA',
                                style: HuddleTheme.monoLabel(
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: HuddleTheme.neonCardAlt,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: HuddleTheme.neonCardAlt,
                          border: Border.all(
                            color: isOnline
                                ? HuddleTheme.neonCyan
                                : HuddleTheme.neonCyan.withValues(alpha: 0.3),
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: isOnline
                                    ? HuddleTheme.neonCyan
                                    : HuddleTheme.neonTextMuted.withValues(
                                        alpha: 0.4,
                                      ),
                                shape: BoxShape.circle,
                                boxShadow: isOnline
                                    ? const [
                                        BoxShadow(
                                          color: HuddleTheme.neonCyan,
                                          blurRadius: 4,
                                        ),
                                      ]
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                isOnline ? 'SERVER ONLINE' : 'DEMO MODE',
                                style: HuddleTheme.monoLabel().copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: isOnline
                                      ? HuddleTheme.neonCyan
                                      : HuddleTheme.neonTextMuted,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),

                // Bottom Persona Card with Procedural Avatar
                ValueListenableBuilder<String>(
                  valueListenable: UserService.instance.currentUser,
                  builder: (context, name, _) {
                    return InkWell(
                      onTap: () => context.go('/profile'),
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: HuddleTheme.neonCardAlt,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: HuddleTheme.neonCyan.withValues(alpha: 0.35),
                            width: 1.5,
                          ),
                          boxShadow: const [HuddleTheme.shadowCyan],
                        ),
                        child: Row(
                          children: [
                            HuddleAvatar(
                              seed: UserService.instance.effectiveAvatarSeed,
                              size: 38,
                              showOnline: true,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        HuddleTheme.monoLabel(
                                          color: Colors.white,
                                        ).copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '4.88 Verified Karma',
                                    style: HuddleTheme.body14(
                                      color: HuddleTheme.neonCyan,
                                    ).copyWith(fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Main Content Area - Full laptop screen display
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _desktopSidebarItem(
    BuildContext context,
    int index,
    String label,
    IconData icon,
    int selectedIndex,
  ) {
    final isSelected = index == selectedIndex;

    return InkWell(
      onTap: () => _onItemTapped(index, context),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? HuddleTheme.neonCardAlt : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: HuddleTheme.neonCyan, width: 1.5)
              : null,
          boxShadow: isSelected ? const [HuddleTheme.shadowCyan] : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected
                  ? HuddleTheme.neonCyan
                  : HuddleTheme.neonTextMuted,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style:
                    HuddleTheme.monoLabel(
                      color: isSelected
                          ? Colors.white
                          : HuddleTheme.neonTextMuted,
                    ).copyWith(
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                    ),
              ),
            ),
            if (isSelected)
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: HuddleTheme.neonCyan,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: HuddleTheme.neonCyan, blurRadius: 4),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  // TABLET (600-1024): Left Navigation Rail (80px) with Serverpod Logo at top
  Widget _buildTabletLayout(BuildContext context, int selectedIndex) {
    return Scaffold(
      backgroundColor: HuddleTheme.neonBg,
      body: Row(
        children: [
          Container(
            width: 80,
            decoration: BoxDecoration(
              color: HuddleTheme.neonCard,
              border: Border(
                right: BorderSide(
                  color: HuddleTheme.neonCyan.withValues(alpha: 0.25),
                  width: 1.5,
                ),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                InkWell(
                  onTap: () => context.go('/'),
                  child: const ServerpodBadge(size: 32),
                ),
                const SizedBox(height: 28),
                _railIcon(
                  context,
                  0,
                  Icons.dynamic_feed_outlined,
                  'Feed',
                  selectedIndex,
                ),
                const SizedBox(height: 12),
                _railIcon(
                  context,
                  1,
                  Icons.movie_outlined,
                  'Reels',
                  selectedIndex,
                ),
                const SizedBox(height: 12),
                _railIcon(
                  context,
                  2,
                  Icons.view_carousel_outlined,
                  'Match',
                  selectedIndex,
                ),
                const SizedBox(height: 12),
                _railIcon(
                  context,
                  3,
                  Icons.timer_outlined,
                  'Room',
                  selectedIndex,
                ),
                const SizedBox(height: 12),
                _railIcon(
                  context,
                  4,
                  Icons.person_outline,
                  'Karma',
                  selectedIndex,
                ),
                const Spacer(),
                ValueListenableBuilder<String>(
                  valueListenable: UserService.instance.currentUser,
                  builder: (context, name, _) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: InkWell(
                        onTap: () => context.go('/profile'),
                        child: HuddleAvatar(
                          seed: UserService.instance.effectiveAvatarSeed,
                          size: 36,
                          showOnline: true,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _railIcon(
    BuildContext context,
    int index,
    IconData icon,
    String label,
    int selectedIndex,
  ) {
    final isSelected = index == selectedIndex;
    return InkWell(
      onTap: () => _onItemTapped(index, context),
      borderRadius: BorderRadius.circular(12),
      child: Tooltip(
        message: label,
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: isSelected ? HuddleTheme.neonCardAlt : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: isSelected
                ? Border.all(color: HuddleTheme.neonCyan, width: 1.5)
                : null,
            boxShadow: isSelected ? const [HuddleTheme.shadowCyan] : null,
          ),
          child: Icon(
            icon,
            size: 22,
            color: isSelected
                ? HuddleTheme.neonCyan
                : HuddleTheme.neonTextMuted,
          ),
        ),
      ),
    );
  }

  // PHONE (<600): Bottom Navigation Bar (64px, 44px min tap targets)
  Widget _buildMobileLayout(BuildContext context, int selectedIndex) {
    return Scaffold(
      backgroundColor: HuddleTheme.neonBg,
      body: child,
      bottomNavigationBar: Container(
        height: 64,
        decoration: BoxDecoration(
          color: HuddleTheme.neonCard,
          border: Border(
            top: BorderSide(
              color: HuddleTheme.neonCyan.withValues(alpha: 0.25),
              width: 1.5,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _bottomIcon(
              context,
              0,
              Icons.dynamic_feed_outlined,
              'Home',
              selectedIndex,
            ),
            _bottomIcon(
              context,
              1,
              Icons.movie_outlined,
              'Reels',
              selectedIndex,
            ),
            _bottomIcon(
              context,
              2,
              Icons.view_carousel_outlined,
              'Squads',
              selectedIndex,
            ),
            _bottomIcon(
              context,
              3,
              Icons.timer_outlined,
              'Room',
              selectedIndex,
            ),
            _bottomIcon(
              context,
              4,
              Icons.person_outline,
              'Profile',
              selectedIndex,
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomIcon(
    BuildContext context,
    int index,
    IconData icon,
    String label,
    int selectedIndex,
  ) {
    final isSelected = index == selectedIndex;
    return Expanded(
      child: InkWell(
        onTap: () => _onItemTapped(index, context),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isSelected
                  ? HuddleTheme.neonCyan.withValues(alpha: 0.12)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: isSelected
                      ? HuddleTheme.neonCyan
                      : HuddleTheme.neonTextMuted,
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:
                      HuddleTheme.monoLabel(
                        color: isSelected
                            ? HuddleTheme.neonCyan
                            : HuddleTheme.neonTextMuted,
                      ).copyWith(
                        fontSize: 10,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
