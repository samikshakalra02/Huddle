import 'package:flutter/material.dart';
import 'huddle_avatar.dart';

export 'huddle_avatar.dart';

/// Backward-compatible adapter forwarding to [HuddleAvatar].
class Avatar extends StatelessWidget {
  final String name;
  final double radius;
  final bool isFocusing;
  final bool isVolt;

  const Avatar({
    super.key,
    required this.name,
    this.radius = 20,
    this.isFocusing = false,
    this.isVolt = true,
  });

  @override
  Widget build(BuildContext context) {
    return HuddleAvatar(
      name: name,
      size: radius * 2,
      isFocusing: isFocusing,
    );
  }
}
