// FILE: lib/core/constants/palette.dart
//
// ⚠️  FIXED: Previous palette was dark-theme only (#041024 bg).
//     Every Stitch screen uses a LIGHT theme.
//     These tokens match the Stitch design system exactly.
//
// TWO MODE SUPPORT:
//   • Palette.light   → light mode (Stitch design, default)
//   • Palette.dark    → dark mode (auth / splash screens retain dark glass)

import 'package:flutter/material.dart';

class Palette {
  Palette._();

  // ── BRAND ─────────────────────────────────────────────────
  /// Primary brand blue — #1A237E (deep indigo)
  static const Color primary = Color(0xFF1A237E);

  /// Primary container — slightly lighter indigo
  static const Color primaryContainer = Color(0xFF233141);

  /// On-primary (text/icon on primary bg) — white
  static const Color onPrimary = Color(0xFFFFFFFF);

  // ── SURFACE HIERARCHY (light mode) ────────────────────────
  /// Base canvas — off-white with a blue tint
  static const Color surface = Color(0xFFFBF8FF);

  /// Slight step down — utility sidebars, input backgrounds
  static const Color surfaceContainerLow = Color(0xFFF3F4F5);

  /// Default container — cards sitting on surfaceContainerLow
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);

  /// Slightly elevated container — active states, selected rows
  static const Color surfaceContainerHigh = Color(0xFFEAE7EF);

  /// Highest contrast container — tooltips, overlays
  static const Color surfaceContainerHighest = Color(0xFFE4E1EA);

  // ── TEXT (light mode) ─────────────────────────────────────
  /// Primary text — near-black, NOT pure black (per design rules)
  static const Color onSurface = Color(0xFF191C1D);

  /// Secondary / metadata text
  static const Color onSurfaceVariant = Color(0xFF454652);

  /// Muted label text — timestamps, hints
  static const Color outline = Color(0xFF767683);

  /// Ghost border fallback (use at 15% opacity max)
  static const Color outlineVariant = Color(0xFFC6C5D4);

  // ── TERTIARY / ACCENT ─────────────────────────────────────
  /// Cyan accent — online indicators, highlights, links
  /// Stitch: tertiary-fixed-dim = #00DAF3
  static const Color accentCyan = Color(0xFF00DAF3);

  /// Warm accent — concierge pulse, urgent alerts
  static const Color tertiary = Color(0xFF001F24);
  static const Color tertiaryContainer = Color(0xFF00363D);
  static const Color tertiaryFixed = Color(0xFF9CF0FF);

  // ── SEMANTIC ──────────────────────────────────────────────
  static const Color error = Color(0xFFB3261E);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color success = Color(0xFF00695C);

  // ── DARK MODE (auth / splash glass surfaces) ──────────────
  static const Color darkBackground = Color(0xFF060D1F);
  static const Color darkSurface = Color(0xFF0E1733);
  static const Color darkSurfaceLow = Color(0xFF121320);

  /// Glass card fill used in auth screen
  static const Color glassCard = Color(0x370818500); // 8,24,80 @ 55%
  /// Glass border
  static const Color glassBorder = Color(0x37FFFFFF);

  // ── TYPOGRAPHY helpers ────────────────────────────────────
  static const String fontDisplay = 'Manrope'; // headlines
  static const String fontBody = 'Inter'; // body / labels

  // ── ThemeData factories ───────────────────────────────────

  /// Light theme — matches all 30 Stitch screens
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          primary: primary,
          onPrimary: onPrimary,
          primaryContainer: primaryContainer,
          surface: surface,
          onSurface: onSurface,
          onSurfaceVariant: onSurfaceVariant,
          outline: outline,
          outlineVariant: outlineVariant,
          error: error,
          onError: onError,
        ),
        scaffoldBackgroundColor: surface,
        fontFamily: fontBody,
        textTheme: _textTheme(onSurface),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          titleTextStyle: TextStyle(
            fontFamily: fontDisplay,
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: primary,
          ),
        ),
        dividerTheme: const DividerThemeData(color: Colors.transparent),
      );

  /// Dark theme — auth / splash only
  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: accentCyan,
          onPrimary: darkBackground,
          surface: darkSurface,
          onSurface: Color(0xFFE9ECF5),
          onSurfaceVariant: Color(0xFF9BB0D1),
        ),
        scaffoldBackgroundColor: darkBackground,
        fontFamily: fontBody,
        textTheme: _textTheme(const Color(0xFFE9ECF5)),
      );

  static TextTheme _textTheme(Color baseColor) => TextTheme(
        // Display — Manrope, editorial moments
        displayLarge: TextStyle(
          fontFamily: fontDisplay,
          fontSize: 57,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.02 * 57,
          color: baseColor,
        ),
        displayMedium: TextStyle(
          fontFamily: fontDisplay,
          fontSize: 45,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.02 * 45,
          color: baseColor,
        ),
        displaySmall: TextStyle(
          fontFamily: fontDisplay,
          fontSize: 36,
          fontWeight: FontWeight.w700,
          color: baseColor,
        ),
        // Headline — section titles
        headlineLarge: TextStyle(
          fontFamily: fontDisplay,
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: baseColor,
        ),
        headlineMedium: TextStyle(
          fontFamily: fontDisplay,
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: baseColor,
        ),
        headlineSmall: TextStyle(
          fontFamily: fontDisplay,
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: baseColor,
        ),
        // Title — cards, message headers
        titleLarge: TextStyle(
          fontFamily: fontDisplay,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: baseColor,
        ),
        titleMedium: TextStyle(
          fontFamily: fontBody,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: baseColor,
        ),
        titleSmall: TextStyle(
          fontFamily: fontBody,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: baseColor,
        ),
        // Body — message content
        bodyLarge: TextStyle(
          fontFamily: fontBody,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.5,
          color: baseColor,
        ),
        bodyMedium: TextStyle(
          fontFamily: fontBody,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: baseColor,
        ),
        bodySmall: const TextStyle(
          fontFamily: fontBody,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: onSurfaceVariant,
        ),
        // Label — timestamps, metadata
        labelLarge: TextStyle(
          fontFamily: fontBody,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
          color: baseColor,
        ),
        labelMedium: const TextStyle(
          fontFamily: fontBody,
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: onSurfaceVariant,
        ),
        labelSmall: const TextStyle(
          fontFamily: fontBody,
          fontSize: 10,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.5,
          color: onSurfaceVariant,
        ),
      );
}
