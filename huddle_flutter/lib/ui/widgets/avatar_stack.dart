import 'package:flutter/material.dart';
import '../../theme.dart';
import 'huddle_avatar.dart';

/// Horizontal overlapping avatar stack with "+N" badge for squads and reels.
class AvatarStack extends StatelessWidget {
  final List<String> names;
  final double avatarSize;
  final int maxVisible;
  final double overlap;
  final VoidCallback? onTap;

  const AvatarStack({
    super.key,
    required this.names,
    this.avatarSize = 32,
    this.maxVisible = 3,
    this.overlap = 10,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (names.isEmpty) return const SizedBox.shrink();

    final visibleNames = names.take(maxVisible).toList();
    final remaining = names.length - visibleNames.length;
    final totalCount = visibleNames.length + (remaining > 0 ? 1 : 0);
    final totalWidth = totalCount * (avatarSize - overlap) + overlap;

    Widget stack = SizedBox(
      height: avatarSize + 2,
      width: totalWidth,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          for (int i = 0; i < visibleNames.length; i++)
            Positioned(
              left: i * (avatarSize - overlap),
              child: HuddleAvatar(
                name: visibleNames[i],
                size: avatarSize,
              ),
            ),
          if (remaining > 0)
            Positioned(
              left: visibleNames.length * (avatarSize - overlap),
              child: Container(
                width: avatarSize,
                height: avatarSize,
                decoration: BoxDecoration(
                  color: HuddleTheme.highlight,
                  shape: BoxShape.circle,
                  border: Border.all(color: HuddleTheme.ink, width: 1.5),
                  boxShadow: const [HuddleTheme.shadowSmall],
                ),
                alignment: Alignment.center,
                child: Text(
                  '+$remaining',
                  style: HuddleTheme.monoLabel(color: HuddleTheme.ink).copyWith(
                    fontSize: avatarSize * 0.36,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
        ],
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: stack,
      );
    }

    return stack;
  }
}
