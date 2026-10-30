import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Huddle Design System Tokens
/// Modern, clean, playful and confident campus peer learning theme.
/// Rules: Solid flat colors only, NO gradients, NO blur halos.
class HuddleTheme {
  // MODERN GEN Z COLOR PALETTE
  static const Color background = Color(0xFFF7F5F0);
  static const Color ink = Color(0xFF17171C);
  static const Color accent = Color(0xFF6C4DFF); // Electric Violet
  static const Color highlight = Color(0xFFFFD23F); // Solar Sparkle

  // GEN Z COOL ACCENTS & TOKENS
  static const Color violet = Color(0xFF6C4DFF); // Electric Violet
  static const Color teal = Color(0xFF14B8A6); // Cyber Neon Teal
  static const Color pink = Color(0xFFFF5C8A); // Hot Neon Pink
  static const Color volt = Color(0xFFCCFF00); // Electric Volt Lime
  static const Color navy = Color(0xFF0B1020); // Deep Space Navy
  static const Color darkCard = Color(0xFF151B33); // Midnight Card Canvas
  static const Color darkBorder = Color(0xFF283256);

  // NEON DASHBOARD THEME TOKENS (IMAGE 1 & IMAGE 2 SPEC)
  static const Color neonBg = Color(
    0xFF0B081E,
  ); // Deep Dark Midnight Violet (Image 1)
  static const Color neonCard = Color(
    0xFF130D2E,
  ); // Dark Sleek Violet Card (Image 1)
  static const Color neonCardAlt = Color(
    0xFF1C1442,
  ); // Elevated Violet Card (Image 1)
  static const Color neonCyan = Color(
    0xFF00F0FF,
  ); // Luminous Electric Cyan Accent
  static const Color neonCyanGlow = Color(0xFF00E5FF);
  static const Color neonMagenta = Color(
    0xFFFF2A85,
  ); // Glowing Neon Magenta / Pink (Image 1)
  static const Color neonViolet = Color(
    0xFF8B5CF6,
  ); // Electric Cyber Violet (Image 1)
  static const Color neonSky = Color(0xFF38BDF8); // Electric Sky
  static const Color neonText = Colors.white;
  static const Color neonTextMuted = Color(
    0xFFA5B4FC,
  ); // Soft lavender muted text (Image 1)
  static const Color neonCoral = Color(
    0xFFD33F49,
  ); // Image 2 inner shirt accent
  static const Color neonTeal = Color(
    0xFF20A39E,
  ); // Image 2 inner collar accent

  // NEON BORDERS & SHADOWS
  static final Border borderCyan = Border.all(color: neonCyan, width: 1.5);
  static final Border borderCyanSubtle = Border.all(
    color: const Color(0x6600F0FF),
    width: 1.5,
  );
  static final Border borderMagenta = Border.all(
    color: neonMagenta,
    width: 1.5,
  );
  static final Border borderNeonViolet = Border.all(
    color: neonViolet,
    width: 1.5,
  );
  static const BoxShadow shadowCyan = BoxShadow(
    color: Color(0x4000F0FF),
    offset: Offset(0, 2),
    blurRadius: 8.0,
    spreadRadius: 0,
  );
  static const BoxShadow shadowCyanGlow = BoxShadow(
    color: Color(0x6600F0FF),
    offset: Offset(0, 0),
    blurRadius: 12.0,
    spreadRadius: 1,
  );
  static const BoxShadow shadowMagentaGlow = BoxShadow(
    color: Color(0x66FF2A85),
    offset: Offset(0, 0),
    blurRadius: 12.0,
    spreadRadius: 1,
  );

  // Backward-compatibility aliases for existing models/widgets
  static const Color cream = background;

  // SEMANTIC TOKENS
  static const Color cardBackground = background;
  static const Color cardBorder = ink;
  static const BoxShadow cardShadow = BoxShadow(
    color: Color(0x1A17171C),
    offset: Offset(0, 2),
    blurRadius: 0.0,
    spreadRadius: 0,
  );
  static const double borderWidth = 1.5;
  static const Radius cardRadius = Radius.circular(14);
  static const Radius roundRadius = Radius.circular(999);

  // SOFT LOW SHADOWS (Elevation 2 max, no glow, no blur halos)
  static const BoxShadow shadow = BoxShadow(
    color: Color(0x1A17171C),
    offset: Offset(0, 2),
    blurRadius: 4,
    spreadRadius: 0,
  );

