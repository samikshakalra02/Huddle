import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../theme.dart';

enum HuddleChipVariant { subtle, highlight, accent, ink, neon, neonDark }

/// Clean rounded chip (radius 999) for topic labels, live status, and sticker accents.
class HuddleChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool isHighlight;
  final bool isAccent;
  final bool isInk;
  final HuddleChipVariant? variant;
  final double angleDegrees;
  final VoidCallback? onTap;

  const HuddleChip({
    super.key,
    required this.label,
    this.icon,
    bool isHighlight = false,
    bool isAccent = false,
    this.variant,
    this.angleDegrees = 0.0,
    this.onTap,
  }) : isHighlight = variant == HuddleChipVariant.highlight || isHighlight,
       isAccent = variant == HuddleChipVariant.accent || isAccent,
       isInk = variant == HuddleChipVariant.ink;

  // Tilted sticker chip constructor (one per screen max)
  const HuddleChip.sticker({
    super.key,
    required this.label,
    this.icon,
    bool isHighlight = true,
    bool isAccent = false,
    this.variant,
    this.angleDegrees = -2.0,
    this.onTap,
  }) : isHighlight = variant == null
           ? isHighlight
           : variant == HuddleChipVariant.highlight,
       isAccent = variant == HuddleChipVariant.accent || isAccent,
       isInk = variant == HuddleChipVariant.ink;

  @override
  Widget build(BuildContext context) {
    Color bg = HuddleTheme.background;
    Color fg = HuddleTheme.ink;
    Border border = Border.all(color: HuddleTheme.ink, width: 1.5);
    BoxShadow shadow = HuddleTheme.shadowSmall;

    if (variant == HuddleChipVariant.neon) {
      bg = HuddleTheme.neonCyan;
      fg = HuddleTheme.neonBg;
      border = Border.all(color: HuddleTheme.neonCyan, width: 1.5);
      shadow = HuddleTheme.shadowCyan;
    } else if (variant == HuddleChipVariant.neonDark) {
      bg = HuddleTheme.neonCard;
      fg = HuddleTheme.neonCyan;
      border = Border.all(color: HuddleTheme.neonCyan, width: 1.5);
      shadow = HuddleTheme.shadowCyan;
    } else if (isHighlight) {
      bg = HuddleTheme.highlight;
      fg = HuddleTheme.ink;
    } else if (isAccent) {
      bg = HuddleTheme.accent;
      fg = Colors.white;
    } else if (isInk) {
      bg = HuddleTheme.ink;
      fg = Colors.white;
    }

    Widget chip = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: border,
        boxShadow: [shadow],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: fg),
            const SizedBox(width: 6),
          ],
          Flexible(
            child: Text(
              label.toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: HuddleTheme.monoLabel(color: fg).copyWith(
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );

    if (angleDegrees != 0.0) {
      chip = Transform.rotate(
        angle: angleDegrees * (math.pi / 180.0),
        child: chip,
      );
    }

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: chip,
      );
    }

    return chip;
  }
}

// Backward-compatible alias for StickerTag
class StickerTag extends StatelessWidget {
  final String label;
  final bool isVolt;
  final double angleDegrees;
  final VoidCallback? onTap;

  const StickerTag({
    super.key,
    required this.label,
    this.isVolt = false,
    this.angleDegrees = 0.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return HuddleChip(
      label: label,
      isHighlight: isVolt,
      angleDegrees: angleDegrees,
      onTap: onTap,
    );
  }
}
