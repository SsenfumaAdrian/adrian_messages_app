// FILE: lib/ui/components/liquid_reaction_engine.dart

import 'package:flutter/material.dart';

class LiquidReactionEngine extends StatefulWidget {
  final Widget child;
  const LiquidReactionEngine({super.key, required this.child});

  @override
  State<LiquidReactionEngine> createState() => _LiquidReactionEngineState();
}

class _LiquidReactionEngineState extends State<LiquidReactionEngine>
    with SingleTickerProviderStateMixin {
  late AnimationController _rippleController;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _rippleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
  }

  void _triggerReaction() {
    setState(() => _isLiked = !_isLiked);
    _rippleController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _triggerReaction,
      child: Stack(
        alignment: Alignment.center,
        children: [
          widget.child,
          // The Liquid Ripple Effect
          AnimatedBuilder(
            animation: _rippleController,
            builder: (context, child) {
              return Opacity(
                opacity: 1.0 - _rippleController.value,
                child: Container(
                  width: _rippleController.value * 150,
                  height: _rippleController.value * 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.blueAccent.withValues(alpha: 0.5),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          if (_isLiked)
            const Positioned(
              right: 10,
              bottom: 10,
              child: Icon(Icons.favorite, color: Colors.redAccent, size: 18),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _rippleController.dispose();
    super.dispose();
  }
}
