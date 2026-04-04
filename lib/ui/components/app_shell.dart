import 'dart:ui';
// FILE: lib/ui/components/app_shell.dart
//
// Shared scaffold used by every post-auth screen.
// Desktop  → fixed 256 px sidebar + glass header
// Mobile   → top header + bottom floating nav
// No visible lines between sections (Stitch "No-Line Rule").

import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../../core/navigation/liquid_router.dart';
import 'liquid_glass.dart';
import 'logo_card.dart';

// ── Nav item descriptor ────────────────────────────────────────
class AppNavItem {
  const AppNavItem({
    required this.icon,
    required this.label,
    required this.route,
  });
  final IconData icon;
  final String label;
  final String route;
}

// ── Default nav items (matches every stitch screen sidebar) ────
const _defaultNav = [
  AppNavItem(
      icon: Icons.chat_bubble_outline_rounded,
      label: 'Chats',
      route: LiquidRouter.conversations),
  AppNavItem(
      icon: Icons.lock_outline_rounded,
      label: 'Vault',
      route: LiquidRouter.vault),
  AppNavItem(
      icon: Icons.verified_user_outlined,
      label: 'Security',
      route: LiquidRouter.privacy),
  AppNavItem(
      icon: Icons.analytics_outlined,
      label: 'Insights',
      route: LiquidRouter.insights),
  AppNavItem(
      icon: Icons.settings_outlined,
      label: 'Settings',
      route: LiquidRouter.profile),
];

// ── AppShell ───────────────────────────────────────────────────
class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.child,
    required this.activeRoute,
    this.title,
    this.actions = const [],
    this.navItems = _defaultNav,
    this.fab,
  });

  final Widget child;
  final String activeRoute;
  final String? title;
  final List<Widget> actions;
  final List<AppNavItem> navItems;
  final Widget? fab;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isDesktop = size.width >= 900;

    return Scaffold(
      backgroundColor: Palette.surface,
      floatingActionButton: fab,
      body: isDesktop
          ? Row(children: [
              _Sidebar(items: navItems, activeRoute: activeRoute),
              Expanded(
                child: Column(children: [
                  if (title != null) _Header(title: title!, actions: actions),
                  Expanded(child: child),
                ]),
              ),
            ])
          : Column(children: [
              if (title != null)
                _Header(title: title!, actions: actions, mobile: true),
              Expanded(child: child),
              _BottomBar(items: navItems, activeRoute: activeRoute),
            ]),
    );
  }
}

// ── Sidebar ────────────────────────────────────────────────────
class _Sidebar extends StatelessWidget {
  const _Sidebar({required this.items, required this.activeRoute});
  final List<AppNavItem> items;
  final String activeRoute;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 256,
      color: Palette.surface,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Brand
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 32, 24, 28),
              child: Row(children: [
                LogoCard(size: 36, rounded: true),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Adrian',
                        style: TextStyle(
                          fontFamily: Palette.fontDisplay,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Palette.primary,
                          height: 1,
                        )),
                    Text('Intelligent Correspondent',
                        style: TextStyle(
                          fontSize: 8.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.7,
                          color: Palette.outline,
                        )),
                  ],
                ),
              ]),
            ),

            // Nav items
            Expanded(
              child: Column(
                children: items.map((item) {
                  final active = item.route == activeRoute;
                  return GestureDetector(
                    onTap: () =>
                        active ? null : LiquidRouter.go(context, item.route),
                    child: Container(
                      margin: EdgeInsets.only(left: 16, bottom: 2),
                      padding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 13),
                      decoration: BoxDecoration(
                        color: active
                            ? Palette.surfaceContainerLowest
                            : Colors.transparent,
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(99),
                        ),
                        boxShadow: active
                            ? [
                                BoxShadow(
                                  color: Palette.primary.withValues(alpha: 0.06),
                                  blurRadius: 10,
                                  offset: Offset(0, 2),
                                )
                              ]
                            : null,
                      ),
                      child: Row(children: [
                        Icon(item.icon,
                            size: 21,
                            color: active ? Palette.primary : Palette.outline),
                        const SizedBox(width: 13),
                        Text(item.label,
                            style: TextStyle(
                              fontFamily: Palette.fontDisplay,
                              fontSize: 12.5,
                              fontWeight:
                                  active ? FontWeight.w700 : FontWeight.w500,
                              color: active
                                  ? Palette.primary
                                  : Palette.onSurfaceVariant,
                              letterSpacing: 0.3,
                            )),
                      ]),
                    ),
                  );
                }).toList(),
              ),
            ),

            // User avatar row
            Padding(
              padding: EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Row(children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Palette.primary, Color(0xFF3949AB)]),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text('A',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 15)),
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Alex Mercer',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Palette.onSurface)),
                      Text('Pro Plan',
                          style:
                              TextStyle(fontSize: 10, color: Palette.outline)),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Glass Header ───────────────────────────────────────────────
