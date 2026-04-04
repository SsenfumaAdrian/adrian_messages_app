// FILE: lib/ui/components/logo_card.dart
//
// Shared LogoCard used by:
//  • LiquidSplashScreen  (size: 148, rounded: true)
//  • BrandingColumn      (size: 112/96, rounded: true)
//  • MobileLayout        (size: 56/64)
//
// The gradient + glow matches the splash screen exactly so both
// screens share the same visual identity.

import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';

class LogoCard extends StatelessWidget {
  const LogoCard({
    super.key,
    this.size = 112,
    this.rounded = false, // true = fully pill-shaped corners (splash / desktop)
  });

  final double size;
  final bool rounded;

  @override
  Widget build(BuildContext context) {
    // Corner radius: rounded=true → generous; false → standard
    final radius = rounded ? size * 0.30 : size * 0.22;
    final iconSize = size * 0.30;
    final titleFontSize = size * 0.105;
    final subFontSize = size * 0.062;

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            // ── Brand gradient — same across splash & auth ──
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xCC163A72), // Palette.accentIndigo tinted
                Color(0xAA0F6FFF), // const Color(0xFF0F6FFF)
                Color(0x882DE2E6), // Palette.accentCyan subtle
              ],
              stops: [0.0, 0.60, 1.0],
            ),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: const Color.fromARGB(60, 255, 255, 255),
              width: 1.5,
            ),
            boxShadow: [
              // Inner glow from the gradient
              BoxShadow(
                color: const Color(0xFF0F6FFF).withValues(alpha: 0.25),
                blurRadius: size * 0.35,
                spreadRadius: -size * 0.05,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ── Sparkle icon with subtle glow ────────────
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Colors.white, Palette.accentCyan],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(bounds),
                child: Icon(
                  Icons.auto_awesome_rounded,
                  color: Colors.white, // overridden by ShaderMask
                  size: iconSize,
                ),
              ),
              SizedBox(height: size * 0.07),
              // ── "ADRIAN" ─────────────────────────────────
              Text(
                'ADRIAN',
                style: TextStyle(
                  fontFamily: 'Inter-Bold',
                  color: Colors.white,
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  letterSpacing: titleFontSize * 0.35,
                ),
              ),
              SizedBox(height: size * 0.015),
              // ── "MESSAGES" ───────────────────────────────
              Text(
                'MESSAGES',
                style: TextStyle(
                  fontFamily: 'Inter-Regular',
                  color: const Color(0x88FFFFFF),
                  fontSize: subFontSize,
                  letterSpacing: subFontSize * 0.30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
