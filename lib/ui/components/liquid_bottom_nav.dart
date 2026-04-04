// FILE: lib/ui/components/liquid_bottom_nav.dart

import 'package:flutter/material.dart';
import 'dart:ui';

class LiquidBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const LiquidBottomNav(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: EdgeInsets.all(20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(35),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(Icons.chat_bubble_outline, 0),
                _buildNavItem(Icons.auto_awesome_motion, 1),
                _buildNavItem(Icons.person_outline, 2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final bool isActive = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Icon(
        icon,
        color: isActive ? Colors.blueAccent : Colors.white38,
        size: isActive ? 30 : 26,
      ),
    );
  }
}
