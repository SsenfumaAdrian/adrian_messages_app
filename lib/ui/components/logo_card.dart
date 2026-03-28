import 'dart:ui';
import 'package:flutter/material.dart';

class LogoCard extends StatelessWidget {
  const LogoCard({super.key, this.size = 112});
  final double size;

  @override
  Widget build(BuildContext context) {
    final radius = size * 0.23;
    final iconSize = size * 0.32;

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: const Color.fromARGB(45, 255, 255, 255),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
                color: const Color.fromARGB(40, 255, 255, 255), width: 1.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.auto_awesome, color: Colors.white, size: iconSize),
              SizedBox(height: size * 0.07),
              Text(
                'ADRIAN',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size * 0.10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              ),
              Text(
                'MESSAGES',
                style: TextStyle(
                  color: const Color(0x66FFFFFF),
                  fontSize: size * 0.058,
                  letterSpacing: 2.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
