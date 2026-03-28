import 'package:adrian_messages/core/constants/palette.dart';
import 'package:flutter/material.dart';
import '../../components/logo_card.dart';

class BrandingColumn extends StatelessWidget {
  const BrandingColumn({
    super.key,
    required this.headlineFontSize,
    required this.subFontSize,
    required this.logoSize,
    this.centerAlign = false,
  });

  final double headlineFontSize;
  final double subFontSize;
  final double logoSize;
  final bool centerAlign;

  @override
  Widget build(BuildContext context) {
    final alignment = centerAlign ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = centerAlign ? TextAlign.center : TextAlign.left;

    return Column(
      crossAxisAlignment: alignment,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LogoCard(size: logoSize),
        const SizedBox(height: 28),
        RichText(
          textAlign: textAlign,
          text: TextSpan(
            children: [
              TextSpan(
                text: "Sophisticated intelligence, ",
                style: TextStyle(
                  fontFamily: 'Inter-Bold',
                  fontSize: headlineFontSize,
                  color: Palette.textPrimary,
                  letterSpacing: -1,
                  height: 1.05,
                ),
              ),
              TextSpan(
                text: "uniquely yours.",
                style: TextStyle(
                  fontFamily: 'Inter-Bold',
                  fontSize: headlineFontSize,
                  color: Palette.accentCyan,
                  letterSpacing: -1,
                  height: 1.05,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Text(
          "Access your personal digital estate. Secure, private, and exceptionally capable.",
          textAlign: textAlign,
          style: TextStyle(
            fontFamily: 'Inter-Regular',
            fontSize: subFontSize,
            color: Palette.textMuted,
            height: 1.3,
          ),
        ),
      ],
    );
  }
}
