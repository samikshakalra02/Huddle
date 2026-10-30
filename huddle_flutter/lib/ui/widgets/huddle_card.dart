import 'package:flutter/material.dart';
import '../../theme.dart';

/// Clean card container with 1.5px ink border, 14px radius, and soft low shadow.
class HuddleCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final VoidCallback? onTap;
  final bool hoverable;

  const HuddleCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.color,
    this.border,
    this.boxShadow,
    this.onTap,
    this.hoverable = false,
  });

  @override
  State<HuddleCard> createState() => _HuddleCardState();
}

class _HuddleCardState extends State<HuddleCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cardContent = AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.color ?? HuddleTheme.background,
        borderRadius: HuddleTheme.radius14,
        border: widget.border ?? HuddleTheme.border,
        boxShadow: widget.boxShadow ??
            [
              _isHovered && widget.hoverable
                  ? HuddleTheme.shadowHover
                  : HuddleTheme.shadowSmall,
            ],
      ),
      child: widget.child,
    );

    if (widget.onTap != null) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          behavior: HitTestBehavior.opaque,
          child: cardContent,
        ),
      );
    }

    if (widget.hoverable) {
      return MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: cardContent,
      );
    }

    return cardContent;
  }
}

// Backward-compatible alias for HardCard
typedef HardCard = HuddleCard;