  static const BoxShadow shadowSmall = BoxShadow(
    color: Color(0x1417171C),
    offset: Offset(0, 1),
    blurRadius: 2,
    spreadRadius: 0,
  );

  static const BoxShadow shadowHover = BoxShadow(
    color: Color(0x2817171C),
    offset: Offset(0, 4),
    blurRadius: 6,
    spreadRadius: 0,
  );

  // BORDERS (Consistent 1.5px Ink borders)
  static final Border border = Border.all(color: ink, width: 1.5);
  static final Border borderAccent = Border.all(color: accent, width: 1.5);
  static final Border borderHighlight = Border.all(
    color: highlight,
    width: 1.5,
  );
  static final Border borderTeal = Border.all(color: teal, width: 1.5);
  static final Border borderPink = Border.all(color: pink, width: 1.5);
  static final Border borderVolt = Border.all(color: volt, width: 1.5);
  static final Border borderViolet = Border.all(color: violet, width: 1.5);

  // CORNER RADIUS (14px on cards, 999 only on avatars and chips)
  static const BorderRadius radius14 = BorderRadius.all(Radius.circular(14));
  static const BorderRadius radius8 = radius14; // Backward-compatible alias
  static const BorderRadius radiusRound = BorderRadius.all(
    Radius.circular(999),
  );

  // TYPOGRAPHY (Plus Jakarta Sans + JetBrains Mono)
  // Type scale: 12, 14, 16, 20, 28, 36, 48
  static TextStyle displayHero({double fontSize = 48, Color color = ink}) =>
      GoogleFonts.plusJakartaSans(
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        height: 1.05,
        letterSpacing: -1.0,
        color: color,
      );

  static TextStyle displayHeading({double fontSize = 20, Color color = ink}) =>
      GoogleFonts.plusJakartaSans(
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        height: 1.25,
        color: color,
      );

  static TextStyle displayTitle({Color color = ink}) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        height: 1.1,
        letterSpacing: -0.8,
        color: color,
      );

  static TextStyle heading28({Color color = ink}) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: -0.5,
        color: color,
      );

  static TextStyle heading20({Color color = ink}) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        height: 1.25,
        color: color,
      );

  static TextStyle body16({
    Color color = ink,
    FontWeight fontWeight = FontWeight.w400,
  }) => GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: fontWeight,
    height: 1.45,
    color: color,
  );

  static TextStyle body14({
    Color color = ink,
    FontWeight fontWeight = FontWeight.w400,
  }) => GoogleFonts.plusJakartaSans(
    fontSize: 14,
    fontWeight: fontWeight,
    height: 1.4,
    color: color,
  );

  static TextStyle monoLabel({Color color = ink}) => GoogleFonts.jetBrainsMono(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.6,
    color: color,
  );

  static TextStyle monoTimer({double fontSize = 48, Color color = ink}) =>
      GoogleFonts.jetBrainsMono(
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        letterSpacing: -1.0,
        color: color,
      );

  // TOPIC CHIP ACCENTS (Icon + Category styling using palette)
  static IconData iconForTopic(String topic) {
    final lower = topic.toLowerCase();
    if (lower.contains('dsa') ||
        lower.contains('algorithm') ||
        lower.contains('leetcode')) {
      return Icons.code_rounded;
    }
    if (lower.contains('ml') ||
        lower.contains('ai') ||
        lower.contains('transformer')) {
      return Icons.psychology_rounded;
    }
    if (lower.contains('dbms') ||
        lower.contains('sql') ||
        lower.contains('data')) {
      return Icons.dataset_rounded;
    }
    if (lower.contains('os') ||
        lower.contains('system') ||
        lower.contains('operating')) {
      return Icons.memory_rounded;
    }
    if (lower.contains('interview') ||
        lower.contains('career') ||
        lower.contains('faang')) {
      return Icons.work_rounded;
    }
    return Icons.school_rounded;
  }

  // FLUTTER THEMEDATA
  static ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      primaryColor: accent,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: accent,
        onPrimary: Colors.white,
        secondary: highlight,
        onSecondary: ink,
        error: ink,
        onError: Colors.white,
        surface: background,
        onSurface: ink,
      ),
      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        centerTitle: false,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: ink),
        titleTextStyle: GoogleFonts.plusJakartaSans(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: ink,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: ink,
        thickness: 1.5,
        space: 1.5,
      ),
    );
  }
}
