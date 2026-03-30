// FILE: lib/ui/components/liquid_status_indicator.dart

import 'package:flutter/material.dart';

class LiquidStatusIndicator extends StatefulWidget {
  final bool isOnline;
  const LiquidStatusIndicator({super.key, required this.isOnline});

  @override
  _LiquidStatusIndicatorState createState() => _LiquidStatusIndicatorState();
}

class _LiquidStatusIndicatorState extends State<LiquidStatusIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.isOnline ? Colors.greenAccent : Colors.white24,
        boxShadow: [
          if (widget.isOnline)
            BoxShadow(
              color:
                  Colors.greenAccent.withOpacity(0.5 * _pulseController.value),
              blurRadius: 10 * _pulseController.value,
              spreadRadius: 2,
            )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }
}
