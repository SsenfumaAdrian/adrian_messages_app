// FILE: lib/ui/components/app_shell.dart
//
// Shared scaffold used by every post-auth screen.
// Desktop  → fixed 256 px sidebar + glass header
// Mobile   → top header + bottom floating nav
// No visible lines between sections (Stitch "No-Line Rule").

import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../../core/navigation/liquid_router.dart';
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
                      margin: const EdgeInsets.only(left: 16, bottom: 2),
                      padding: const EdgeInsets.symmetric(
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
                                  color: Palette.primary.withOpacity(0.06),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
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
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Row(children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
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
    return Container(
      decoration: BoxDecoration(
        color: Palette.surface.withOpacity(0.88),
        boxShadow: [
          BoxShadow(
            color: Palette.primary.withOpacity(0.05),
            blurRadius: 24,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: mobile ? 16 : 24, vertical: 14),
          child: Row(children: [
            if (mobile)
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                color: Palette.onSurface,
                onPressed: () => Navigator.maybePop(context),
              ),
            Expanded(
              child: Text(title,
                  style: TextStyle(
                    fontFamily: Palette.fontDisplay,
                    fontSize: mobile ? 20 : 22,
                    fontWeight: FontWeight.w800,
                    color: Palette.onSurface,
                    letterSpacing: -0.4,
                  )),
            ),
            ...actions,
            const SizedBox(width: 4),
            const _IconBtn(icon: Icons.search_rounded),
            const SizedBox(width: 4),
            const _IconBtn(icon: Icons.account_circle_outlined),
          ]),
        ),
      ),
    );
  }
}

// ── Bottom Bar (mobile) ────────────────────────────────────────
class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.items, required this.activeRoute});
  final List<AppNavItem> items;
  final String activeRoute;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.surface.withOpacity(0.94),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.map((item) {
              final active = item.route == activeRoute;
              return GestureDetector(
                onTap: () =>
                    active ? null : LiquidRouter.go(context, item.route),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: active
                        ? Palette.primary.withOpacity(0.10)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(item.icon,
                          size: 22,
                          color: active ? Palette.primary : Palette.outline),
                      const SizedBox(height: 3),
                      Text(item.label,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight:
                                active ? FontWeight.w700 : FontWeight.w400,
                            color: active ? Palette.primary : Palette.outline,
                          )),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ── Icon Button ────────────────────────────────────────────────
class _IconBtn extends StatelessWidget {
  const _IconBtn({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(99),
      child: InkWell(
        borderRadius: BorderRadius.circular(99),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(icon, size: 21, color: Palette.onSurfaceVariant),
        ),
      ),
    );
  }
}

// ── Reusable stat card ─────────────────────────────────────────
class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.label,
    required this.value,
    this.sub,
    this.icon,
    this.accent = false,
  });
  final String label;
  final String value;
  final String? sub;
  final IconData? icon;
  final bool accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: accent ? Palette.primary : Palette.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Palette.primary.withOpacity(accent ? 0.22 : 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null)
            Icon(icon,
                size: 22, color: accent ? Colors.white70 : Palette.primary),
          if (icon != null) const SizedBox(height: 12),
          Text(value,
              style: TextStyle(
                fontFamily: Palette.fontDisplay,
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: accent ? Colors.white : Palette.onSurface,
                letterSpacing: -0.5,
              )),
          const SizedBox(height: 4),
          Text(label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: accent ? Colors.white70 : Palette.onSurfaceVariant,
              )),
          if (sub != null) ...[
            const SizedBox(height: 2),
            Text(sub!,
                style: TextStyle(
                  fontSize: 10,
                  color: accent ? Colors.white54 : Palette.outline,
                )),
          ],
        ],
      ),
    );
  }
}

// ── Section header ─────────────────────────────────────────────
class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key, this.trailing});
  final String text;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(text,
              style: const TextStyle(
                fontFamily: Palette.fontDisplay,
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Palette.primary,
                letterSpacing: -0.3,
              )),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}
