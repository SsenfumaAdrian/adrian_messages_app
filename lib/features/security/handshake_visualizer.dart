// FILE: lib/features/security/handshake_visualizer.dart

import 'package:flutter/material.dart';

class HandshakeVisualizer extends StatefulWidget {
  const HandshakeVisualizer({super.key});

  @override
  @override
  State<HandshakeVisualizer> createState() => _HandshakeVisualizerState();
}

class _HandshakeVisualizerState extends State<HandshakeVisualizer>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 1.0, end: 1.1).animate(_pulseController),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.greenAccent.withValues(alpha: 0.1),
        ),
        child: const Icon(Icons.enhanced_encryption_rounded,
            color: Colors.greenAccent, size: 16),
      ),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }
}
