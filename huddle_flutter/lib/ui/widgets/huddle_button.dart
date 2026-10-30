import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme.dart';

enum HuddleButtonVariant {
  accent,
  highlight,
  subtle,
  ink,
  neon,
  neonSubtle,
  neonMagenta;

  // Compatibility aliases
  static const HuddleButtonVariant volt = HuddleButtonVariant.highlight;
  static const HuddleButtonVariant cream = HuddleButtonVariant.subtle;
}

/// Interactive button with press-scale animation (150-200ms),
/// soft elevation shadow, and accessible WCAG AA contrast.
class HuddleButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final HuddleButtonVariant variant;
  final double height;
  final bool fullWidth;
  final String? tooltip;

  const HuddleButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.variant = HuddleButtonVariant.accent,
    this.height = 48,
    this.fullWidth = false,
    this.tooltip,
  });

  @override
  State<HuddleButton> createState() => _HuddleButtonState();
}

class _HuddleButtonState extends State<HuddleButton> {
  bool _isPressed = false;
  bool _isHovered = false;

  void _onTapDown(TapDownDetails _) {
    if (widget.onPressed == null) return;
    HapticFeedback.lightImpact();
    setState(() => _isPressed = true);
  }

  void _onTapUp(TapUpDetails _) {
    setState(() => _isPressed = false);
  }

  void _onTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    final duration = reduceMotion
        ? Duration.zero
        : const Duration(milliseconds: 180);

    Color bg;
    Color fg;
    Border border;

    switch (widget.variant) {
      case HuddleButtonVariant.accent:
        bg = HuddleTheme.accent;
        fg = Colors.white;
        border = Border.all(color: HuddleTheme.ink, width: 1.5);
        break;
      case HuddleButtonVariant.highlight:
        bg = HuddleTheme.highlight;
        fg = HuddleTheme.ink;
        border = Border.all(color: HuddleTheme.ink, width: 1.5);
        break;
      case HuddleButtonVariant.subtle:
        bg = HuddleTheme.background;
        fg = HuddleTheme.ink;
        border = Border.all(color: HuddleTheme.ink, width: 1.5);
        break;
      case HuddleButtonVariant.ink:
        bg = HuddleTheme.ink;
        fg = Colors.white;
        border = Border.all(color: HuddleTheme.ink, width: 1.5);
        break;
      case HuddleButtonVariant.neon:
        bg = HuddleTheme.neonCyan;
        fg = HuddleTheme.neonBg;
        border = Border.all(color: HuddleTheme.neonCyan, width: 1.5);
        break;
      case HuddleButtonVariant.neonSubtle:
        bg = HuddleTheme.neonCard;
        fg = HuddleTheme.neonCyan;
        border = Border.all(
          color: HuddleTheme.neonCyan.withValues(alpha: 0.6),
          width: 1.5,
        );
        break;
      case HuddleButtonVariant.neonMagenta:
        bg = HuddleTheme.neonMagenta;
        fg = Colors.white;
        border = Border.all(color: HuddleTheme.neonMagenta, width: 1.5);
        break;
    }

    final isEnabled = widget.onPressed != null;
    final isNeonVariant =
        widget.variant == HuddleButtonVariant.neon ||
        widget.variant == HuddleButtonVariant.neonSubtle ||
        widget.variant == HuddleButtonVariant.neonMagenta;

    if (!isEnabled) {
      if (isNeonVariant) {
        bg = HuddleTheme.neonCard;
        fg = HuddleTheme.neonTextMuted.withValues(alpha: 0.4);
        border = Border.all(
          color: HuddleTheme.neonCyan.withValues(alpha: 0.2),
          width: 1.5,
        );
      } else {
        bg = HuddleTheme.background;
        fg = HuddleTheme.ink.withValues(alpha: 0.4);
        border = Border.all(
          color: HuddleTheme.ink.withValues(alpha: 0.3),
          width: 1.5,
        );
      }
    }

    Widget buttonContent = AnimatedScale(
      scale: _isPressed ? 0.96 : (_isHovered ? 1.01 : 1.0),
      duration: duration,
      curve: Curves.easeOutCubic,
      child: AnimatedContainer(
        duration: duration,
        height: widget.height,
        constraints: const BoxConstraints(minHeight: 44, minWidth: 44),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: HuddleTheme.radius14,
          border: border,
          boxShadow: isEnabled
              ? (_isPressed
                    ? const []
                    : (_isHovered
                          ? (widget.variant == HuddleButtonVariant.neon
                                ? const [HuddleTheme.shadowCyanGlow]
                                : widget.variant ==
                                      HuddleButtonVariant.neonMagenta
                                ? const [HuddleTheme.shadowMagentaGlow]
                                : const [HuddleTheme.shadowHover])
                          : (widget.variant == HuddleButtonVariant.neon
                                ? const [HuddleTheme.shadowCyan]
                                : widget.variant ==
                                      HuddleButtonVariant.neonMagenta
                                ? const [HuddleTheme.shadowMagentaGlow]
                                : const [HuddleTheme.shadowSmall])))
              : null,
        ),
        child: Row(
          mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.icon != null) ...[
              Icon(widget.icon, size: 18, color: fg),
              const SizedBox(width: 8),
            ],
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
                child: Text(
                  widget.text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: HuddleTheme.body14(
                    color: fg,
                    fontWeight: FontWeight.w700,
                  ).copyWith(letterSpacing: 0.2),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    if (widget.tooltip != null) {
      buttonContent = Tooltip(message: widget.tooltip!, child: buttonContent);
    }

    return Semantics(
      button: true,
      enabled: isEnabled,
      label: widget.text,
      child: MouseRegion(
        cursor: isEnabled
            ? SystemMouseCursors.click
            : SystemMouseCursors.forbidden,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTapDown: isEnabled ? _onTapDown : null,
          onTapUp: isEnabled ? _onTapUp : null,
          onTapCancel: isEnabled ? _onTapCancel : null,
          onTap: widget.onPressed,
          behavior: HitTestBehavior.opaque,
          child: buttonContent,
        ),
      ),
    );
  }
}
