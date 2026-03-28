import 'package:adrian_messages/core/constants/palette.dart';
import 'package:flutter/material.dart';
import '../../components/glass_text_field.dart';

class GlassLoginCard extends StatelessWidget {
  const GlassLoginCard({super.key, required this.maxWidth});
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white.withOpacity(0.06),
          border: Border.all(color: Colors.white.withOpacity(0.12)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 20,
              offset: Offset(0, 12),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Sign in",
              style: TextStyle(
                fontFamily: 'Inter-Bold',
                fontSize: 24,
                color: Palette.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            const GlassTextField(
              hint: "Email",
              icon: Icons.mail_outline,
            ),
            const SizedBox(height: 12),
            const GlassTextField(
              hint: "Password",
              icon: Icons.lock_outline,
              obscure: true,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Palette.accentCyan,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Continue",
                      style: TextStyle(
                        fontFamily: 'Inter-Bold',
                        fontSize: 15,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {},
              child: const Text(
                "Create account",
                style: TextStyle(
                  color: Palette.textMuted,
                  fontFamily: 'Inter-Medium',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
