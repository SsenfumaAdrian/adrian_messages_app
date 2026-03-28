import 'package:flutter/material.dart';
import '../../../core/constants/palette.dart';

class GlassTextField extends StatelessWidget {
  const GlassTextField({
    super.key,
    required this.hint,
    this.obscure = false,
    this.icon,
  });

  final String hint;
  final bool obscure;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      child: Row(
        children: [
          if (icon != null)
            Icon(icon, color: Palette.accentCyan.withOpacity(0.8), size: 18),
          if (icon != null) const SizedBox(width: 10),
          Expanded(
            child: TextField(
              obscureText: obscure,
              style: const TextStyle(
                color: Palette.textPrimary,
                fontFamily: 'Inter-Medium',
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(
                  color: Palette.textMuted,
                  fontFamily: 'Inter-Regular',
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
