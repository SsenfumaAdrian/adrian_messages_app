// FILE: lib/ui/components/liquid_sticker_engine.dart

import 'dart:ui';
import 'package:flutter/material.dart';

class LiquidSticker extends StatelessWidget {
  final String stickerId;
  const LiquidSticker({Key? key, required this.stickerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 140,
      child: Stack(
        children: [
          // The Refraction Layer: Blurs what is directly behind the sticker
          Center(
            child: ClipOval(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(color: Colors.white.withOpacity(0.02)),
              ),
            ),
          ),
          // The 3D Glass Asset Placeholder
          Center(
            child: Icon(
              _getStickerIcon(stickerId),
              size: 80,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          // Specular Highlight Overlay
          IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  center: const Alignment(-0.3, -0.3),
                  radius: 0.8,
                  colors: [
                    Colors.white.withOpacity(0.2),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getStickerIcon(String id) {
    switch (id) {
      case 'smile':
        return Icons.sentiment_very_satisfied_outlined;
      case 'heart':
        return Icons.favorite_border_rounded;
      default:
        return Icons.auto_awesome_outlined;
    }
  }
}