class _Header extends StatelessWidget {
  const _Header({
    required this.title,
    required this.actions,
    this.mobile = false,
  });
  final String title;
  final List<Widget> actions;
  final bool mobile;

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.canPop(context);
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
                Colors.white.withValues(alpha: 0.60),
              ],
            ),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.75),
                width: 0.8,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 16,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                mobile ? 12 : 24, 10,
                mobile ? 12 : 24, 10,
              ),
              child: Row(children: [
                // Liquid glass back button — only when there's somewhere to go back to
                if (mobile && canPop) ...[
                  LiquidGlassBackButton(size: 40),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: Palette.fontDisplay,
                      fontSize: mobile ? 19 : 22,
                      fontWeight: FontWeight.w800,
                      color: Palette.onSurface,
                      letterSpacing: -0.4,
                    ),
                  ),
                ),
                ...actions,
                const SizedBox(width: 4),
                LiquidGlassButton(
                  icon: Icons.search_rounded,
                  size: 40,
                  iconSize: 18,
                  tint: Palette.primary,
                  tooltip: 'Search',
                  onTap: () {},
                ),
                const SizedBox(width: 6),
                LiquidGlassButton(
                  icon: Icons.account_circle_outlined,
                  size: 40,
                  iconSize: 20,
                  tint: Palette.primary,
                  tooltip: 'Profile',
                  onTap: () => Navigator.pushNamed(context, LiquidRouter.profile),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Bottom Bar (mobile) — liquid glass ──────────────────────────
class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.items, required this.activeRoute});
  final List<AppNavItem> items;
  final String activeRoute;

  @override
  Widget build(BuildContext context) {
    // Only shown on desktop AppShell screens (mobile uses MainShell curved bar)
    // Acts as a secondary compact glass nav strip
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withValues(alpha: 0.80),
                Colors.white.withValues(alpha: 0.62),
              ],
            ),
            border: Border(
              top: BorderSide(
                color: Colors.white.withValues(alpha: 0.80),
                width: 0.8,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 12,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: items.map((item) {
                  final active = item.route == activeRoute;
                  return GestureDetector(
                    onTap: () => active
                        ? null
                        : LiquidRouter.go(context, item.route),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          active
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10, sigmaY: 10),
                                    child: Container(
                                      width: 42,
                                      height: 42,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Palette.primary,
                                            Color(0xFF3949AB),
                                          ],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.white
                                              .withValues(alpha: 0.35),
                                          width: 0.8,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Palette.primary
                                                .withValues(alpha: 0.35),
                                            blurRadius: 12,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Icon(item.icon,
                                          size: 20,
                                          color: Colors.white),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  width: 42,
                                  height: 42,
                                  child: Icon(item.icon,
                                      size: 22,
                                      color: Palette.outline),
                                ),
                          const SizedBox(height: 4),
                          Text(
                            item.label,
                            style: TextStyle(
                              fontFamily: Palette.fontDisplay,
                              fontSize: 9.5,
                              fontWeight: active
                                  ? FontWeight.w800
                                  : FontWeight.w500,
                              color: active
                                  ? Palette.primary
                                  : Palette.outline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


