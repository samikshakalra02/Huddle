import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme.dart';

/// Animated quiz option card with slide-in, Accent bounce on correct,
/// and horizontal shake on wrong answer.
class QuizOption extends StatefulWidget {
  final int index;
  final String text;
  final bool isSelected;
  final bool isCorrect;
  final bool hasSubmitted;
  final VoidCallback onTap;

  const QuizOption({
    super.key,
    required this.index,
    required this.text,
    required this.isSelected,
    required this.isCorrect,
    required this.hasSubmitted,
    required this.onTap,
  });

  @override
  State<QuizOption> createState() => _QuizOptionState();
}

class _QuizOptionState extends State<QuizOption>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _shakeAnimation;
  late Animation<double> _bounceAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );

    _shakeAnimation =
        TweenSequence<double>([
          TweenSequenceItem(tween: Tween(begin: 0.0, end: -6.0), weight: 1),
          TweenSequenceItem(tween: Tween(begin: -6.0, end: 6.0), weight: 2),
          TweenSequenceItem(tween: Tween(begin: 6.0, end: -4.0), weight: 2),
          TweenSequenceItem(tween: Tween(begin: -4.0, end: 4.0), weight: 2),
          TweenSequenceItem(tween: Tween(begin: 4.0, end: 0.0), weight: 1),
        ]).animate(
          CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
        );

    _bounceAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.05), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.05, end: 0.98), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.98, end: 1.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
  }

  @override
  void didUpdateWidget(covariant QuizOption oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.hasSubmitted && widget.hasSubmitted && widget.isSelected) {
      final reduceMotion =
          MediaQuery.maybeOf(context)?.disableAnimations ?? false;
      if (!reduceMotion) {
        _animController.forward(from: 0.0);
      }
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (!widget.hasSubmitted) {
      HapticFeedback.lightImpact();
      widget.onTap();
    }
  }

  @override
  Widget build(BuildContext context) {
    final letters = ['A', 'B', 'C', 'D'];
    final letter = widget.index < letters.length
        ? letters[widget.index]
        : '${widget.index + 1}';

    Color bgColor = HuddleTheme.neonCardAlt;
    Color fgColor = Colors.white;
    Border border = Border.all(
      color: HuddleTheme.neonCyan.withValues(alpha: 0.35),
      width: 1.5,
    );
    List<BoxShadow> shadows = _isHovered
        ? const [HuddleTheme.shadowCyanGlow]
        : const [HuddleTheme.shadowSmall];

    if (widget.hasSubmitted) {
      if (widget.isSelected) {
        if (widget.isCorrect) {
          bgColor = HuddleTheme.neonCyan; // Neon Cyan on correct
          fgColor = HuddleTheme.neonBg;
          border = Border.all(color: HuddleTheme.neonCyan, width: 1.5);
          shadows = const [HuddleTheme.shadowCyanGlow];
        } else {
          bgColor = HuddleTheme.neonMagenta.withValues(alpha: 0.3); // Neon Magenta on wrong
          fgColor = Colors.white;
          border = Border.all(color: HuddleTheme.neonMagenta, width: 1.5);
          shadows = const [HuddleTheme.shadowMagentaGlow];
        }
      } else if (widget.isCorrect) {
        // Highlight revealed correct answer
        bgColor = HuddleTheme.neonCyan.withValues(alpha: 0.25);
        fgColor = HuddleTheme.neonCyan;
        border = Border.all(color: HuddleTheme.neonCyan, width: 1.5);
      }
    } else if (widget.isSelected) {
      bgColor = HuddleTheme.neonCyan.withValues(alpha: 0.20);
      fgColor = HuddleTheme.neonCyan;
      border = Border.all(color: HuddleTheme.neonCyan, width: 1.5);
      shadows = const [HuddleTheme.shadowCyanGlow];
    }

    final reduceMotion =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;

    Widget card = Container(
      constraints: const BoxConstraints(minHeight: 48),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: HuddleTheme.radius14,
        border: border,
        boxShadow: shadows,
      ),
      child: Row(
        children: [
          // Letter badge (A, B, C, D)
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? (widget.hasSubmitted && widget.isCorrect
                      ? HuddleTheme.neonBg
                      : HuddleTheme.neonCyan)
                  : HuddleTheme.neonCard,
              border: Border.all(
                color: widget.isSelected
                    ? HuddleTheme.neonCyan
                    : HuddleTheme.neonCyan.withValues(alpha: 0.5),
                width: 1.5,
              ),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              letter,
              style: HuddleTheme.monoLabel(
                color: widget.isSelected
                    ? (widget.hasSubmitted && widget.isCorrect
                        ? HuddleTheme.neonCyan
                        : HuddleTheme.neonBg)
                    : Colors.white,
              ).copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(width: 12),

          // Option text
          Expanded(
            child: Text(
              widget.text,
              style: HuddleTheme.body14(
                color: fgColor,
                fontWeight: widget.isSelected
                    ? FontWeight.w700
                    : FontWeight.w500,
              ),
            ),
          ),

          // Feedback icon on submit
          if (widget.hasSubmitted && widget.isSelected) ...[
            const SizedBox(width: 8),
            Icon(
              widget.isCorrect
                  ? Icons.check_circle_rounded
                  : Icons.cancel_rounded,
              color: fgColor,
              size: 20,
            ),
          ],
        ],
      ),
    );

    if (!reduceMotion && widget.hasSubmitted && widget.isSelected) {
      if (widget.isCorrect) {
        card = ScaleTransition(
          scale: _bounceAnimation,
          child: card,
        );
      } else {
        card = AnimatedBuilder(
          animation: _shakeAnimation,
          builder: (context, child) => Transform.translate(
            offset: Offset(_shakeAnimation.value, 0),
            child: child,
          ),
          child: card,
        );
      }
    }

    return Semantics(
      button: true,
      selected: widget.isSelected,
      label: 'Option $letter: ${widget.text}',
      child: MouseRegion(
        cursor: widget.hasSubmitted
            ? SystemMouseCursors.basic
            : SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: _handleTap,
          behavior: HitTestBehavior.opaque,
          child: card,
        ),
      ),
    );
  }
}
