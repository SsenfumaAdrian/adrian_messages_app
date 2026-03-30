// FILE: lib/ui/components/liquid_dissolving_bubble.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import 'liquid_glass_container.dart';

class LiquidDissolvingBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final bool isDissolving;

  const LiquidDissolvingBubble({super.key, 
    required this.text,
    required this.isMe,
    this.isDissolving = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 1200),
      opacity: isDissolving ? 0.0 : 1.0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 1200),
        curve: Curves.easeInOutExpo,
        margin: const EdgeInsets.symmetric(vertical: 8),
        // When dissolving, the bubble 'shrinks' into the background
        transform: isDissolving
            ? (Matrix4.identity()..scale(0.8))
            : Matrix4.identity(),
        child: LiquidGlassContainer(
          borderRadius: 20,
          // If dissolving, we significantly increase the blur
          child: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: isDissolving ? 40 : 25, sigmaY: isDissolving ? 40 : 25),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                text,
                style: TextStyle(
                  color: isDissolving ? Colors.white10 : Colors.white,
                  fontFamily: 'Inter-Medium',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
