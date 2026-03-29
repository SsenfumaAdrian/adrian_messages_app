// FILE: lib/ui/screens/auth/layouts/mobile_layout.dart
//
// Mobile layout (< 600 px wide).
// Always scrollable — handles both short phones (SE, mini)
// and tall ones — and adjusts spacing using isCompact flag.

import 'package:flutter/material.dart';

import '../../../../core/constants/palette.dart';
import '../../../components/logo_card.dart';
import '../components/footer_stats.dart';
import '../components/glass_login_card.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final insets = MediaQuery.viewInsetsOf(context);

    // Compact = short device (iPhone SE, Pixel 4a, etc.)
    final bool isCompact = size.height < 700;

    return SafeArea(
      child: SingleChildScrollView(
        // AlwaysScrollable so dragging works even when content fits
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        // Extra bottom padding when keyboard is open
        padding: EdgeInsets.fromLTRB(
          20,
          isCompact ? 12 : 24,
          20,
          16 + insets.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ── Logo card ──────────────────────────────────
            // Same LogoCard as the splash screen, just smaller
            LogoCard(size: isCompact ? 56 : 68),

            SizedBox(height: isCompact ? 10 : 16),

            // ── Tagline ────────────────────────────────────
            _MobileTagline(isCompact: isCompact),

            SizedBox(height: isCompact ? 6 : 10),

            // ── Subtitle ───────────────────────────────────
            if (!isCompact) ...[
              const Text(
                'Secure, private, and exceptionally capable.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0x99FFFFFF),
                  fontSize: 12.5,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 10),
            ],

            // ── Full-width login card ──────────────────────
            const GlassLoginCard(maxWidth: double.infinity),

            SizedBox(height: isCompact ? 14 : 20),

            // ── Footer stats ───────────────────────────────
            const FooterStats(center: true),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// MOBILE TAGLINE
// ─────────────────────────────────────────────────────────────
class _MobileTagline extends StatelessWidget {
  const _MobileTagline({required this.isCompact});
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontFamily: 'Inter-Bold',
          fontSize: isCompact ? 22 : 26,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          height: 1.1,
          letterSpacing: -0.5,
        ),
        children: const [
          TextSpan(text: 'Sophisticated intelligence, '),
          TextSpan(
            text: 'uniquely yours.',
            style: TextStyle(color: Palette.accentCyan),
          ),
        ],
      ),
    );
  }
}
