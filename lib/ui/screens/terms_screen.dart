// FILE: lib/ui/screens/terms_screen.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../components/liquid_glass.dart';
import '../../core/navigation/liquid_router.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: AppBar(
              title: const Text('Terms & Conditions'),
              backgroundColor: Colors.white.withValues(alpha: 0.72),
              elevation: 0,
              scrolledUnderElevation: 0,
              foregroundColor: Palette.onSurface,
              leading: LiquidGlassBackButton(size: 38),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  'By using Adrian Messages, you agree to our encrypted data '
                  'protocols. Your privacy is absolute. All messages are '
                  'end-to-end encrypted using 256-bit AES. Zero-knowledge '
                  'architecture ensures only you can read your data. We never '
                  'sell, share, or monetise your conversations. Your digital '
                  'estate remains entirely yours.',
                  style: TextStyle(
                    fontFamily: Palette.fontBody,
                    fontSize: 15,
                    height: 1.7,
                    color: Palette.onSurface,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 58,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Palette.primary, Color(0xFF2C3E9E)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Palette.primary.withValues(alpha: 0.28),
                      blurRadius: 20,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: TextButton(
                  onPressed: () => LiquidRouter.clearAndGo(
                    context, LiquidRouter.conversations,
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'I Agree & Enter',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
