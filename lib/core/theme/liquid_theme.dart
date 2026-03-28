// FILE: lib/core/theme/liquid_theme.dart

import 'package:flutter/material.dart';

class LiquidTheme {
  // Defining the core glass properties for 2026 standards
  static const double glassOpacity = 0.12;
  static const double glassBlur = 25.0;
  static const double borderOpacity = 0.2;

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF0A0A0E), // Deep midnight base
    fontFamily: 'Inter-Regular', // Defaulting to your uploaded asset
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Inter-Bold',
        fontSize: 32,
        color: Colors.white,
        letterSpacing: -0.5,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Inter-Medium',
        fontSize: 16,
        color: Colors.white.withOpacity(0.9),
      ),
    ),
  );
}
