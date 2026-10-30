import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../services/user_service.dart';
import '../../theme.dart';

export '../../services/user_service.dart' show AvatarVibe;

/// Neon UI Cartoon Character Avatar drawn natively with Flutter [CustomPaint].
/// Replicates the friendly cartoon student from Image 2 with the luminous Neon Square theme from Image 1.
class HuddleAvatar extends StatefulWidget {
  final String name;
  final double size;
  final bool isFocusing;
  final bool isOnline;
  final bool useInitials;
  final AvatarVibe? vibe;
  final Color? neonColor;
  final VoidCallback? onTap;

  const HuddleAvatar({
    super.key,
    String? name,
    String? seed,
    this.size = 36,
    this.isFocusing = false,
    bool isOnline = false,
    bool showOnline = false,
    this.useInitials = false,
    this.vibe,
    this.neonColor,
    this.onTap,
  }) : name = seed ?? name ?? 'Student',
       isOnline = showOnline || isOnline;

  // Standard sizes specified by design guidelines: 24, 36, 56, 96, 120
  const HuddleAvatar.small({
    super.key,
    String? name,
    String? seed,
    this.isFocusing = false,
    bool isOnline = false,
    bool showOnline = false,
    this.useInitials = false,
    this.vibe,
    this.neonColor,
    this.onTap,
  }) : name = seed ?? name ?? 'Student',
       isOnline = showOnline || isOnline,
       size = 24;

  const HuddleAvatar.medium({
    super.key,
    String? name,
    String? seed,
    this.isFocusing = false,
    bool isOnline = false,
    bool showOnline = false,
    this.useInitials = false,
    this.vibe,
    this.neonColor,
    this.onTap,
  }) : name = seed ?? name ?? 'Student',
       isOnline = showOnline || isOnline,
       size = 36;

  const HuddleAvatar.large({
    super.key,
    String? name,
    String? seed,
    this.isFocusing = false,
    bool isOnline = false,
    bool showOnline = false,
    this.useInitials = false,
    this.vibe,
    this.neonColor,
    this.onTap,
  }) : name = seed ?? name ?? 'Student',
       isOnline = showOnline || isOnline,
       size = 56;

  const HuddleAvatar.xlarge({
    super.key,
    String? name,
    String? seed,
    this.isFocusing = false,
    bool isOnline = false,
    bool showOnline = false,
    this.useInitials = false,
    this.vibe,
    this.neonColor,
    this.onTap,
  }) : name = seed ?? name ?? 'Student',
       isOnline = showOnline || isOnline,
       size = 96;

  const HuddleAvatar.hero({
    super.key,
    String? name,
    String? seed,
    this.isFocusing = false,
    bool isOnline = false,
    bool showOnline = false,
    this.useInitials = false,
    this.vibe,
    this.neonColor,
    this.onTap,
  }) : name = seed ?? name ?? 'Student',
       isOnline = showOnline || isOnline,
       size = 120;

  @override
  State<HuddleAvatar> createState() => _HuddleAvatarState();
}

