// FILE: lib/ui/screens/main_shell.dart
//
// App-level navigation shell for authenticated screens.
//
// Mobile  (< 600 px)  → Liquid glass curved bottom nav bar
// Tablet  (600–900)   → Floating centred glass pill, hides on scroll-down
// Desktop (> 900 px)  → Each screen's own AppShell sidebar

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../core/constants/palette.dart';
import 'ai_assistant_screen.dart';
import 'contacts_screen.dart';
import 'conversations_list_screen.dart';
import 'global_discovery_screen.dart';
import 'user_profile_screen.dart';

// ─────────────────────────────────────────────────────────────
// NAV ITEMS
// ─────────────────────────────────────────────────────────────
class _NavItem {
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
  final IconData icon;
  final IconData activeIcon;
  final String label;
}

const _items = [
  _NavItem(
    icon: Icons.chat_bubble_outline_rounded,
    activeIcon: Icons.chat_bubble_rounded,
    label: 'Chats',
  ),
  _NavItem(
    icon: Icons.people_outline_rounded,
    activeIcon: Icons.people_rounded,
    label: 'Contacts',
  ),
  _NavItem(
    icon: Icons.explore_outlined,
    activeIcon: Icons.explore_rounded,
    label: 'Discover',
  ),
  _NavItem(
    icon: Icons.auto_awesome_outlined,
    activeIcon: Icons.auto_awesome_rounded,
    label: 'AI',
  ),
  _NavItem(
    icon: Icons.person_outline_rounded,
    activeIcon: Icons.person_rounded,
    label: 'Profile',
  ),
];

// ─────────────────────────────────────────────────────────────
// MAIN SHELL
// ─────────────────────────────────────────────────────────────
class MainShell extends StatefulWidget {
  const MainShell({super.key, this.initialIndex = 0});
  final int initialIndex;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late int _index;

  static const _pages = [
    ConversationsListScreen(),
    ContactsScreen(),
    GlobalDiscoveryScreen(),
    AiAssistantScreen(),
    UserProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;

    // Desktop → each screen owns its own AppShell sidebar
    if (w >= 900) return _pages[_index];

    if (w >= 600) {
      return _TabletShell(
        index: _index,
        onTap: (i) => setState(() => _index = i),
        pages: _pages,
      );
    }

    return _MobileShell(
      index: _index,
      onTap: (i) => setState(() => _index = i),
      pages: _pages,
    );
  }
}

// ═════════════════════════════════════════════════════════════
// MOBILE SHELL  — liquid glass curved bottom bar
// ═════════════════════════════════════════════════════════════
class _MobileShell extends StatelessWidget {
  const _MobileShell({
    required this.index,
    required this.onTap,
    required this.pages,
  });
  final int index;
  final ValueChanged<int> onTap;
  final List<Widget> pages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.surface,
      extendBody: true, // content bleeds under the glass bar
      body: pages[index],
      bottomNavigationBar: _LiquidCurvedBar(index: index, onTap: onTap),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// LIQUID CURVED BAR
// ─────────────────────────────────────────────────────────────
class _LiquidCurvedBar extends StatefulWidget {
  const _LiquidCurvedBar({required this.index, required this.onTap});
  final int index;
  final ValueChanged<int> onTap;

  @override
  State<_LiquidCurvedBar> createState() => _LiquidCurvedBarState();
}

class _LiquidCurvedBarState extends State<_LiquidCurvedBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _bounceCtrl;
  late Animation<double> _bounce;

  @override
  void initState() {
    super.initState();
    _bounceCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    _bounce =
        CurvedAnimation(parent: _bounceCtrl, curve: Curves.elasticOut);
  }

  @override
  void didUpdateWidget(_LiquidCurvedBar old) {
    super.didUpdateWidget(old);
    if (old.index != widget.index) _bounceCtrl.forward(from: 0);
  }

