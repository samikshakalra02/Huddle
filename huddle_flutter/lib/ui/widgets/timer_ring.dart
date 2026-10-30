import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../theme.dart';

/// Synchronized 25-minute Pomodoro timer ring with smooth ticking,
/// JetBrains Mono countdown display, and Accent progress stroke.
class TimerRing extends StatelessWidget {
  final int totalSeconds;
  final int remainingSeconds;
  final double size;
  final bool isFocusing;
  final bool isNeon;

  const TimerRing({
    super.key,
    required this.totalSeconds,
    required this.remainingSeconds,
    this.size = 200,
    this.isFocusing = false,
    this.isNeon = true,
  });

  @override
  Widget build(BuildContext context) {
    final clampedRemaining = remainingSeconds.clamp(0, totalSeconds);
    final progress = totalSeconds > 0 ? (clampedRemaining / totalSeconds) : 0.0;

    final minutes = clampedRemaining ~/ 60;
    final seconds = clampedRemaining % 60;
    final timeStr =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    return Semantics(
      label:
          'Pomodoro timer: $minutes minutes and $seconds seconds remaining. ${isFocusing ? "Locked in" : "Ready"}',
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: isNeon ? HuddleTheme.neonCard : HuddleTheme.background,
          shape: BoxShape.circle,
          border: isNeon
              ? Border.all(color: HuddleTheme.neonCyan, width: 1.5)
              : Border.all(color: HuddleTheme.ink, width: 1.5),
          boxShadow: isNeon
              ? const [HuddleTheme.shadowCyanGlow]
              : const [HuddleTheme.shadow],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Circular Progress Indicator
            SizedBox(
              width: size - 20,
              height: size - 20,
              child: CustomPaint(
                painter: _TimerRingPainter(
                  progress: progress,
                  trackColor: isNeon
                      ? HuddleTheme.neonCardAlt
                      : HuddleTheme.background,
                  progressColor: isNeon
                      ? (isFocusing ? HuddleTheme.neonCyan : HuddleTheme.neonViolet)
                      : HuddleTheme.accent,
                  borderColor: isNeon ? HuddleTheme.neonCyan : HuddleTheme.ink,
                ),
              ),
            ),

            // Central JetBrains Mono Timer Display
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    timeStr,
                    style: HuddleTheme.monoTimer(
                      color: isNeon ? Colors.white : HuddleTheme.ink,
                    ).copyWith(
                      fontSize: size * 0.20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: isNeon
                          ? (isFocusing
                              ? HuddleTheme.neonCyan
                              : HuddleTheme.neonCardAlt)
                          : (isFocusing
                              ? HuddleTheme.highlight
                              : HuddleTheme.ink),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: isNeon
                            ? (isFocusing
                                ? HuddleTheme.neonCyan
                                : HuddleTheme.neonCyan.withValues(alpha: 0.5))
                            : HuddleTheme.ink,
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      isFocusing ? 'LOCKED IN' : 'READY',
                      style: HuddleTheme.monoLabel(
                        color: isNeon
                            ? (isFocusing ? HuddleTheme.neonBg : Colors.white)
                            : (isFocusing ? HuddleTheme.ink : Colors.white),
                      ).copyWith(fontSize: 10, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimerRingPainter extends CustomPainter {
  final double progress;
  final Color trackColor;
  final Color progressColor;
  final Color borderColor;

  _TimerRingPainter({
    required this.progress,
    required this.trackColor,
    required this.progressColor,
    required this.borderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 16) / 2;
    const strokeWidth = 10.0;

    // Track Circle
    final trackPaint = Paint()
      ..color = HuddleTheme.ink.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, trackPaint);

    // Progress Arc
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _TimerRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.progressColor != progressColor;
  }
}