class _HuddleAvatarState extends State<HuddleAvatar>
    with SingleTickerProviderStateMixin {
  AnimationController? _pulseController;
  Animation<double>? _pulseAnimation;

  @override
  void initState() {
    super.initState();
    if (widget.isFocusing) {
      _startPulse();
    }
  }

  @override
  void didUpdateWidget(HuddleAvatar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFocusing != oldWidget.isFocusing) {
      if (widget.isFocusing) {
        _startPulse();
      } else {
        _pulseController?.stop();
      }
    }
  }

  void _startPulse() {
    _pulseController ??= AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _pulseAnimation ??= Tween<double>(begin: 1.0, end: 1.18).animate(
      CurvedAnimation(parent: _pulseController!, curve: Curves.easeInOut),
    );
    _pulseController!.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController?.dispose();
    super.dispose();
  }

  Color _resolveNeonColor(int hash) {
    if (widget.neonColor != null) return widget.neonColor!;
    final colors = [
      HuddleTheme.neonCyan, // Primary Electric Cyan (Image 1)
      HuddleTheme.teal, // Cyber Neon Teal
      HuddleTheme.neonSky, // Electric Sky
      HuddleTheme.violet, // Electric Violet
      HuddleTheme.pink, // Hot Neon Pink
    ];
    return colors[hash % colors.length];
  }

  AvatarVibe _resolveVibe(int hash) {
    if (widget.vibe != null) return widget.vibe!;
    final isMe =
        widget.name == UserService.instance.currentUser.value ||
        widget.name == UserService.instance.customAvatarSeed.value;
    if (isMe) {
      return UserService.instance.activeVibe.value;
    }
    return AvatarVibe.values[hash % AvatarVibe.values.length];
  }

  @override
  Widget build(BuildContext context) {
    final reducedMotion =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    final totalSize = widget.size + (widget.isFocusing ? 10 : 0);
    final hash = widget.name.hashCode.abs();
    final effectiveNeon = _resolveNeonColor(hash);
    final effectiveVibe = _resolveVibe(hash);

    Widget avatarWidget = SizedBox(
      width: totalSize,
      height: totalSize,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Focusing animated glowing neon pulse ring (Image 1 Neon Style)
          if (widget.isFocusing)
            AnimatedBuilder(
              animation: _pulseAnimation ?? const AlwaysStoppedAnimation(1.0),
              builder: (context, child) {
                final scale = (reducedMotion || _pulseAnimation == null)
                    ? 1.10
                    : _pulseAnimation!.value;
                return Transform.scale(
                  scale: scale,
                  child: Container(
                    width: widget.size + 8,
                    height: widget.size + 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: effectiveNeon,
                        width: 2.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: effectiveNeon.withValues(alpha: 0.6),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

          // Main Neon UI Cartoon Character circle (Image 1 + Image 2)
          Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF0D1836),
              border: Border.all(
                color: effectiveNeon,
                width: math.max(1.8, widget.size * 0.038),
              ),
              boxShadow: [
                BoxShadow(
                  color: effectiveNeon.withValues(alpha: 0.45),
                  offset: const Offset(0, 2),
                  blurRadius: 6,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: ClipOval(
              child: widget.useInitials
                  ? _buildInitials()
                  : CustomPaint(
                      size: Size(widget.size, widget.size),
                      painter: NeonCartoonPainter(
                        seed: widget.name,
                        vibe: effectiveVibe,
                        neonColor: effectiveNeon,
                      ),
                    ),
            ),
          ),

          // Neon Online Status Dot (Image 1 Electric Cyan / Volt dot)
          if (widget.isOnline)
            Positioned(
              right: widget.isFocusing ? 4 : 0,
              bottom: widget.isFocusing ? 4 : 0,
              child: Container(
                width: math.max(8.0, widget.size * 0.26),
                height: math.max(8.0, widget.size * 0.26),
                decoration: BoxDecoration(
                  color: HuddleTheme.neonCyan,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF060B19),
                    width: 1.5,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x9900F0FF),
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );

    if (widget.onTap != null) {
      return InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(999),
        child: avatarWidget,
      );
    }

    return avatarWidget;
  }

  Widget _buildInitials() {
    final initials = _getInitials(widget.name);
    return Container(
      color: const Color(0xFF0D1836),
      alignment: Alignment.center,
      child: Text(
        initials,
        style:
            HuddleTheme.body14(
              color: HuddleTheme.neonCyan,
              fontWeight: FontWeight.w700,
            ).copyWith(
              fontSize: widget.size * 0.38,
              letterSpacing: 0.5,
            ),
      ),
    );
  }

  static String _getInitials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts[0].isEmpty) return '?';
    if (parts.length == 1) {
      return parts[0].substring(0, math.min(2, parts[0].length)).toUpperCase();
    }
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }
}

/// Exact vector reproduction of the cartoon character from Image 2,
/// styled with the luminous "Neon Square" UI aesthetic from Image 1.
class NeonCartoonPainter extends CustomPainter {
  final String seed;
  final AvatarVibe vibe;
  final Color? neonColor;

  NeonCartoonPainter({
    required this.seed,
    required this.vibe,
    this.neonColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final center = Offset(w / 2, h / 2);

    // 1. Background Fill: Warm Coral from Image 2 (#F26868) with Neon Midnight depth
    final bgPaint = Paint()..color = const Color(0xFFF16565);
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), bgPaint);

    final outlinePaint = Paint()
      ..color = const Color(0xFF1E1824)
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(1.4, w * 0.038)
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final inkFill = Paint()..color = const Color(0xFF1E1824);

    // 2. Ears (Image 2: stylized curved ears with inner pink curve)
    final earSkinPaint = Paint()..color = const Color(0xFFFBD3B0);
    final earShadowPaint = Paint()..color = const Color(0xFFEB9F80);

    // Left Ear
    final leftEarCenter = Offset(w * 0.22, h * 0.47);
    final leftEarRect = Rect.fromCenter(
      center: leftEarCenter,
      width: w * 0.16,
      height: h * 0.22,
    );
    canvas.drawOval(leftEarRect, earSkinPaint);
    canvas.drawOval(leftEarRect, outlinePaint);
    final leftInnerEar = Rect.fromCenter(
      center: Offset(w * 0.23, h * 0.48),
      width: w * 0.08,
      height: h * 0.12,
    );
    canvas.drawOval(leftInnerEar, earShadowPaint);

    // Right Ear
    final rightEarCenter = Offset(w * 0.78, h * 0.47);
    final rightEarRect = Rect.fromCenter(
      center: rightEarCenter,
      width: w * 0.16,
      height: h * 0.22,
    );
    canvas.drawOval(rightEarRect, earSkinPaint);
    canvas.drawOval(rightEarRect, outlinePaint);
    final rightInnerEar = Rect.fromCenter(
      center: Offset(w * 0.77, h * 0.48),
      width: w * 0.08,
      height: h * 0.12,
    );
    canvas.drawOval(rightInnerEar, earShadowPaint);

    // 3. Clothes from Image 2:
    // Navy jacket (#1B355A), Cyan/Teal collar trim (#20A39E), Red shirt (#D33F49)
    final jacketPaint = Paint()..color = const Color(0xFF1B355A);
    final cyanTrimPaint = Paint()..color = const Color(0xFF20A39E);
    final redShirtPaint = Paint()..color = const Color(0xFFD33F49);

    // Outer Jacket Shoulders
    final shoulderPath = Path()
      ..moveTo(w * 0.08, h)
      ..quadraticBezierTo(w * 0.20, h * 0.72, w * 0.36, h * 0.72)
      ..lineTo(w * 0.64, h * 0.72)
      ..quadraticBezierTo(w * 0.80, h * 0.72, w * 0.92, h)
      ..close();
    canvas.drawPath(shoulderPath, jacketPaint);
    canvas.drawPath(shoulderPath, outlinePaint);

    // Inner Crewneck Coral/Red Shirt
    final shirtPath = Path()
      ..moveTo(w * 0.36, h * 0.72)
      ..lineTo(w * 0.36, h)
      ..lineTo(w * 0.64, h)
      ..lineTo(w * 0.64, h * 0.72)
      ..quadraticBezierTo(w * 0.50, h * 0.80, w * 0.36, h * 0.72);
    canvas.drawPath(shirtPath, redShirtPaint);
    canvas.drawPath(shirtPath, outlinePaint);

    // Shirt Collar Band Curve
    final collarBand = Path()
      ..moveTo(w * 0.38, h * 0.72)
      ..quadraticBezierTo(w * 0.50, h * 0.77, w * 0.62, h * 0.72);
    canvas.drawPath(collarBand, outlinePaint);

    // Teal Inner Collar / Hood Lining (Image 2 exact match)
    final leftTealTrim = Path()
      ..moveTo(w * 0.36, h * 0.72)
      ..quadraticBezierTo(w * 0.28, h * 0.64, w * 0.35, h * 0.60)
      ..quadraticBezierTo(w * 0.42, h * 0.68, w * 0.38, h)
      ..lineTo(w * 0.34, h)
      ..close();
    canvas.drawPath(leftTealTrim, cyanTrimPaint);
    canvas.drawPath(leftTealTrim, outlinePaint);

    final rightTealTrim = Path()
      ..moveTo(w * 0.64, h * 0.72)
      ..quadraticBezierTo(w * 0.72, h * 0.64, w * 0.65, h * 0.60)
      ..quadraticBezierTo(w * 0.58, h * 0.68, w * 0.62, h)
      ..lineTo(w * 0.66, h)
      ..close();
    canvas.drawPath(rightTealTrim, cyanTrimPaint);
    canvas.drawPath(rightTealTrim, outlinePaint);

    // White Zipper Lines down jacket
    final zipperPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = math.max(1.2, w * 0.02)
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(w * 0.36, h * 0.85),
      Offset(w * 0.36, h),
      zipperPaint,
    );
    canvas.drawLine(
      Offset(w * 0.64, h * 0.85),
      Offset(w * 0.64, h),
      zipperPaint,
    );

    // 4. Neck & Chin Shadow
    final neckSkinPaint = Paint()..color = const Color(0xFFFBD3B0);
    final neckShadow = Paint()..color = const Color(0xFFE5A986);
    final neckRect = Rect.fromCenter(
      center: Offset(center.dx, h * 0.66),
      width: w * 0.22,
      height: h * 0.16,
    );
    canvas.drawRect(neckRect, neckSkinPaint);
    canvas.drawLine(
      Offset(neckRect.left, neckRect.top),
      Offset(neckRect.left, neckRect.bottom),
      outlinePaint,
    );
    canvas.drawLine(
      Offset(neckRect.right, neckRect.top),
      Offset(neckRect.right, neckRect.bottom),
      outlinePaint,
    );
    // Shadow under chin
    final chinShadowPath = Path()
      ..moveTo(neckRect.left, neckRect.top + h * 0.03)
      ..quadraticBezierTo(
        center.dx,
        neckRect.top + h * 0.07,
        neckRect.right,
        neckRect.top + h * 0.03,
      )
      ..lineTo(neckRect.right, neckRect.top)
      ..lineTo(neckRect.left, neckRect.top)
      ..close();
    canvas.drawPath(chinShadowPath, neckShadow);

    // 5. Rounded Cartoon Face from Image 2
    final faceSkin = Paint()..color = const Color(0xFFFBD3B0);
    final facePath = Path()
      ..moveTo(w * 0.26, h * 0.40)
      ..quadraticBezierTo(w * 0.24, h * 0.58, w * 0.38, h * 0.67)
      ..quadraticBezierTo(w * 0.50, h * 0.70, w * 0.62, h * 0.67)
      ..quadraticBezierTo(w * 0.76, h * 0.58, w * 0.74, h * 0.40)
      ..quadraticBezierTo(w * 0.50, h * 0.34, w * 0.26, h * 0.40);
    canvas.drawPath(facePath, faceSkin);
    canvas.drawPath(facePath, outlinePaint);

    // Soft Peach Cheek Blush Spots (Image 2 exact match)
    final blushPaint = Paint()
      ..color = const Color(0xFFF6A48F).withValues(alpha: 0.65);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.34, h * 0.52),
        width: w * 0.11,
        height: h * 0.05,
      ),
      blushPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.66, h * 0.52),
        width: w * 0.11,
        height: h * 0.05,
      ),
      blushPaint,
    );

    // 6. Hair from Image 2:
    // Dark Charcoal Purple (#2B2338) with spiky top tufts and right cowlick
    final hairPaint = Paint()..color = const Color(0xFF2B2338);

    final hairPath = Path()
      // Left sideburn & fringe
      ..moveTo(w * 0.24, h * 0.48)
      ..lineTo(w * 0.26, h * 0.38)
      // Left forehead bangs
      ..quadraticBezierTo(w * 0.30, h * 0.44, w * 0.36, h * 0.36)
      ..quadraticBezierTo(w * 0.44, h * 0.42, w * 0.50, h * 0.32)
      // Right forehead bangs & sideburn
      ..quadraticBezierTo(w * 0.60, h * 0.38, w * 0.68, h * 0.36)
      ..lineTo(w * 0.74, h * 0.48)
      // Outer Right cowlick & tufts (Image 2 silhouette)
      ..quadraticBezierTo(w * 0.82, h * 0.40, w * 0.84, h * 0.28)
      ..lineTo(w * 0.76, h * 0.24)
      ..quadraticBezierTo(w * 0.82, h * 0.16, w * 0.70, h * 0.10)
      // Top spiky crown tufts (pointing right and up)
      ..lineTo(w * 0.62, h * 0.16)
      ..lineTo(w * 0.56, h * 0.06) // Highest top spike
      ..lineTo(w * 0.46, h * 0.14)
      ..lineTo(w * 0.36, h * 0.09) // Left-top spike
      ..lineTo(w * 0.32, h * 0.18)
      // Outer Left hair curve
      ..quadraticBezierTo(w * 0.18, h * 0.24, w * 0.20, h * 0.38)
      ..close();

    canvas.drawPath(hairPath, hairPaint);
    canvas.drawPath(hairPath, outlinePaint);

    // 6.5 Floating Cyber Halo (Signature feature from Image 1 NFT cards)
    final haloColor = neonColor ?? const Color(0xFF00F0FF);
    final haloRect = Rect.fromCenter(
      center: Offset(w * 0.50, h * 0.08),
      width: w * 0.58,
      height: h * 0.16,
    );
    // Outer luminous glow
    canvas.drawOval(
      haloRect,
      Paint()
        ..color = haloColor.withValues(alpha: 0.45)
        ..style = PaintingStyle.stroke
        ..strokeWidth = math.max(3.2, w * 0.08),
    );
    // White inner core
    canvas.drawOval(
      haloRect,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = math.max(1.2, w * 0.025),
    );
    // Vibrant neon stroke
    canvas.drawOval(
      haloRect,
      Paint()
        ..color = haloColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = math.max(2.0, w * 0.045),
    );

    // 7. Expressive Eyes & Eyebrows from Image 2
    _drawEyesNoseMouth(canvas, size, outlinePaint, inkFill, vibe);

    // 8. Optional Vibe Accessories (Headphones, Visor, Star Glasses)
    _drawVibeAccessories(canvas, size, outlinePaint, w, h, center);
  }

  void _drawEyesNoseMouth(
    Canvas canvas,
    Size size,
    Paint outlinePaint,
    Paint inkFill,
    AvatarVibe vibe,
  ) {
    final w = size.width;
    final h = size.height;

    // Eyebrows from Image 2: arched dark expressive brows
    final browPaint = Paint()
      ..color = const Color(0xFF2B2338)
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(1.8, w * 0.045)
      ..strokeCap = StrokeCap.round;

    final leftBrow = Path()
      ..moveTo(w * 0.31, h * 0.39)
      ..quadraticBezierTo(w * 0.37, h * 0.35, w * 0.44, h * 0.38);
    canvas.drawPath(leftBrow, browPaint);

    final rightBrow = Path()
      ..moveTo(w * 0.56, h * 0.38)
      ..quadraticBezierTo(w * 0.63, h * 0.35, w * 0.69, h * 0.39);
    canvas.drawPath(rightBrow, browPaint);

    // Nose from Image 2: cute small curved nose line
    final nosePaint = Paint()
      ..color = const Color(0xFF9E654C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(1.3, w * 0.03)
      ..strokeCap = StrokeCap.round;
    final nose = Path()
      ..moveTo(w * 0.49, h * 0.52)
      ..quadraticBezierTo(w * 0.52, h * 0.54, w * 0.48, h * 0.55);
    canvas.drawPath(nose, nosePaint);

    // Mouth from Image 2: warm, friendly, confident curved smile
    final mouthPaint = Paint()
      ..color = const Color(0xFF1E1824)
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(1.6, w * 0.038)
      ..strokeCap = StrokeCap.round;
    final smile = Path()
      ..moveTo(w * 0.43, h * 0.59)
      ..quadraticBezierTo(w * 0.50, h * 0.63, w * 0.57, h * 0.59);
    canvas.drawPath(smile, mouthPaint);

    // EYES from Image 2:
    // Large cartoon eyes with brown iris & signature double catchlight highlights!
    if (vibe == AvatarVibe.campusCheer) {
      // Joyful arc eyes (^_^)
      final arcPaint = Paint()
        ..color = const Color(0xFF1E1824)
        ..style = PaintingStyle.stroke
        ..strokeWidth = math.max(2.0, w * 0.05)
        ..strokeCap = StrokeCap.round;
      final leftArc = Path()
        ..moveTo(w * 0.33, h * 0.47)
        ..quadraticBezierTo(w * 0.39, h * 0.42, w * 0.45, h * 0.47);
      final rightArc = Path()
        ..moveTo(w * 0.55, h * 0.47)
        ..quadraticBezierTo(w * 0.61, h * 0.42, w * 0.67, h * 0.47);
      canvas.drawPath(leftArc, arcPaint);
      canvas.drawPath(rightArc, arcPaint);
    } else if (vibe == AvatarVibe.gamerPro) {
      // Left eye wink (>), right eye open star eye
      final winkPaint = Paint()
        ..color = const Color(0xFF1E1824)
        ..style = PaintingStyle.stroke
        ..strokeWidth = math.max(2.0, w * 0.05)
        ..strokeCap = StrokeCap.round;
      final wink = Path()
        ..moveTo(w * 0.33, h * 0.44)
        ..lineTo(w * 0.41, h * 0.47)
        ..lineTo(w * 0.33, h * 0.50);
      canvas.drawPath(wink, winkPaint);
      _drawSingleImage2Eye(canvas, Offset(w * 0.61, h * 0.46), w * 0.075);
    } else {
      // Standard signature Image 2 eyes!
      _drawSingleImage2Eye(canvas, Offset(w * 0.39, h * 0.46), w * 0.075);
      _drawSingleImage2Eye(canvas, Offset(w * 0.61, h * 0.46), w * 0.075);
    }
  }

  void _drawSingleImage2Eye(Canvas canvas, Offset center, double radius) {
    // Eye White (Sclera)
    final scleraPaint = Paint()..color = Colors.white;
    final eyeRect = Rect.fromCenter(
      center: center,
      width: radius * 2.1,
      height: radius * 2.3,
    );
    canvas.drawOval(eyeRect, scleraPaint);
    canvas.drawOval(
      eyeRect,
      Paint()
        ..color = const Color(0xFF1E1824)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4,
    );

    // Warm Chocolate-Chestnut Iris (Image 2)
    final irisPaint = Paint()..color = const Color(0xFF4A2C1D);
    final irisCenter = Offset(center.dx, center.dy);
    canvas.drawCircle(irisCenter, radius * 0.88, irisPaint);

    // Deep Black Pupil
    final pupilPaint = Paint()..color = const Color(0xFF1A100C);
    canvas.drawCircle(irisCenter, radius * 0.58, pupilPaint);

    // Signature Anime Specular Catchlights (Image 2 exact match)
    // 1. Large shine dot (upper left)
    final shineBig = Paint()..color = Colors.white;
    canvas.drawCircle(
      Offset(center.dx - radius * 0.28, center.dy - radius * 0.26),
      radius * 0.34,
      shineBig,
    );
    // 2. Small catchlight dot (lower right)
    canvas.drawCircle(
      Offset(center.dx + radius * 0.26, center.dy + radius * 0.24),
      radius * 0.16,
      shineBig,
    );
  }

  void _drawVibeAccessories(
    Canvas canvas,
    Size size,
    Paint outlinePaint,
    double w,
    double h,
    Offset center,
  ) {
    final effectiveCyan = neonColor ?? HuddleTheme.neonCyan;

    switch (vibe) {
      case AvatarVibe.lofiCoder:
        // Over-ear Studio Headphones with Glowing Cyan Cups (Image 1 + 2)
        final hpPaint = Paint()..color = effectiveCyan;
        final hpStroke = Paint()
          ..color = const Color(0xFF1E1824)
          ..style = PaintingStyle.stroke
          ..strokeWidth = math.max(1.8, w * 0.05);

        // Headband Arc
        final hpArc = Path()
          ..moveTo(w * 0.14, h * 0.44)
          ..quadraticBezierTo(w * 0.50, h * 0.04, w * 0.86, h * 0.44);
        canvas.drawPath(hpArc, hpStroke);

        // Left Ear Cup
        final leftCup = RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(w * 0.14, h * 0.46),
            width: w * 0.14,
            height: h * 0.24,
          ),
          Radius.circular(w * 0.06),
        );
        canvas.drawRRect(leftCup, hpPaint);
        canvas.drawRRect(leftCup, outlinePaint);

        // Right Ear Cup
        final rightCup = RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(w * 0.86, h * 0.46),
            width: w * 0.14,
            height: h * 0.24,
          ),
          Radius.circular(w * 0.06),
        );
        canvas.drawRRect(rightCup, hpPaint);
        canvas.drawRRect(rightCup, outlinePaint);
        break;

      case AvatarVibe.cyberVisor:
        // Glowing Neon HUD Visor (Image 1 Neon Square theme)
        final visorRect = Rect.fromCenter(
          center: Offset(center.dx, h * 0.46),
          width: w * 0.64,
          height: h * 0.15,
        );
        final visorRRect = RRect.fromRectAndRadius(
          visorRect,
          Radius.circular(w * 0.04),
        );
        canvas.drawRRect(visorRRect, Paint()..color = const Color(0xFF060B19));
        canvas.drawRRect(
          visorRRect,
          Paint()
            ..color = effectiveCyan
            ..style = PaintingStyle.stroke
            ..strokeWidth = math.max(1.8, w * 0.04),
        );
        // Laser scanline
        canvas.drawLine(
          Offset(visorRect.left + w * 0.04, visorRect.center.dy),
          Offset(visorRect.right - w * 0.04, visorRect.center.dy),
          Paint()
            ..color = Colors.white
            ..strokeWidth = 1.5,
        );
        break;

      case AvatarVibe.starScholar:
        // Glowing Star Sunglasses
        final starPaint = Paint()..color = const Color(0xFF1E1824);
        _drawStar(canvas, Offset(w * 0.39, h * 0.46), w * 0.13, starPaint);
        _drawStar(canvas, Offset(w * 0.61, h * 0.46), w * 0.13, starPaint);
        canvas.drawLine(
          Offset(w * 0.46, h * 0.46),
          Offset(w * 0.54, h * 0.46),
          outlinePaint,
        );
        break;

      case AvatarVibe.neonNeko:
        // Glowing Neon Cat Ears (Image 1 + 2)
        final leftEar = Path()
          ..moveTo(w * 0.24, h * 0.26)
          ..lineTo(w * 0.26, h * 0.08)
          ..lineTo(w * 0.42, h * 0.18)
          ..close();
        canvas.drawPath(leftEar, Paint()..color = const Color(0xFF2B2338));
        canvas.drawPath(leftEar, outlinePaint);
        final innerLeft = Path()
          ..moveTo(w * 0.27, h * 0.23)
          ..lineTo(w * 0.29, h * 0.11)
          ..lineTo(w * 0.39, h * 0.18)
          ..close();
        canvas.drawPath(innerLeft, Paint()..color = effectiveCyan);

        final rightEar = Path()
          ..moveTo(w * 0.76, h * 0.26)
          ..lineTo(w * 0.74, h * 0.08)
          ..lineTo(w * 0.58, h * 0.18)
          ..close();
        canvas.drawPath(rightEar, Paint()..color = const Color(0xFF2B2338));
        canvas.drawPath(rightEar, outlinePaint);
        final innerRight = Path()
          ..moveTo(w * 0.73, h * 0.23)
          ..lineTo(w * 0.71, h * 0.11)
          ..lineTo(w * 0.61, h * 0.18)
          ..close();
        canvas.drawPath(innerRight, Paint()..color = effectiveCyan);
        break;

      case AvatarVibe.lateNightCram:
        // Cheek Band-aid
        final stickerRect = Rect.fromCenter(
          center: Offset(w * 0.35, h * 0.56),
          width: w * 0.12,
          height: h * 0.05,
        );
        canvas.save();
        canvas.translate(w * 0.35, h * 0.56);
        canvas.rotate(0.2);
        canvas.translate(-w * 0.35, -h * 0.56);
        canvas.drawRRect(
          RRect.fromRectAndRadius(stickerRect, const Radius.circular(2)),
          Paint()..color = effectiveCyan,
        );
        canvas.drawRRect(
          RRect.fromRectAndRadius(stickerRect, const Radius.circular(2)),
          outlinePaint,
        );
        canvas.restore();
        break;

      default:
        break;
    }
  }

  void _drawStar(Canvas canvas, Offset center, double radius, Paint paint) {
    final path = Path();
    for (int i = 0; i < 5; i++) {
      final outerAngle = (i * 72 - 90) * math.pi / 180;
      final innerAngle = (outerAngle + 36 * math.pi / 180);
      final outerPoint = Offset(
        center.dx + radius * math.cos(outerAngle),
        center.dy + radius * math.sin(outerAngle),
      );
      final innerPoint = Offset(
        center.dx + (radius * 0.45) * math.cos(innerAngle),
        center.dy + (radius * 0.45) * math.sin(innerAngle),
      );
      if (i == 0) {
        path.moveTo(outerPoint.dx, outerPoint.dy);
      } else {
        path.lineTo(outerPoint.dx, outerPoint.dy);
      }
      path.lineTo(innerPoint.dx, innerPoint.dy);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant NeonCartoonPainter oldDelegate) {
    return oldDelegate.seed != seed ||
        oldDelegate.vibe != vibe ||
        oldDelegate.neonColor != neonColor;
  }
}
