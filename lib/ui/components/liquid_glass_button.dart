// FILE: lib/ui/components/liquid_glass_button.dart

import 'package:flutter/material.dart';
import 'liquid_glass_container.dart';

class LiquidGlassButton extends StatefulWidget {
  final VoidCallback onTap;
  final Widget child;
  final Color? tint;

  const LiquidGlassButton({
    super.key,
    required this.onTap,
    required this.child,
    this.tint,
  });

  @override
  State<LiquidGlassButton> createState() => _LiquidGlassButtonState();
}

class _LiquidGlassButtonState extends State<LiquidGlassButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scale,
        child: LiquidGlassContainer(
          borderRadius: 18,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: DefaultTextStyle(
            style: const TextStyle(
              fontFamily: 'Inter-SemiBold', //
              color: Colors.white,
              fontSize: 16,
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
