// FILE: lib/ui/components/liquid_glass_container.dart
import 'dart:ui';
import 'package:flutter/material.dart';

/// Shared glassmorphism container used throughout the app.
/// Replaces the LiquidTheme dependency with inlined constants.
class LiquidGlassContainer extends StatelessWidget {
  const LiquidGlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 24.0,
    this.padding = const EdgeInsets.all(16.0),
  });

  final Widget child;
  final double borderRadius;
  final EdgeInsets padding;

  // Inlined from deleted LiquidTheme
  static const double _blur        = 25.0;
  static const double _glassAlpha  = 0.12; // 12% white
  static const double _borderAlpha = 0.20; // 20% white

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: _blur, sigmaY: _blur),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: _glassAlpha),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: Colors.white.withValues(alpha: _borderAlpha),
              width: 1.2,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