  @override
  void dispose() {
    _bounceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pad = MediaQuery.viewPaddingOf(context).bottom;
    final w   = MediaQuery.sizeOf(context).width;
    final itemW = w / _items.length;
    final activeX = itemW * widget.index + itemW / 2;

    return AnimatedBuilder(
      animation: _bounce,
      builder: (_, __) {
        return ClipPath(
          clipper: _CurvedClipper(activeX: activeX),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: Container(
              height: 70 + pad,
              decoration: BoxDecoration(
                // Liquid glass: very slight white fill + gradient shimmer
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withValues(alpha: 0.72),
                    Colors.white.withValues(alpha: 0.58),
                  ],
                ),
                border: Border(
                  top: BorderSide(
                    color: Colors.white.withValues(alpha: 0.85),
                    width: 1.2,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Palette.primary.withValues(alpha: 0.10),
                    blurRadius: 30,
                    offset: const Offset(0, -6),
                  ),
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.60),
                    blurRadius: 1,
                    offset: const Offset(0, -0.5),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: pad),
                child: Row(
                  children: List.generate(_items.length, (i) {
                    final active = i == widget.index;
                    final item   = _items[i];
                    return Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => widget.onTap(i),
                        child: SizedBox(
                          height: 70,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Icon — bumps up when active
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 320),
                                curve: Curves.easeOutBack,
                                transform: Matrix4.translationValues(
                                    0, active ? -8 : 0, 0),
                                child: _GlassIconBubble(
                                  icon: active
                                      ? item.activeIcon
                                      : item.icon,
                                  active: active,
                                  bounce: _bounce.value,
                                ),
                              ),
                              const SizedBox(height: 3),
                              // Label
                              AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 200),
                                style: TextStyle(
                                  fontFamily: Palette.fontDisplay,
                                  fontSize: 9.5,
                                  fontWeight: active
                                      ? FontWeight.w800
                                      : FontWeight.w500,
                                  color: active
                                      ? Palette.primary
                                      : Palette.outline,
                                  letterSpacing: active ? 0.2 : 0,
                                ),
                                child: Text(item.label),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ── Glass icon bubble ──────────────────────────────────────────
class _GlassIconBubble extends StatelessWidget {
  const _GlassIconBubble({
    required this.icon,
    required this.active,
    required this.bounce,
  });
  final IconData icon;
  final bool active;
  final double bounce;

  @override
  Widget build(BuildContext context) {
    if (!active) {
      return SizedBox(
        width: 28, height: 28,
        child: Icon(icon, size: 22, color: Palette.outline),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 44 + bounce * 2,
          height: 44 + bounce * 2,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Palette.primary,
                Color.lerp(Palette.primary, Palette.accentCyan, 0.30)!,
              ],
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.35),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Palette.primary.withValues(alpha: 0.38),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.20),
                blurRadius: 2,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          child: Icon(icon, size: 22, color: Colors.white),
        ),
      ),
    );
  }
}

// ── Curved clip path ───────────────────────────────────────────
class _CurvedClipper extends CustomClipper<Path> {
  const _CurvedClipper({required this.activeX});
  final double activeX;

  @override
  Path getClip(Size size) {
    const notchR = 22.0;
    const curveH = 16.0;
    final path = Path();

    path.moveTo(0, curveH);

    // Left side up to notch
    path.cubicTo(
      activeX - notchR * 2.4, curveH,
      activeX - notchR * 1.2, 0,
      activeX - notchR, 0,
    );
    // Notch arc (dips up)
    path.arcToPoint(
      Offset(activeX + notchR, 0),
      radius: const Radius.circular(notchR),
      clockwise: false,
    );
    // Right side back down
    path.cubicTo(
      activeX + notchR * 1.2, 0,
      activeX + notchR * 2.4, curveH,
      size.width, curveH,
    );

    path
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(_CurvedClipper old) => old.activeX != activeX;
}

// ═════════════════════════════════════════════════════════════
// TABLET SHELL  — floating glass pill, hides on scroll-down
// ═════════════════════════════════════════════════════════════
class _TabletShell extends StatefulWidget {
  const _TabletShell({
    required this.index,
    required this.onTap,
    required this.pages,
  });
  final int index;
  final ValueChanged<int> onTap;
  final List<Widget> pages;

