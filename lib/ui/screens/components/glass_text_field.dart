import 'package:flutter/material.dart';
import '../../../core/constants/palette.dart';

class GlassTextField extends StatelessWidget {
  const GlassTextField({
    super.key,
    required this.label,
    required this.hint,
    this.keyboardType,
    this.obscure = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
  });

  final String label;
  final String hint;
  final TextInputType? keyboardType;
  final bool obscure;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter-Medium',
            fontSize: 12,
            color: Palette.textMuted,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0x22FFFFFF), Color(0x11000000)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white.withOpacity(0.14)),
          ),
          child: TextField(
            obscureText: obscure,
            keyboardType: keyboardType,
            style: const TextStyle(
              color: Palette.textPrimary,
              fontFamily: 'Inter-Medium',
            ),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              hintText: hint,
              hintStyle: const TextStyle(
                color: Palette.textMuted,
                fontFamily: 'Inter-Regular',
              ),
              prefixIcon: prefixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 12, right: 4),
                      child: Icon(prefixIcon,
                          size: 18, color: Palette.textMuted),
                    )
                  : null,
              prefixIconConstraints:
                  const BoxConstraints(minWidth: 36, minHeight: 36),
              suffixIcon: suffixIcon != null
                  ? IconButton(
                      onPressed: onSuffixTap,
                      icon: Icon(suffixIcon,
                          size: 18, color: Palette.textMuted),
                    )
                  : null,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
