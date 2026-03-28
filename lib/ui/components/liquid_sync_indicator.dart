// FILE: lib/ui/components/liquid_sync_indicator.dart

import 'package:flutter/material.dart';
import 'dart:math' as math;

class LiquidSyncIndicator extends StatefulWidget {
  final double progress;
  const LiquidSyncIndicator({Key? key, required this.progress})
      : super(key: key);

  @override
  _LiquidSyncIndicatorState createState() => _LiquidSyncIndicatorState();
}

class _LiquidSyncIndicatorState extends State<LiquidSyncIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        RotationTransition(
          turns: _rotationController,
          child: CircularProgressIndicator(
            value: widget.progress,
            strokeWidth: 2,
            color: Colors.blueAccent.withOpacity(0.5),
          ),
        ),
        Text(
          "${(widget.progress * 100).toInt()}%",
          style: const TextStyle(
              fontFamily: 'Inter-Medium', fontSize: 10, color: Colors.white38),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }
}
