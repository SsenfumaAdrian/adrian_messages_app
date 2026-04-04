// FILE: lib/ui/components/liquid_glass.dart
//
// Apple-style Liquid Glass design language (iOS 26 / macOS Tahoe).
// Glass blurs content behind it, refracts "light" via specular highlights,
// and responds to interaction with subtle depth shifts.
//
// Components:
//   • LiquidGlassButton    — circular icon button (back, close, action)
//   • LiquidGlassSurface   — generic glass container / card
//   • LiquidGlassBar       — top app bar / header
//   • LiquidGlassChip      — pill label / badge

import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/constants/palette.dart';

// ─────────────────────────────────────────────────────────────
// LIQUID GLASS BUTTON  — circular floating glass button
// Used as the back button on every screen
// ─────────────────────────────────────────────────────────────
class LiquidGlassButton extends StatefulWidget {
  const LiquidGlassButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 44,
    this.iconSize = 20,
    this.iconColor,
    this.tint,       // optional brand-colour tint behind the glass
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback onTap;
  final double size;
  final double iconSize;
  final Color? iconColor;
  final Color? tint;
  final String? tooltip;

  @override
  State<LiquidGlassButton> createState() => _LiquidGlassButtonState();
}

class _LiquidGlassButtonState extends State<LiquidGlassButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _press;
  late final Animation<double>   _scale;

  @override
  void initState() {
    super.initState();
    _press = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      reverseDuration: const Duration(milliseconds: 200),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.88)
        .animate(CurvedAnimation(parent: _press, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _press.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final radius = widget.size / 2;

    Widget glass = ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width:  widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.0, 0.45, 1.0],
              colors: [
                // Top-left specular highlight — like light hitting glass
                Colors.white.withValues(alpha: 0.75),
                // Mid: slightly tinted if brand colour provided
                (widget.tint ?? Colors.white)
                    .withValues(alpha: widget.tint != null ? 0.18 : 0.45),
                // Bottom-right: darker edge (refraction shadow)
                Colors.white.withValues(alpha: 0.20),
              ],
            ),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.80),
              width: 1.0,
            ),
            boxShadow: [
              // Outer depth shadow
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
              // Inner top highlight (simulates specular reflection)
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.55),
                blurRadius: 1,
                offset: const Offset(0, -0.5),
                spreadRadius: -0.5,
              ),
            ],
          ),
          child: Icon(
            widget.icon,
            size:  widget.iconSize,
            color: widget.iconColor ??
                (widget.tint != null
                    ? widget.tint!.withValues(alpha: 0.85)
                    : Palette.onSurface),
          ),
        ),
      ),
    );

    if (widget.tooltip != null) {
      glass = Tooltip(message: widget.tooltip!, child: glass);
    }

    return ScaleTransition(
      scale: _scale,
      child: GestureDetector(
        onTapDown: (_) => _press.forward(),
        onTapUp: (_) {
          _press.reverse();
          widget.onTap();
        },
        onTapCancel: () => _press.reverse(),
        child: glass,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// LIQUID GLASS BACK BUTTON  — pre-configured back navigation
// ─────────────────────────────────────────────────────────────
class LiquidGlassBackButton extends StatelessWidget {
  const LiquidGlassBackButton({
    super.key,
    this.onTap,
    this.size = 44,
  });

  final VoidCallback? onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return LiquidGlassButton(
      icon: Icons.arrow_back_ios_new_rounded,
      iconSize: 16,
      size: size,
      tint: Palette.primary,
      tooltip: 'Back',
      onTap: onTap ?? () => Navigator.maybePop(context),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// LIQUID GLASS SURFACE  — generic glass container / card
// ─────────────────────────────────────────────────────────────
class LiquidGlassSurface extends StatelessWidget {
  const LiquidGlassSurface({
    super.key,
    required this.child,
    this.borderRadius = 24,
    this.padding = const EdgeInsets.all(16),
    this.tint,
    this.blurSigma = 20,
    this.opacity = 0.65,
  });

  final Widget child;
  final double borderRadius;
  final EdgeInsets padding;
  final Color? tint;
  final double blurSigma;
  final double opacity;   // how opaque the glass fill is (0 = fully transparent)

  @override
  Widget build(BuildContext context) {
    final fill = tint ?? Colors.white;
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.0, 0.5, 1.0],
              colors: [
                fill.withValues(alpha: opacity * 1.15),
                fill.withValues(alpha: opacity * 0.80),
                fill.withValues(alpha: opacity * 0.55),
              ],
            ),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.80),
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// LIQUID GLASS BAR  — top app bar / header overlay
// ─────────────────────────────────────────────────────────────
class LiquidGlassBar extends StatelessWidget {
  const LiquidGlassBar({
    super.key,
    this.title,
    this.leading,
    this.actions = const [],
    this.centerTitle = false,
    this.bottom,
  });

  final String? title;
  final Widget? leading;
  final List<Widget> actions;
  final bool centerTitle;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withValues(alpha: 0.82),
                Colors.white.withValues(alpha: 0.62),
              ],
            ),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.70),
                width: 0.8,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 12,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: leading,
            centerTitle: centerTitle,
            title: title != null
                ? Text(
                    title!,
                    style: TextStyle(
                      fontFamily: Palette.fontDisplay,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Palette.onSurface,
                      letterSpacing: -0.3,
                    ),
                  )
                : null,
            actions: actions,
            bottom: bottom,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// LIQUID GLASS CHIP  — pill badge / label
// ─────────────────────────────────────────────────────────────
class LiquidGlassChip extends StatelessWidget {
  const LiquidGlassChip({
    super.key,
    required this.label,
    this.icon,
    this.tint,
    this.onTap,
  });

  final String label;
  final IconData? icon;
  final Color? tint;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = tint ?? Palette.primary;
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(99),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withValues(alpha: 0.72),
                  color.withValues(alpha: 0.12),
                ],
              ),
              borderRadius: BorderRadius.circular(99),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.80),
                width: 0.8,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 13, color: color),
                  const SizedBox(width: 5),
                ],
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: Palette.fontDisplay,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: color,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
