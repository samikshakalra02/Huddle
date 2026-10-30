import 'package:flutter/material.dart';
import '../../theme.dart';

/// Clean left-aligned section header with dot/icon and uppercase mono label.
class SectionLabel extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Widget? trailing;
  final Color? color;

  const SectionLabel({
    super.key,
    required this.text,
    this.icon,
    this.trailing,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? HuddleTheme.ink;
    final dotColor = color ?? HuddleTheme.accent;

    return Semantics(
      header: true,
      label: 'Section: $text',
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null)
                    Icon(icon, size: 16, color: dotColor)
                  else
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: dotColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      text.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: HuddleTheme.monoLabel(color: effectiveColor)
                          .copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: 8),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}
