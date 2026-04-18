// FILE: lib/ui/screens/main_shell.dart
//
// Unified app-level navigation shell — all screen sizes.
//
// Mobile   (< 600px)  → Slim glass rail (68px), tap to slide open overlay drawer
// Tablet   (600-900)  → Inline rail (80px), tap to expand to 240px sidebar
// Desktop  (> 900px)  → Always-expanded 256px glass sidebar

import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../../core/utils/nav_persistence.dart';
import '../components/liquid_glass.dart';
import '../components/logo_card.dart';
import 'ai_assistant_screen.dart';
import 'contacts_screen.dart';
import 'conversations_list_screen.dart';
import 'global_discovery_screen.dart';
import 'user_profile_screen.dart';

// ─────────────────────────────────────────────────────────────
// NAV ITEM MODEL
// ─────────────────────────────────────────────────────────────
class _NavItem {
  const _NavItem({required this.icon, required this.activeIcon, required this.label});
  final IconData icon;
  final IconData activeIcon;
  final String label;
}

const _kItems = [
  _NavItem(icon: Icons.chat_bubble_outline_rounded,  activeIcon: Icons.chat_bubble_rounded,  label: 'Chats'),
  _NavItem(icon: Icons.people_outline_rounded,        activeIcon: Icons.people_rounded,        label: 'Contacts'),
  _NavItem(icon: Icons.explore_outlined,              activeIcon: Icons.explore_rounded,       label: 'Discover'),
  _NavItem(icon: Icons.auto_awesome_outlined,         activeIcon: Icons.auto_awesome_rounded,  label: 'Adrian AI'),
  _NavItem(icon: Icons.person_outline_rounded,        activeIcon: Icons.person_rounded,        label: 'Profile'),
];

const _kPages = [
  ConversationsListScreen(),
  ContactsScreen(),
  GlobalDiscoveryScreen(),
  AiAssistantScreen(),
  UserProfileScreen(),
];

const double _kRailMobile  = 68.0;
const double _kRailTablet  = 80.0;
const double _kSidebarW    = 240.0;
const double _kDesktopW    = 256.0;

// ─────────────────────────────────────────────────────────────
// MAIN SHELL
// ─────────────────────────────────────────────────────────────
class MainShell extends StatefulWidget {
  const MainShell({super.key, this.initialIndex = 0});
  final int initialIndex;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> with SingleTickerProviderStateMixin {
  late int _index;
  bool _expanded = false;
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 280));
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutCubic);
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  void _toggle() {
    setState(() => _expanded = !_expanded);
    _expanded ? _ctrl.forward() : _ctrl.reverse();
  }

  void _pick(int i) {
    setState(() => _index = i);
    NavPersistence.saveTab(i);   // persist so reload returns here
    final w = MediaQuery.sizeOf(context).width;
    if (w < 600 && _expanded) _toggle();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w >= 900) return _DesktopLayout(index: _index, onTap: _pick);
    if (w >= 600) return _TabletLayout(index: _index, onTap: _pick, expanded: _expanded, anim: _anim, onToggle: _toggle);
    return _MobileLayout(index: _index, onTap: _pick, expanded: _expanded, anim: _anim, onToggle: _toggle);
  }
}

// ─────────────────────────────────────────────────────────────
// GLASS SIDEBAR  (shared by all layouts)
// ─────────────────────────────────────────────────────────────
class _GlassSidebar extends StatelessWidget {
  const _GlassSidebar({
    required this.index,
    required this.onTap,
    required this.anim,
    required this.width,
    this.onToggle,
    this.rounded = false,
  });

