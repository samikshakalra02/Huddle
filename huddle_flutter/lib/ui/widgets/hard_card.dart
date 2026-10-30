import 'package:flutter/material.dart';
import 'huddle_card.dart';

export 'huddle_card.dart';

/// Backward-compatible adapter forwarding to [HuddleCard].
class HardCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  const HardCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return HuddleCard(
      padding: padding,
      color: backgroundColor,
      onTap: onTap,
      child: child,
    );
  }
}
