// FILE: lib/ui/components/liquid_translation_bubble.dart

import 'package:flutter/material.dart';
import 'liquid_glass_container.dart';

class LiquidTranslationBubble extends StatelessWidget {
  final String originalText;
  final String translatedText;

  const LiquidTranslationBubble({
    Key? key,
    required this.originalText,
    required this.translatedText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(originalText, style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 8),
        LiquidGlassContainer(
          borderRadius: 15,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          // Subtly different tint for translated glass
          child: Text(
            translatedText,
            style: const TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: Colors.blueAccent,
            ),
          ),
        ),
      ],
    );
  }
}
