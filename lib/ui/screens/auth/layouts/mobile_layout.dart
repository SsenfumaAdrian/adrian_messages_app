import 'package:flutter/material.dart';
import 'package:adrian_messages/core/constants/palette.dart';
import 'package:adrian_messages/ui/screens/auth/components/footer_stats.dart';
import 'package:adrian_messages/ui/screens/auth/components/glass_login_card.dart';
import 'package:adrian_messages/ui/screens/components/logo_card.dart';


class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const LogoCard(size: 80),
            const SizedBox(height: 20),
            _MobileTagline(),
            const SizedBox(height: 28),
            const GlassLoginCard(maxWidth: double.infinity),
            const SizedBox(height: 32),
            const FooterStats(center: true),
          ],
        ),
      ),
    );
  }
}

class _MobileTagline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            height: 1.15),
        children: [
          TextSpan(text: 'Sophisticated\nintelligence, '),
          TextSpan(
              text: 'uniquely\nyours.',
              style: TextStyle(color: Palette.accentCyan)),
        ],
      ),
    );
  }
}
