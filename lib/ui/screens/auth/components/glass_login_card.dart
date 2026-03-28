import 'package:adrian_messages/core/constants/palette.dart';
import 'package:flutter/material.dart';
import '../../components/glass_text_field.dart';

class GlassLoginCard extends StatefulWidget {
  const GlassLoginCard({super.key, required this.maxWidth});
  final double maxWidth;

  @override
  State<GlassLoginCard> createState() => _GlassLoginCardState();
}

class _GlassLoginCardState extends State<GlassLoginCard> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: widget.maxWidth),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 26),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: const LinearGradient(
            colors: [Color(0xCC0F2A55), Color(0xAA0B1F3C)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: Colors.white.withOpacity(0.14)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 26,
              offset: Offset(0, 18),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome Back",
              style: TextStyle(
                fontFamily: 'Inter-Bold',
                fontSize: 24,
                color: Palette.textPrimary,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Please enter your credentials to access your portal.",
              style: TextStyle(
                fontFamily: 'Inter-Regular',
                fontSize: 13,
                color: Palette.textMuted,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 22),
            const GlassTextField(
              label: "Email or Phone",
              hint: "name@adrian.ai",
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.mail_outline,
            ),
            const SizedBox(height: 14),
            GlassTextField(
              label: "Password",
              hint: "••••••••",
              obscure: !_showPassword,
              prefixIcon: Icons.lock_outline,
              suffixIcon: _showPassword ? Icons.visibility : Icons.visibility_off,
              onSuffixTap: () =>
                  setState(() => _showPassword = !_showPassword),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Palette.textMuted,
                    fontFamily: 'Inter-Medium',
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Palette.accentBlue, Palette.accentCyan],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text(
                      "Login",
                      style: TextStyle(
                        fontFamily: 'Inter-Bold',
                        fontSize: 15,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Center(
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontFamily: 'Inter-Medium',
                    fontSize: 12,
                    color: Palette.textMuted,
                  ),
                  children: [
                    TextSpan(text: "Don't have an account? "),
                    TextSpan(
                      text: "Create an Account",
                      style: TextStyle(
                        color: Palette.accentCyan,
                        fontFamily: 'Inter-Bold',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
