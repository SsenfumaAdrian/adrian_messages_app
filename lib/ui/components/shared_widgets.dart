// FILE: lib/ui/components/shared_widgets.dart
//
// Reusable micro-widgets used across multiple screens.
// Import this file instead of copy-pasting these widgets.
//
// Usage:
//   import '../../ui/components/shared_widgets.dart';
//   SectionTitle('My Section')
//   GradientButton(label: 'Submit', onTap: _submit)
//   FieldLabel('Email')
//   StatusBadge(label: 'Live', color: Palette.accentCyan)
//   KpiCard(label: 'Users', value: '48K', icon: Icons.people_outline_rounded)

import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';

// ─────────────────────────────────────────────────────────────
// SECTION TITLE  — used as page/card headers
// ─────────────────────────────────────────────────────────────
class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key, this.trailing});
  final String text;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: Text(
          text,
          style: TextStyle(
            fontFamily: Palette.fontDisplay,
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Palette.primary,
            letterSpacing: -0.2,
          ),
        ),
      ),
      if (trailing != null) trailing!,
    ]);
  }
}

// ─────────────────────────────────────────────────────────────
// FIELD LABEL  — label above text inputs
// ─────────────────────────────────────────────────────────────
class FieldLabel extends StatelessWidget {
  const FieldLabel(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w700,
          color: Palette.onSurfaceVariant,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// GRADIENT BUTTON  — primary CTA used on every screen
// ─────────────────────────────────────────────────────────────
class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.height = 56,
  });

  final String label;
  final VoidCallback? onTap;
  final IconData? icon;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: onTap != null
                ? [Palette.primary, const Color(0xFF2C3E9E)]
                : [Palette.outline, Palette.outline],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: onTap != null
              ? [
                  BoxShadow(
                    color: Palette.primary.withValues(alpha: 0.28),
                    blurRadius: 20,
                    offset: Offset(0, 6),
                  )
                ]
              : null,
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 8),
          ],
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
        ]),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// OUTLINE BUTTON  — secondary action
// ─────────────────────────────────────────────────────────────
class OutlineButton extends StatelessWidget {
  const OutlineButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
  });

  final String label;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Palette.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Palette.outlineVariant),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (icon != null) ...[
            Icon(icon, color: Palette.primary, size: 16),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: const TextStyle(
              color: Palette.primary,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ]),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// STATUS BADGE  — colored pill chip (Live, Compliant, etc.)
// ─────────────────────────────────────────────────────────────
class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.label,
    required this.color,
    this.dot = true,
  });

  final String label;
  final Color color;
  final bool dot;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        if (dot) ...[
          Container(
            width: 6, height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 5),
        ],
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// KPI CARD  — metric card used in admin/insights/health screens
// ─────────────────────────────────────────────────────────────
class KpiCard extends StatelessWidget {
  const KpiCard({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.delta,
    this.deltaUp = true,
    this.accent = false,
  });

  final String label;
  final String value;
  final IconData? icon;
  final String? delta;
  final bool deltaUp;
  final bool accent;

  @override
  Widget build(BuildContext context) {
    final textColor = accent ? Colors.white : Palette.onSurface;
    final subColor  = accent ? Colors.white70 : Palette.onSurfaceVariant;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: accent ? Palette.primary : Palette.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Palette.primary.withValues(alpha: accent ? 0.24 : 0.05),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (icon != null) ...[
          Icon(icon, size: 22, color: accent ? Colors.white70 : Palette.primary),
          const SizedBox(height: 10),
        ],
        Text(
          value,
          style: TextStyle(
            fontFamily: Palette.fontDisplay,
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: textColor,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: subColor)),
        if (delta != null) ...[
          const SizedBox(height: 4),
          Row(children: [
            Icon(
              deltaUp ? Icons.trending_up_rounded : Icons.trending_down_rounded,
              size: 12,
              color: deltaUp ? Palette.success : Palette.error,
            ),
            const SizedBox(width: 3),
            Text(
              delta!,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: deltaUp ? Palette.success : Palette.error,
              ),
            ),
          ]),
        ],
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// SURFACE CARD  — standard rounded card container
// ─────────────────────────────────────────────────────────────
class SurfaceCard extends StatelessWidget {
  const SurfaceCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.radius = 20.0,
  });

  final Widget child;
  final EdgeInsets padding;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Palette.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: Color(0x0A1A237E),
            blurRadius: 12,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ─────────────────────────────────────────────────────────────
// AVATAR  — initials avatar with optional online dot
// ─────────────────────────────────────────────────────────────
class InitialsAvatar extends StatelessWidget {
  const InitialsAvatar({
    super.key,
    required this.initials,
    this.size = 44,
    this.radius = 14.0,
    this.online = false,
  });

  final String initials;
  final double size;
  final double radius;
  final bool online;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: size, height: size,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Palette.primary, Color(0xFF3949AB)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Center(
            child: Text(
              initials,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: size * 0.34,
              ),
            ),
          ),
        ),
        if (online)
          Positioned(
            bottom: -2, right: -2,
            child: Container(
              width: 12, height: 12,
              decoration: BoxDecoration(
                color: Palette.accentCyan,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Palette.surfaceContainerLowest,
                  width: 2,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// STACKED TEXT FIELD  — label + text input combo
// ─────────────────────────────────────────────────────────────
class LabeledTextField extends StatelessWidget {
  const LabeledTextField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.maxLines = 1,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.onSuffixTap,
    this.trailingLabel,
  });

  final String label;
  final String hint;
  final TextEditingController? controller;
  final int maxLines;
  final TextInputType? keyboardType;
  final bool obscureText;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final String? trailingLabel;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FieldLabel(label),
          if (trailingLabel != null)
            Text(
              trailingLabel!,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Palette.accentCyan,
              ),
            ),
        ],
      ),
      TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: const TextStyle(fontSize: 14, color: Palette.onSurface),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Palette.outline, fontSize: 14),
          filled: true,
          fillColor: Palette.surfaceContainerLowest,
          contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
          suffixIcon: suffixIcon != null
              ? IconButton(
                  icon: Icon(suffixIcon, size: 19, color: Palette.outline),
                  onPressed: onSuffixTap,
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: Palette.outlineVariant.withValues(alpha: 0.3),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Palette.primary, width: 1.5),
          ),
        ),
      ),
    ]);
  }
}
