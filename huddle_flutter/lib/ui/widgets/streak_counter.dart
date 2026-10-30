import 'package:flutter/material.dart';
import '../../theme.dart';

/// Animated streak pill with rolling odometer number, fire icon,
/// and Highlight background accent.
class StreakCounter extends StatelessWidget {
  final int streakDays;
  final bool isLarge;

  const StreakCounter({
    super.key,
    required this.streakDays,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    final reduceMotion =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;

    return Semantics(
      label: '$streakDays day study streak',
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isLarge ? 14 : 10,
          vertical: isLarge ? 8 : 4,
        ),
        decoration: BoxDecoration(
          color: HuddleTheme.highlight,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: HuddleTheme.ink, width: 1.5),
          boxShadow: const [HuddleTheme.shadowSmall],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.local_fire_department_rounded,
              size: isLarge ? 20 : 16,
              color: HuddleTheme.ink,
            ),
            const SizedBox(width: 6),
            // Odometer-style rolling animated switcher
            AnimatedSwitcher(
              duration: reduceMotion
                  ? Duration.zero
                  : const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) {
                final inOffset =
                    Tween<Offset>(
                      begin: const Offset(0.0, -1.0),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutCubic,
                      ),
                    );
                return ClipRect(
                  child: SlideTransition(
                    position: inOffset,
                    child: child,
                  ),
                );
              },
              child: Text(
                '$streakDays-DAY STREAK',
                key: ValueKey<int>(streakDays),
                style: HuddleTheme.monoLabel(color: HuddleTheme.ink).copyWith(
                  fontSize: isLarge ? 13 : 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
