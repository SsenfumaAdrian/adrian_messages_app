import 'dart:async' show unawaited;
// FILE: lib/ui/screens/auth/components/glass_login_card.dart
//
// Demo mode: accepts any non-empty email + password (min 4 chars).
// Shows inline validation errors. On success navigates to onboarding.

import 'package:flutter/material.dart';

import '../../../../core/constants/palette.dart';
import '../../../../core/navigation/liquid_router.dart';
import '../../../../core/utils/nav_persistence.dart';
import '../../components/glass_text_field.dart';

class GlassLoginCard extends StatefulWidget {
  const GlassLoginCard({
    super.key,
    required this.maxWidth,
    this.maxHeight,
  });
  final double maxWidth;
  final double? maxHeight;

  @override
  State<GlassLoginCard> createState() => _GlassLoginCardState();
}

class _GlassLoginCardState extends State<GlassLoginCard> {
  final _emailCtrl    = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool   _showPassword = false;
  bool   _loading      = false;
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  // ── Demo validation ─────────────────────────────────────────
  bool _validate() {
    final email    = _emailCtrl.text.trim();
    final password = _passwordCtrl.text;
    String? emailErr;
    String? passErr;

    if (email.isEmpty) {
      emailErr = 'Please enter your email or phone';
    } else if (!email.contains('@') && !RegExp(r'^\+?\d{7,}$').hasMatch(email)) {
      // Accept anything with an @ OR a phone number — demo mode
      emailErr = 'Enter a valid email or phone number';
    }

    if (password.isEmpty) {
      passErr = 'Please enter your password';
    } else if (password.length < 4) {
      passErr = 'Password must be at least 4 characters';
    }

    setState(() {
      _emailError    = emailErr;
      _passwordError = passErr;
    });

    return emailErr == null && passErr == null;
  }

  Future<void> _login() async {
    if (!_validate()) return;

    setState(() => _loading = true);

    // Simulate a brief network call (demo mode — always succeeds)
    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;
    setState(() => _loading = false);

    // Navigate to onboarding (clears back stack so user can't go back to login)
    await NavPersistence.setLoggedIn(true);
    await NavPersistence.saveTab(0);
    if (!mounted) return;
    unawaited(LiquidRouter.clearAndGo(context, LiquidRouter.onboarding));
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth:  widget.maxWidth,
        maxHeight: widget.maxHeight ?? double.infinity,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          gradient: const LinearGradient(
            colors: [Color(0xCC0F2A55), Color(0xAA0B1F3C)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 26,
              offset: Offset(0, 18),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Headline ───────────────────────────────────────
            const Text(
              'Welcome Back',
              style: TextStyle(
                fontFamily: 'Inter-Bold',
                fontSize: 24,
                color: Palette.onSurface,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Please enter your credentials to access your portal.',
              style: TextStyle(
                fontFamily: 'Inter-Regular',
                fontSize: 13,
                color: Palette.onSurfaceVariant,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),

            // ── Email field ────────────────────────────────────
            GlassTextField(
              label: 'Email or Phone',
              hint: 'name@adrian.ai',
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.mail_outline,
              controller: _emailCtrl,
              onChanged: (_) {
                if (_emailError != null) setState(() => _emailError = null);
              },
            ),
            if (_emailError != null) _ErrorText(_emailError!),
            const SizedBox(height: 14),

            // ── Password field ─────────────────────────────────
            GlassTextField(
              label: 'Password',
              hint: '••••••••',
              obscure: !_showPassword,
              prefixIcon: Icons.lock_outline,
              suffixIcon: _showPassword ? Icons.visibility : Icons.visibility_off,
              controller: _passwordCtrl,
              onSuffixTap: () =>
                  setState(() => _showPassword = !_showPassword),
              onChanged: (_) {
                if (_passwordError != null) setState(() => _passwordError = null);
              },
            ),
            if (_passwordError != null) _ErrorText(_passwordError!),

            const SizedBox(height: 14),

            // ── Forgot password ────────────────────────────────
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => _showForgotDialog(context),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Palette.accentCyan,
                    fontFamily: 'Inter-Medium',
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // ── Login button ───────────────────────────────────
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0F6FFF), Palette.accentCyan],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: _loading ? null : _login,
                    child: _loading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_forward, size: 18),
                              SizedBox(width: 8),
                              Text(
                                'Login',
                                style: TextStyle(
                                  fontFamily: 'Inter-Bold',
                                  fontSize: 15,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // ── Sign up link ───────────────────────────────────
            Center(
              child: GestureDetector(
                onTap: () => LiquidRouter.clearAndGo(context, LiquidRouter.onboarding),
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontFamily: 'Inter-Medium',
                      fontSize: 12,
                      color: Palette.onSurfaceVariant,
                    ),
                    children: [
                      TextSpan(text: "Don't have an account? "),
                      TextSpan(
                        text: 'Create an Account',
                        style: TextStyle(
                          color: Palette.accentCyan,
                          fontFamily: 'Inter-Bold',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showForgotDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF0B1F3C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Demo Mode',
            style: TextStyle(color: Colors.white, fontFamily: 'Inter-Bold')),
        content: const Text(
          'In demo mode any email and password (min 4 chars) will work.\n\n'
          'Just type anything and tap Login.',
          style: TextStyle(color: Palette.onSurfaceVariant, fontSize: 13, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it',
                style: TextStyle(color: Palette.accentCyan, fontFamily: 'Inter-Bold')),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// INLINE ERROR TEXT
// ─────────────────────────────────────────────────────────────
class _ErrorText extends StatelessWidget {
  const _ErrorText(this.message);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, left: 4),
      child: Row(children: [
        const Icon(Icons.error_outline_rounded, color: Color(0xFFFF6B6B), size: 13),
        const SizedBox(width: 5),
        Text(
          message,
          style: const TextStyle(
            color: Color(0xFFFF6B6B),
            fontSize: 11,
            fontFamily: 'Inter-Medium',
          ),
        ),
      ]),
    );
  }
}
