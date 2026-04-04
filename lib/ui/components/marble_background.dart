import 'dart:math' as math;
import 'package:flutter/material.dart';

class MarbleBackground extends StatelessWidget {
  const MarbleBackground({super.key, required this.controller});
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) => CustomPaint(
        painter: _MarblePainter(progress: controller.value),
      ),
    );
  }
}

class _MarblePainter extends CustomPainter {
  _MarblePainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final t = progress * math.pi * 2;
    final center = size.center(Offset.zero);

    // Base swirling radial gradient
    final baseShader = RadialGradient(
      center: Alignment(math.cos(t * 0.4) * 0.25, math.sin(t * 0.4) * 0.25),
      radius: 1.1,
      colors: [
        Color(0xFF060D1F),
        Color(0xFF0E1733),
        Color(0xFF12315F),
        Color(0xFF0B7AC7),
      ],
      stops: const [0.0, 0.45, 0.72, 1.0],
      transform: GradientRotation(t * 0.12),
    ).createShader(Rect.fromCircle(center: center, radius: size.shortestSide));

    canvas.drawRect(Offset.zero & size, Paint()..shader = baseShader);

    // Soft streaks moving across the frame
    final streakShader = LinearGradient(
      begin: Alignment(-1.0 + 0.3 * math.sin(t * 0.6), -1),
      end: const Alignment(1, 1),
      colors: [
        Colors.white.withValues(alpha: 0.05),
        Colors.transparent,
        Colors.white.withValues(alpha: 0.03),
      ],
      stops: const [0, 0.55, 1],
      transform: GradientRotation(t * 0.18),
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..blendMode = BlendMode.screen
        ..shader = streakShader,
    );

    // Noise speckles for texture
    final noisePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.015)
      ..style = PaintingStyle.fill;
    final rand = math.Random(42);
    const speckles = 240;
    for (var i = 0; i < speckles; i++) {
      final dx = rand.nextDouble() * size.width;
      final dy = rand.nextDouble() * size.height;
      final r = rand.nextDouble() * 0.7 + 0.3;
      canvas.drawCircle(Offset(dx, dy), r, noisePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _MarblePainter oldDelegate) =>
      oldDelegate.progress != progress;
}
