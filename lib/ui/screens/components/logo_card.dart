import 'package:flutter/material.dart';
import '../../../core/constants/palette.dart';

class LogoCard extends StatelessWidget {
  const LogoCard({super.key, this.size = 96});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Palette.accentCyan, Palette.accentBlue],
        ),
        boxShadow: [
          BoxShadow(
            color: Palette.accentCyan.withOpacity(0.35),
            blurRadius: 22,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Text(
          "A",
          style: TextStyle(
            fontFamily: 'Inter-Bold',
            fontSize: size * 0.42,
            color: Colors.black,
            letterSpacing: -1,
          ),
        ),
      ),
    );
  }
}
