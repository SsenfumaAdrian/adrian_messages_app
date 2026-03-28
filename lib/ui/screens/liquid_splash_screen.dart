// FILE: lib/ui/screens/liquid_splash_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import '../components/liquid_glass_container.dart';
import 'onboarding_wizard.dart'; // Redirecting here instead of Dashboard

class LiquidSplashScreen extends StatefulWidget {
  @override
  _LiquidSplashScreenState createState() => _LiquidSplashScreenState();
}

class _LiquidSplashScreenState extends State<LiquidSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // 2-second fluid entrance animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _controller.forward();

    // STITCH LOGIC: After 3.5s, move to the Onboarding Bento Grid
    Timer(const Duration(milliseconds: 3500), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => OnboardingWizard()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Background: The original dark Liquid Mesh Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [Color(0xFF2E325A), Color(0xFF0A0A0E)],
                radius: 1.2,
                center: Alignment.center,
              ),
            ),
          ),

          // The Centerpiece: Floating Liquid Glass Logo
          FadeTransition(
            opacity: _opacityAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: LiquidGlassContainer(
                borderRadius: 40,
                padding: const EdgeInsets.all(40),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.auto_awesome, size: 80, color: Colors.white),
                    SizedBox(height: 20),
                    Text(
                      "ADRIAN",
                      style: TextStyle(
                        fontFamily: 'Inter-Bold',
                        fontSize: 24,
                        letterSpacing: 8.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "MESSAGES",
                      style: TextStyle(
                        fontFamily: 'Inter-Regular',
                        fontSize: 12,
                        letterSpacing: 4.0,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
