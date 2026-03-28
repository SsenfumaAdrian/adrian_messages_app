// FILE: lib/ui/components/liquid_glass_container.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/liquid_theme.dart';

class LiquidGlassContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsets padding;

  const LiquidGlassContainer({
    Key? key,
    required this.child,
    this.borderRadius = 24.0,
    this.padding = const EdgeInsets.all(16.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: LiquidTheme.glassBlur, sigmaY: LiquidTheme.glassBlur),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(LiquidTheme.glassOpacity),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: Colors.white.withOpacity(LiquidTheme.borderOpacity),
              width: 1.2,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
