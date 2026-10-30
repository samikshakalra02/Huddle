import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme.dart';
import 'huddle_avatar.dart';

export '../../services/user_service.dart' show AvatarVibe;

/// Eye-catchy, modern Gen Z pictorial avatar drawn natively with Flutter [CustomPaint].
/// Deterministic per seed, fully animated with interactive bounce & react icon badge.
class PictorialAvatar extends StatefulWidget {
  final String seed;
  final double size;
  final AvatarVibe? vibe;
  final Color? neonColor;
  final String? reactionEmoji;
  final String? reactionLabel;
  final bool showBadge;
  final bool isInteractive;
  final VoidCallback? onTap;

  const PictorialAvatar({
    super.key,
    required this.seed,
    this.size = 72,
    this.vibe,
    this.neonColor,
    this.reactionEmoji,
    this.reactionLabel,
    this.showBadge = true,
    this.isInteractive = true,
    this.onTap,
  });

  @override
  State<PictorialAvatar> createState() => _PictorialAvatarState();
}

class _PictorialAvatarState extends State<PictorialAvatar>
    with SingleTickerProviderStateMixin {
  late AnimationController _bounceController;
  late Animation<double> _scaleAnimation;
  bool _showReactionBurst = false;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 1.14,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.14,
          end: 0.95,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 0.95,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 30,
      ),
    ]).animate(_bounceController);
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (!widget.isInteractive) return;
    HapticFeedback.mediumImpact();
    _bounceController.forward(from: 0.0);
    setState(() => _showReactionBurst = true);
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (mounted) setState(() => _showReactionBurst = false);
    });
    widget.onTap?.call();
  }

  Color _resolveNeonColor(int hash) {
    if (widget.neonColor != null) return widget.neonColor!;
    final colors = [
      HuddleTheme.violet,
      HuddleTheme.teal,
      HuddleTheme.pink,
      HuddleTheme.volt,
      HuddleTheme.highlight,
    ];
    return colors[hash % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final hash = widget.seed.hashCode.abs();
    final effectiveVibe =
        widget.vibe ?? AvatarVibe.values[hash % AvatarVibe.values.length];
    final effectiveNeon = _resolveNeonColor(hash);

    // Pick reaction emoji and label
    final defaultEmojis = ['🔥', '⚡', '🧠', '✨', '🎧', '🎮', '🐱', '🕶️'];
    final defaultLabels = [
      '14d streak',
      'locked in',
      'active recall',
      '98% match',
      'deep work',
      'pro gamer',
      'cyber neko',
      'visionary',
    ];
    final emoji =
        widget.reactionEmoji ?? defaultEmojis[hash % defaultEmojis.length];
    final label =
        widget.reactionLabel ?? defaultLabels[hash % defaultLabels.length];

    return GestureDetector(
      onTap: _handleTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: SizedBox(
          width: widget.size + (widget.showBadge ? 24 : 0),
          height: widget.size + (widget.showBadge ? 18 : 0),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Main Circular Neon Character Canvas
              Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: HuddleTheme.navy,
                  border: Border.all(
                    color: effectiveNeon,
                    width: math.max(1.8, widget.size * 0.035),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: effectiveNeon.withValues(alpha: 0.40),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: CustomPaint(
                    size: Size(widget.size, widget.size),
                    painter: NeonCartoonPainter(
                      seed: widget.seed,
                      vibe: effectiveVibe,
                      neonColor: effectiveNeon,
                    ),
                  ),
                ),
              ),

              // React Icon Badge (Tilted sticker badge)
              if (widget.showBadge)
                Positioned(
                  top: -2,
                  right: -4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
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
                        Text(
                          emoji,
                          style: TextStyle(
                            fontSize: math.max(10, widget.size * 0.16),
                          ),
                        ),
                        if (widget.size >= 56) ...[
                          const SizedBox(width: 3),
                          Text(
                            label.toUpperCase(),
                            style: HuddleTheme.monoLabel().copyWith(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

              // Happy Floating Reaction Burst
              if (_showReactionBurst)
                Positioned(
                  top: -20,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 600),
                    builder: (context, val, _) {
                      return Opacity(
                        opacity: (1.0 - val).clamp(0.0, 1.0),
                        child: Transform.translate(
                          offset: Offset(0, -val * 24),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: HuddleTheme.pink,
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(
                                color: HuddleTheme.ink,
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  emoji,
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'LET\'S GO!',
                                  style:
                                      HuddleTheme.monoLabel(
                                        color: Colors.white,
                                      ).copyWith(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
