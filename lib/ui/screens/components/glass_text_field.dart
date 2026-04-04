// FILE: lib/ui/screens/components/glass_text_field.dart
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
    this.controller,
    this.onChanged,
  });

  final String label;
  final String hint;
  final TextInputType? keyboardType;
  final bool obscure;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

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
            color: Palette.onSurfaceVariant,
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
            border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscure,
            keyboardType: keyboardType,
            onChanged: onChanged,
            style: const TextStyle(
              color: Palette.onSurface,
              fontFamily: 'Inter-Medium',
            ),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              hintText: hint,
              hintStyle: const TextStyle(
                color: Palette.onSurfaceVariant,
                fontFamily: 'Inter-Regular',
              ),
              prefixIcon: prefixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 12, right: 4),
                      child: Icon(prefixIcon,
                          size: 18, color: Palette.onSurfaceVariant),
                    )
                  : null,
              prefixIconConstraints:
                  const BoxConstraints(minWidth: 36, minHeight: 36),
              suffixIcon: suffixIcon != null
                  ? IconButton(
                      onPressed: onSuffixTap,
                      icon: Icon(suffixIcon,
                          size: 18, color: Palette.onSurfaceVariant),
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