  @override
  State<_TabletShell> createState() => _TabletShellState();
}

class _TabletShellState extends State<_TabletShell>
    with SingleTickerProviderStateMixin {
  late AnimationController _visCtrl;
  late Animation<double>   _vis;
  bool _navVisible = true;

  @override
  void initState() {
    super.initState();
    _visCtrl = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 320),
        value: 1.0);
    _vis = CurvedAnimation(parent: _visCtrl, curve: Curves.easeInOutCubic);
  }

  @override
  void dispose() {
    _visCtrl.dispose();
    super.dispose();
  }

  void _onScroll(ScrollNotification n) {
    if (n is! UserScrollNotification) return;
    if (n.direction == ScrollDirection.reverse && _navVisible) {
      _navVisible = false;
      _visCtrl.reverse();
    } else if (n.direction == ScrollDirection.forward && !_navVisible) {
      _navVisible = true;
      _visCtrl.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final pad = MediaQuery.viewPaddingOf(context).bottom;

    return Scaffold(
      backgroundColor: Palette.surface,
      body: NotificationListener<ScrollNotification>(
        onNotification: (n) {
          _onScroll(n);
          return false;
        },
        child: Stack(
          children: [
            // Page content with bottom room for the pill
            Padding(
              padding: EdgeInsets.only(bottom: 84 + pad),
              child: widget.pages[widget.index],
            ),

            // Floating glass pill
            Positioned(
              bottom: 16 + pad,
              left: 0,
              right: 0,
              child: FadeTransition(
                opacity: _vis,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 2),
                    end: Offset.zero,
                  ).animate(_vis),
                  child: Center(
                    child: _GlassPill(
                      index: widget.index,
                      onTap: widget.onTap,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// GLASS PILL  — liquid glass floating nav for tablet
// ─────────────────────────────────────────────────────────────
class _GlassPill extends StatelessWidget {
  const _GlassPill({required this.index, required this.onTap});
  final int index;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          decoration: BoxDecoration(
            // Liquid glass: translucent white + subtle gradient
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.75),
                Colors.white.withValues(alpha: 0.55),
              ],
            ),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.90),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Palette.primary.withValues(alpha: 0.14),
                blurRadius: 32,
                offset: const Offset(0, 10),
              ),
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.60),
                blurRadius: 1,
                offset: const Offset(0, -0.5),
              ),
            ],
          ),
          child: IntrinsicWidth(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(_items.length, (i) {
                final active = i == index;
                final item   = _items[i];

                return GestureDetector(
                  onTap: () => onTap(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 280),
                    curve: Curves.easeOutCubic,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    padding: EdgeInsets.symmetric(
                      horizontal: active ? 20 : 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      gradient: active
                          ? LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Palette.primary,
                                Color.lerp(
                                    Palette.primary,
                                    Palette.accentCyan,
                                    0.25)!,
                              ],
                            )
                          : null,
                      color: active ? null : Colors.transparent,
                      borderRadius: BorderRadius.circular(40),
                      border: active
                          ? Border.all(
                              color: Colors.white.withValues(alpha: 0.30),
                              width: 1,
                            )
                          : null,
                      boxShadow: active
                          ? [
                              BoxShadow(
                                color:
                                    Palette.primary.withValues(alpha: 0.30),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          active ? item.activeIcon : item.icon,
                          size: 20,
                          color: active
                              ? Colors.white
                              : Palette.outline,
                        ),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 280),
                          curve: Curves.easeOutCubic,
                          child: active
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(width: 7),
                                    Text(
                                      item.label,
                                      style: const TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        letterSpacing: 0.1,
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
