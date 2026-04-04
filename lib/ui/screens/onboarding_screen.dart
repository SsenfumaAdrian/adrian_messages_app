// FILE: lib/ui/screens/onboarding_screen.dart
//
// Matches: stitch/adrian_messages_onboarding/screen.png
// Design: 3-step carousel, light surface #fbf8ff, primary #1A237E
// Navigation: → ConversationsListScreen on complete

import 'package:flutter/material.dart';

import '../../core/constants/palette.dart';
import '../../core/navigation/liquid_router.dart';
import '../components/liquid_glass.dart';
import '../components/logo_card.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final PageController _pageCtrl = PageController();
  int _currentPage = 0;

  late final List<AnimationController> _fadeCtls;
  late final List<Animation<double>> _fadeAnims;

  static const _pages = [
    _OnboardingPage(
      icon: Icons.auto_awesome_rounded,
      tagline: 'Your intelligent\ncorrespondent.',
      body:
          'Adrian Messages goes beyond chat. It reads context, surfaces insights, '
          'and helps you communicate with intention — like having a personal concierge in your pocket.',
      accentLabel: 'AI-Powered',
    ),
    _OnboardingPage(
      icon: Icons.lock_outline_rounded,
      tagline: 'Absolute privacy,\nby design.',
      body:
          'Zero-knowledge architecture means only you can read your messages. '
          'End-to-end encryption, biometric vaults, and no advertising. Ever.',
      accentLabel: '256-bit Encrypted',
    ),
    _OnboardingPage(
      icon: Icons.groups_2_outlined,
      tagline: 'Circles, not\njust groups.',
      body:
          'Organise your world into Circles — with custom roles, permissions, '
          'shared vaults, and AI-moderated spaces. Built for people who mean business.',
      accentLabel: 'Team-Ready',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fadeCtls = List.generate(
      _pages.length,
      (_) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500),
      ),
    );
    _fadeAnims = _fadeCtls
        .map((c) => CurvedAnimation(parent: c, curve: Curves.easeOut))
        .toList();

    // Animate first page in
    _fadeCtls[0].forward();
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    for (final c in _fadeCtls) {
      c.dispose();
    }
    super.dispose();
  }

  void _goTo(int page) {
    _fadeCtls[_currentPage].reverse();
    _pageCtrl.animateToPage(
      page,
      duration: Duration(milliseconds: 420),
      curve: Curves.easeInOutCubic,
    );
    Future.delayed(Duration(milliseconds: 200), () {
      if (mounted) _fadeCtls[page].forward();
    });
    setState(() => _currentPage = page);
  }

  void _next() {
    if (_currentPage < _pages.length - 1) {
      _goTo(_currentPage + 1);
    } else {
      LiquidRouter.clearAndGo(context, LiquidRouter.shell);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isLast = _currentPage == _pages.length - 1;

    return Scaffold(
      backgroundColor: Palette.surface,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top nav ──────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  // Logo mark
                  const LogoCard(size: 40, rounded: true),
                  const SizedBox(width: 10),
                  const Text(
                    'Adrian Messages',
                    style: TextStyle(
                      fontFamily: Palette.fontDisplay,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Palette.primary,
                    ),
                  ),
                  const Spacer(),
                  LiquidGlassChip(
                    label: 'Skip',
                    icon: Icons.arrow_forward_rounded,
                    tint: Palette.onSurfaceVariant,
                    onTap: () => LiquidRouter.clearAndGo(context, LiquidRouter.shell),
                  ),
                ],
              ),
            ),

            // ── Page carousel ─────────────────────────────────
            Expanded(
              child: PageView.builder(
                controller: _pageCtrl,
                itemCount: _pages.length,
                onPageChanged: (i) {
                  _fadeCtls[_currentPage].reverse();
                  Future.delayed(Duration(milliseconds: 180), () {
                    if (mounted) _fadeCtls[i].forward();
                  });
                  setState(() => _currentPage = i);
                },
                itemBuilder: (_, i) => FadeTransition(
                  opacity: _fadeAnims[i],
                  child: _PageContent(page: _pages[i], size: size),
                ),
              ),
            ),

            // ── Dots + CTA ────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(24, 0, 24, 32),
              child: Column(
                children: [
                  // Page dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_pages.length, (i) {
                      final active = i == _currentPage;
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        width: active ? 28 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color:
                              active ? Palette.primary : Palette.outlineVariant,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 28),

                  // Primary CTA button
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Palette.primary, Color(0xFF2C3E9E)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Palette.primary.withValues(alpha: 0.28),
                            blurRadius: 24,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: _next,
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isLast ? "Let's Go" : 'Continue',
                              style: const TextStyle(
                                fontFamily: Palette.fontDisplay,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward_rounded, size: 18),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// PAGE CONTENT
// ─────────────────────────────────────────────────────────────
class _PageContent extends StatelessWidget {
  const _PageContent({required this.page, required this.size});
  final _OnboardingPage page;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Illustrated card ──────────────────────────────
          Center(
            child: Container(
              width: size.width * 0.72,
              height: size.width * 0.68,
              decoration: BoxDecoration(
                color: Palette.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(36),
                boxShadow: [
                  BoxShadow(
                    color: Palette.primary.withValues(alpha: 0.06),
                    blurRadius: 32,
                    offset: Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon in brand circle
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Palette.primary, Color(0xFF3949AB)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Palette.primary.withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Icon(page.icon, color: Colors.white, size: 40),
                  ),
                  const SizedBox(height: 28),
                  // Accent chip
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: Palette.accentCyan.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Palette.accentCyan,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          page.accentLabel,
                          style: const TextStyle(
                            color: Palette.primary,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 40),

          // ── Headline ─────────────────────────────────────
          Text(
            page.tagline,
            style: const TextStyle(
              fontFamily: Palette.fontDisplay,
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: Palette.onSurface,
              height: 1.1,
              letterSpacing: -0.8,
            ),
          ),

          const SizedBox(height: 16),

          // ── Body ─────────────────────────────────────────
          Text(
            page.body,
            style: const TextStyle(
              fontSize: 15,
              color: Palette.onSurfaceVariant,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// DATA MODEL
// ─────────────────────────────────────────────────────────────
class _OnboardingPage {
  const _OnboardingPage({
    required this.icon,
    required this.tagline,
    required this.body,
    required this.accentLabel,
  });

  final IconData icon;
  final String tagline;
  final String body;
  final String accentLabel;
}
