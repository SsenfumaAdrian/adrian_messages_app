// FILE: lib/ui/components/app_scaffold.dart
//
// THE single scaffold used by EVERY authenticated screen.
// It handles:
//   • Liquid glass back button (sub-screens only, auto-detected)
//   • Consistent glass header with title + actions
//   • No sidebar (MainShell owns that)
//   • SafeArea + proper insets

import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import 'liquid_glass.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.child,
    this.title,
    this.actions = const [],
    this.floatingButton,
    this.onBack,
    this.showBack,   // null = auto-detect via Navigator.canPop
    this.backgroundColor,
    this.extendBehindHeader = false,
  });

  final Widget child;
  final String? title;
  final List<Widget> actions;
  final Widget? floatingButton;
  final VoidCallback? onBack;
  final bool? showBack;
  final Color? backgroundColor;
  final bool extendBehindHeader;

  @override
  Widget build(BuildContext context) {
    final canPop  = showBack ?? Navigator.canPop(context);
    final bgColor = backgroundColor ?? Palette.surface;

    return Scaffold(
      backgroundColor: bgColor,
      floatingActionButton: floatingButton,
      body: Column(
        children: [
          if (title != null || canPop)
            _GlassHeader(
              title: title,
              canPop: canPop,
              actions: actions,
              onBack: onBack ?? () => Navigator.maybePop(context),
            ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// GLASS HEADER
// ─────────────────────────────────────────────────────────────
class _GlassHeader extends StatelessWidget {
  const _GlassHeader({
    required this.title,
    required this.canPop,
    required this.actions,
    required this.onBack,
  });
  final String? title;
  final bool canPop;
  final List<Widget> actions;
  final VoidCallback onBack;

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
                Colors.white.withValues(alpha: 0.90),
                Colors.white.withValues(alpha: 0.68),
              ],
            ),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.80),
                width: 0.8,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Palette.primary.withValues(alpha: 0.04),
                blurRadius: 16,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 14, 8),
              child: Row(children: [
                // Back button — liquid glass
                if (canPop) ...[
                  LiquidGlassBackButton(size: 40, onTap: onBack),
                  const SizedBox(width: 10),
                ],
                if (!canPop) const SizedBox(width: 8),

                // Title
                if (title != null)
                  Expanded(
                    child: Text(
                      title!,
                      style: TextStyle(
                        fontFamily: Palette.fontDisplay,
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: Palette.onSurface,
                        letterSpacing: -0.3,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                else
                  const Spacer(),

                // Action buttons
                ...actions,
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
