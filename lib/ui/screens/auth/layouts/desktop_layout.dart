import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:adrian_messages/ui/screens/auth/components/branding_column.dart';
import 'package:adrian_messages/ui/screens/auth/components/footer_stats.dart';
import 'package:adrian_messages/ui/screens/auth/components/glass_login_card.dart';


class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key, required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Left branding column
        Positioned(
          left: 72,
          top: 0,
          bottom: 0,
          width: size.width * 0.44,
          child: const BrandingColumn(
            headlineFontSize: 52,
            subFontSize: 17,
            logoSize: 112,
          ),
        ),

        // Right glass card
        Align(
          alignment: const Alignment(0.88, 0.0),
          child: GlassLoginCard(
            maxWidth: math.min(460, size.width * 0.38),
            maxHeight: 560,
          ),
        ),

        const Positioned(
          bottom: 52,
          left: 72,
          child: FooterStats(),
        ),
      ],
    );
  }
}
