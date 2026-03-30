// FILE: lib/ui/screens/liquid_splash_screen.dart
//
// Entry point defined in main.dart → LiquidSplashScreen().
// Shows an animated logo on the marble background, then navigates to AuthScreen.


import 'package:flutter/material.dart';

import '../../core/constants/palette.dart';
import '../components/logo_card.dart';
import '../components/marble_background.dart';
import 'auth_screen.dart';

class LiquidSplashScreen extends StatefulWidget {
  const LiquidSplashScreen({super.key});

  @override
  State<LiquidSplashScreen> createState() => _LiquidSplashScreenState();
}

class _LiquidSplashScreenState extends State<LiquidSplashScreen>
    with TickerProviderStateMixin {
  // Marble background controller (slow continuous loop)
  late final AnimationController _marbleCtrl;

  // Logo entrance: fade + scale up
  late final AnimationController _entranceCtrl;
  late final Animation<double> _fadeAnim;
  late final Animation<double> _scaleAnim;

  // Tagline fade-in (delayed after logo)
  late final AnimationController _taglineCtrl;
  late final Animation<double> _taglineFade;

  // Pulse glow on the logo card
  late final AnimationController _pulseCtrl;
  late final Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();

    // ── Marble background ────────────────────────────────
    _marbleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    // ── Logo entrance (0 → 600 ms) ───────────────────────
    _entranceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnim = CurvedAnimation(
      parent: _entranceCtrl,
      curve: Curves.easeOut,
    );
    _scaleAnim = Tween<double>(begin: 0.72, end: 1.0).animate(
      CurvedAnimation(parent: _entranceCtrl, curve: Curves.easeOutBack),
    );

    // ── Tagline fade (starts 400 ms after logo) ──────────
    _taglineCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _taglineFade = CurvedAnimation(
      parent: _taglineCtrl,
      curve: Curves.easeOut,
    );

    // ── Pulse glow (continuous slow breathe) ─────────────
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );

    // ── Sequence ─────────────────────────────────────────
    _runSequence();
  }

  Future<void> _runSequence() async {
    // Brief pause so marble renders first
    await Future.delayed(const Duration(milliseconds: 200));
    _entranceCtrl.forward();

    await Future.delayed(const Duration(milliseconds: 400));
    _taglineCtrl.forward();

    // Wait, then navigate
    await Future.delayed(const Duration(milliseconds: 2400));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const AuthScreen(),
          transitionDuration: const Duration(milliseconds: 600),
          transitionsBuilder: (_, anim, __, child) => FadeTransition(
            opacity: anim,
            child: child,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _marbleCtrl.dispose();
    _entranceCtrl.dispose();
    _taglineCtrl.dispose();
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── 1. Animated marble ─────────────────────────
          MarbleBackground(controller: _marbleCtrl),
          const ColoredBox(color: Color.fromARGB(20, 4, 12, 40)),

          // ── 2. Centred logo + tagline ──────────────────
          Center(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: ScaleTransition(
                scale: _scaleAnim,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ── Glowing logo card ──────────────────
                    AnimatedBuilder(
                      animation: _pulseAnim,
                      builder: (_, child) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(36),
                          boxShadow: [
                            BoxShadow(
                              color: Palette.accentBlue
                                  .withOpacity(0.35 * _pulseAnim.value),
                              blurRadius: 48 * _pulseAnim.value,
                              spreadRadius: 4,
                            ),
                            BoxShadow(
                              color: Palette.accentCyan
                                  .withOpacity(0.18 * _pulseAnim.value),
                              blurRadius: 80 * _pulseAnim.value,
                              spreadRadius: 8,
                            ),
                          ],
                        ),
                        child: child,
                      ),
                      child: const LogoCard(size: 148, rounded: true),
                    ),

                    const SizedBox(height: 32),

                    // ── App name ───────────────────────────
                    FadeTransition(
                      opacity: _taglineFade,
                      child: const Text(
                        'ADRIAN MESSAGES',
                        style: TextStyle(
                          fontFamily: 'Inter-Bold',
                          fontSize: 13,
                          color: Color(0x99FFFFFF),
                          letterSpacing: 4.5,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // ── Tagline ────────────────────────────
                    FadeTransition(
                      opacity: _taglineFade,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          style: TextStyle(
                            fontFamily: 'Inter-Bold',
                            fontSize: 22,
                            color: Colors.white,
                            height: 1.2,
                          ),
                          children: [
                            TextSpan(text: 'Sophisticated intelligence,\n'),
                            TextSpan(
                              text: 'uniquely yours.',
                              style: TextStyle(color: Palette.accentCyan),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── 3. Loading dots at bottom ──────────────────
          Positioned(
            bottom: 56,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _taglineFade,
              child: const _LoadingDots(),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// LOADING DOTS  – three pulsing dots
// ─────────────────────────────────────────────────────────────
class _LoadingDots extends StatefulWidget {
  const _LoadingDots();

  @override
  State<_LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<_LoadingDots>
    with TickerProviderStateMixin {
  late final List<AnimationController> _ctrls;
  late final List<Animation<double>> _anims;

  @override
  void initState() {
    super.initState();
    _ctrls = List.generate(
      3,
      (i) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
      ),
    );
    _anims = _ctrls
        .map(
          (c) => Tween<double>(begin: 0.3, end: 1.0).animate(
            CurvedAnimation(parent: c, curve: Curves.easeInOut),
          ),
        )
        .toList();

    // Stagger each dot
    for (var i = 0; i < 3; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        if (mounted) _ctrls[i].repeat(reverse: true);
      });
    }
  }

  @override
  void dispose() {
    for (final c in _ctrls) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (i) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: AnimatedBuilder(
            animation: _anims[i],
            builder: (_, __) => Opacity(
              opacity: _anims[i].value,
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Palette.accentCyan,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