  final int index;
  final ValueChanged<int> onTap;
  final Animation<double> anim;
  final double width;
  final VoidCallback? onToggle;
  final bool rounded;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(rounded ? 22 : 0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
        child: Container(
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.0, 0.55, 1.0],
              colors: [
                Palette.primary.withValues(alpha: 0.86),
                Color.lerp(Palette.primary, const Color(0xFF0D1A4A), 0.45)!.withValues(alpha: 0.90),
                const Color(0xFF080F30).withValues(alpha: 0.95),
              ],
            ),
            borderRadius: BorderRadius.circular(rounded ? 22 : 0),
            border: Border.all(color: Colors.white.withValues(alpha: 0.13), width: 1.0),
            boxShadow: [
              BoxShadow(color: Palette.primary.withValues(alpha: 0.28), blurRadius: 32, offset: const Offset(6, 0)),
            ],
          ),
          child: SafeArea(
            right: false,
            child: Column(children: [
              // Brand header
              _SidebarHeader(anim: anim, onToggle: onToggle),
              const SizedBox(height: 6),
              // Nav items
              Expanded(
                child: Column(
                  children: List.generate(_kItems.length, (i) => _SidebarItem(
                    item: _kItems[i],
                    active: i == index,
                    anim: anim,
                    onTap: () => onTap(i),
                  )),
                ),
              ),
              // Bottom avatar strip
              _SidebarAvatar(anim: anim),
              const SizedBox(height: 12),
            ]),
          ),
        ),
      ),
    );
  }
}

// ── Sidebar header ──────────────────────────────────────────
class _SidebarHeader extends StatelessWidget {
  const _SidebarHeader({required this.anim, this.onToggle});
  final Animation<double> anim;
  final VoidCallback? onToggle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 14, 10, 6),
      child: GestureDetector(
        onTap: onToggle,
        child: AnimatedBuilder(
          animation: anim,
          builder: (_, __) {
            final show = anim.value > 0.45;
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                LogoCard(size: 42, rounded: true),
                if (show) ...[
                  const SizedBox(width: 10),
                  Flexible(
                    child: FadeTransition(
                      opacity: anim,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Adrian', style: TextStyle(fontFamily: Palette.fontDisplay, fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white, height: 1.1)),
                          Text('Messages', style: TextStyle(fontFamily: Palette.fontBody, fontSize: 9, fontWeight: FontWeight.w600, color: Colors.white.withValues(alpha: 0.50), letterSpacing: 0.7)),
                        ],
                      ),
                    ),
                  ),
                  if (onToggle != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: FadeTransition(
                        opacity: anim,
                        child: Icon(Icons.chevron_left_rounded, color: Colors.white.withValues(alpha: 0.55), size: 18),
                      ),
                    ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

// ── Sidebar nav item ────────────────────────────────────────
class _SidebarItem extends StatelessWidget {
  const _SidebarItem({required this.item, required this.active, required this.anim, required this.onTap});
  final _NavItem item;
  final bool active;
  final Animation<double> anim;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedBuilder(
        animation: anim,
        builder: (_, __) {
          final showLabel = anim.value > 0.4;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: active ? Colors.white.withValues(alpha: 0.17) : Colors.transparent,
                borderRadius: BorderRadius.circular(13),
                border: active ? Border.all(color: Colors.white.withValues(alpha: 0.22), width: 0.8) : null,
              ),
              child: Row(children: [
                // Icon bubble
                SizedBox(
                  width: 36, height: 36,
                  child: Container(
                    decoration: active
                        ? BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.28), width: 0.8),
                          )
                        : null,
                    child: Icon(
                      active ? item.activeIcon : item.icon,
                      size: 19,
                      color: active ? Colors.white : Colors.white.withValues(alpha: 0.52),
                    ),
                  ),
                ),
                // Label — only shown when sidebar is expanding/expanded
                if (showLabel) ...[
                  const SizedBox(width: 8),
                  Flexible(
                    child: FadeTransition(
                      opacity: Tween<double>(begin: 0, end: 1).animate(anim),
                      child: Text(
                        item.label,
                        style: TextStyle(
                          fontFamily: Palette.fontDisplay,
                          fontSize: 13,
                          fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                          color: active ? Colors.white : Colors.white.withValues(alpha: 0.62),
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ]),
            ),
          );
        },
      ),
    );
  }
}

