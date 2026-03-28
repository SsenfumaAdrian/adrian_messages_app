import 'package:flutter/material.dart';
import 'package:adrian_messages/ui/screens/auth/components/branding_column.dart';
import 'package:adrian_messages/ui/screens/auth/components/footer_stats.dart';
import 'package:adrian_messages/ui/screens/auth/components/glass_login_card.dart';

class TabletLayout extends StatelessWidget {
  const TabletLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            // Centered Branding
            BrandingColumn(
              headlineFontSize: 42,
              subFontSize: 16,
              logoSize: 96,
              centerAlign: true,
            ),

            SizedBox(height: 48),

            // Fixed-width Glass Card so it doesn't stretch too wide
            GlassLoginCard(maxWidth: 500),

            SizedBox(height: 48),

            // Centered Footer
            FooterStats(center: true),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