// ── Sidebar avatar (bottom) ─────────────────────────────────
class _SidebarAvatar extends StatelessWidget {
  const _SidebarAvatar({required this.anim});
  final Animation<double> anim;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: anim,
      builder: (_, __) {
        final show = anim.value > 0.5;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Row(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: Container(
                width: 36, height: 36,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF3949AB), Palette.primary], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.22), width: 0.8),
                ),
                child: const Center(child: Text('A', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15))),
              ),
            ),
            if (show) ...[
              const SizedBox(width: 10),
              Expanded(
                child: FadeTransition(
                  opacity: anim,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Adrian User', style: TextStyle(fontFamily: Palette.fontDisplay, fontSize: 11.5, fontWeight: FontWeight.w700, color: Colors.white), overflow: TextOverflow.ellipsis),
                      Text('Demo Mode', style: TextStyle(fontSize: 9, color: Colors.white.withValues(alpha: 0.48)), overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              ),
            ],
          ]),
        );
      },
    );
  }
}

// ═════════════════════════════════════════════════════════════
// MOBILE LAYOUT
// ═════════════════════════════════════════════════════════════
class _MobileLayout extends StatelessWidget {
  const _MobileLayout({required this.index, required this.onTap, required this.expanded, required this.anim, required this.onToggle});
  final int index;
  final ValueChanged<int> onTap;
  final bool expanded;
  final Animation<double> anim;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.viewPaddingOf(context).top;
    return Scaffold(
      backgroundColor: Palette.surface,
      body: Stack(children: [
        // Page — padded for rail
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.only(left: _kRailMobile),
            child: _kPages[index],
          ),
        ),

        // Scrim
        if (expanded)
          Positioned.fill(
            child: GestureDetector(
              onTap: onToggle,
              child: FadeTransition(
                opacity: anim,
                child: Container(color: Colors.black.withValues(alpha: 0.32)),
              ),
            ),
          ),

        // Sidebar
        Positioned(
          top: 0, bottom: 0, left: 0,
          child: AnimatedBuilder(
            animation: anim,
            builder: (_, __) => _GlassSidebar(
              index: index,
              onTap: onTap,
              anim: anim,
              width: _kRailMobile + (_kSidebarW - _kRailMobile) * anim.value,
              onToggle: onToggle,
              rounded: true,
            ),
          ),
        ),

        // Expand chevron — only when collapsed
        if (!expanded)
          Positioned(
            top: topPad + 14,
            left: _kRailMobile - 12,
            child: LiquidGlassButton(
              icon: Icons.chevron_right_rounded,
              size: 26,
              iconSize: 14,
              iconColor: Palette.primary,
              onTap: onToggle,
            ),
          ),
      ]),
    );
  }
}

// ═════════════════════════════════════════════════════════════
// TABLET LAYOUT
// ═════════════════════════════════════════════════════════════
class _TabletLayout extends StatelessWidget {
  const _TabletLayout({required this.index, required this.onTap, required this.expanded, required this.anim, required this.onToggle});
  final int index;
  final ValueChanged<int> onTap;
  final bool expanded;
  final Animation<double> anim;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.surface,
      body: Row(children: [
        AnimatedBuilder(
          animation: anim,
          builder: (_, __) => _GlassSidebar(
            index: index,
            onTap: onTap,
            anim: anim,
            width: _kRailTablet + (_kSidebarW - _kRailTablet) * anim.value,
            onToggle: onToggle,
          ),
        ),
        Expanded(child: _kPages[index]),
      ]),
    );
  }
}

// ═════════════════════════════════════════════════════════════
// DESKTOP LAYOUT
// ═════════════════════════════════════════════════════════════
class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({required this.index, required this.onTap});
  final int index;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.surface,
      body: Row(children: [
        _GlassSidebar(
          index: index,
          onTap: onTap,
          anim: const AlwaysStoppedAnimation<double>(1.0),
          width: _kDesktopW,
        ),
        Expanded(child: _kPages[index]),
      ]),
    );
  }
}
