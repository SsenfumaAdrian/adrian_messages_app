// FILE: lib/ui/screens/conversations_list_screen.dart
//
// Matches: stitch/adrian_messages_conversations_list/screen.png
// Design:  Left sidebar (desktop) or bottom nav (mobile), light surface,
//          conversation cards on surface-container-lowest.
// The "No-Line Rule": no visible borders — sections separated by color shifts.

import 'package:flutter/material.dart';

import '../../core/constants/palette.dart';
import '../../core/navigation/liquid_router.dart';
import '../../data/mock/dummy_data.dart';
import '../components/logo_card.dart';

class ConversationsListScreen extends StatefulWidget {
  const ConversationsListScreen({super.key});

  @override
  State<ConversationsListScreen> createState() =>
      _ConversationsListScreenState();
}

class _ConversationsListScreenState extends State<ConversationsListScreen> {
  int _navIndex = 0; // 0=Chats 1=Contacts 2=Discover 3=Profile

  // Filter tabs
  final _filters = ['All', 'Unread', 'Groups', 'Starred'];
  int _filterIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isDesktop = size.width >= 900;

    return Scaffold(
      backgroundColor: Palette.surface,
      body: isDesktop
          ? _DesktopLayout(
              navIndex: _navIndex,
              onNav: (i) => setState(() => _navIndex = i),
              filterIndex: _filterIndex,
              filters: _filters,
              onFilter: (i) => setState(() => _filterIndex = i),
            )
          : _MobileLayout(
              navIndex: _navIndex,
              onNav: (i) => setState(() => _navIndex = i),
              filterIndex: _filterIndex,
              filters: _filters,
              onFilter: (i) => setState(() => _filterIndex = i),
            ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// DESKTOP (>900px) — sidebar + content
// ─────────────────────────────────────────────────────────────
class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({
    required this.navIndex,
    required this.onNav,
    required this.filterIndex,
    required this.filters,
    required this.onFilter,
  });

  final int navIndex;
  final ValueChanged<int> onNav;
  final int filterIndex;
  final List<String> filters;
  final ValueChanged<int> onFilter;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Sidebar
        _Sidebar(selectedIndex: navIndex, onSelect: onNav),

        // Main content
        Expanded(
          child: Column(
            children: [
              _TopBar(
                  filters: filters,
                  filterIndex: filterIndex,
                  onFilter: onFilter),
              const Expanded(child: _ConversationFeed()),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// MOBILE (<900px) — top bar + list + bottom nav
// ─────────────────────────────────────────────────────────────
class _MobileLayout extends StatelessWidget {
  const _MobileLayout({
    required this.navIndex,
    required this.onNav,
    required this.filterIndex,
    required this.filters,
    required this.onFilter,
  });

  final int navIndex;
  final ValueChanged<int> onNav;
  final int filterIndex;
  final List<String> filters;
  final ValueChanged<int> onFilter;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TopBar(filters: filters, filterIndex: filterIndex, onFilter: onFilter),
        const Expanded(child: _ConversationFeed()),
        _BottomNav(selectedIndex: navIndex, onSelect: onNav),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// SIDEBAR  – desktop left rail
// ─────────────────────────────────────────────────────────────
class _Sidebar extends StatelessWidget {
  const _Sidebar({required this.selectedIndex, required this.onSelect});
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  static const _navItems = [
    (icon: Icons.chat_bubble_outline_rounded, label: 'Chats'),
    (icon: Icons.people_outline_rounded, label: 'Contacts'),
    (icon: Icons.explore_outlined, label: 'Discover'),
    (icon: Icons.settings_outlined, label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 256,
      height: double.infinity,
      // No border — background color shift defines the edge
      color: Palette.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brand mark
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 40, 28, 32),
            child: Row(
              children: [
                LogoCard(size: 36, rounded: true),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Adrian',
                      style: TextStyle(
                        fontFamily: Palette.fontDisplay,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Palette.primary,
                        height: 1,
                      ),
                    ),
                    Text(
                      'Intelligent Correspondent',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                        color: Palette.outline,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Nav items
          Expanded(
            child: Column(
              children: List.generate(_navItems.length, (i) {
                final item = _navItems[i];
                final active = i == selectedIndex;
                return GestureDetector(
                  onTap: () => onSelect(i),
                  child: Container(
                    margin: const EdgeInsets.only(left: 16, bottom: 2),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      // Active: white pill extending to right edge
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
                                blurRadius: 12,
                                offset: const Offset(0, 2),
                              )
                            ]
                          : null,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          item.icon,
                          size: 22,
                          color: active ? Palette.primary : Palette.outline,
                        ),
                        const SizedBox(width: 14),
                        Text(
                          item.label,
                          style: TextStyle(
                            fontFamily: Palette.fontDisplay,
                            fontSize: 13,
                            fontWeight:
                                active ? FontWeight.w700 : FontWeight.w500,
                            color: active
                                ? Palette.primary
                                : Palette.onSurfaceVariant,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),

          // New message FAB at bottom of sidebar
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
            child: _NewMessageButton(),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// TOP BAR  – glassmorphism header
// ─────────────────────────────────────────────────────────────
class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.filters,
    required this.filterIndex,
    required this.onFilter,
  });

  final List<String> filters;
  final int filterIndex;
  final ValueChanged<int> onFilter;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        // Glass nav — surface at 80% opacity + blur
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
        child: ClipRect(
          child: BackdropFilter(
            filter: const _BlurFilter(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title row
                  const Row(
                    children: [
                      Text(
                        'Messages',
                        style: TextStyle(
                          fontFamily: Palette.fontDisplay,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Palette.onSurface,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Spacer(),
                      // Search button
                      _IconBtn(icon: Icons.search_rounded),
                      SizedBox(width: 4),
                      _IconBtn(icon: Icons.tune_rounded),
                      SizedBox(width: 4),
                      _IconBtn(icon: Icons.edit_square),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'You have ${DummyData.chatList.where((c) => (c['unread'] as int) > 0).length} unread conversations',
                    style: const TextStyle(
                      color: Palette.onSurfaceVariant,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Filter chips — no borders, color only
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(filters.length, (i) {
                        final active = i == filterIndex;
                        return GestureDetector(
                          onTap: () => onFilter(i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: active
                                  ? Palette.primary
                                  : Palette.surfaceContainerHigh,
                              borderRadius: BorderRadius.circular(99),
                            ),
                            child: Text(
                              filters[i],
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: active ? Colors.white : Palette.primary,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Lightweight ImageFilter.blur wrapper as a const
class _BlurFilter extends ImageFilter {
  const _BlurFilter() : super._(null);

  @override
  String get debugLabel => 'blur';
}

class _IconBtn extends StatelessWidget {
  const _IconBtn({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(99),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(icon, size: 22, color: Palette.onSurfaceVariant),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// CONVERSATION FEED
// ─────────────────────────────────────────────────────────────
class _ConversationFeed extends StatelessWidget {
  const _ConversationFeed();

  @override
  Widget build(BuildContext context) {
    final chats = DummyData.chatList;

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: chats.length,
      // No dividers — gap only (per design rules)
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, i) => _ConversationTile(
        chat: chats[i],
        onTap: () => LiquidRouter.go(
          context,
          LiquidRouter.chat,
          arguments: {'name': chats[i]['name']},
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// CONVERSATION TILE
// ─────────────────────────────────────────────────────────────
class _ConversationTile extends StatelessWidget {
  const _ConversationTile({required this.chat, required this.onTap});
  final Map<String, dynamic> chat;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final unread = chat['unread'] as int;
    final hasUnread = unread > 0;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          // "Pop" forward on surface-container-lowest — no border
          color: Palette.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Palette.primary.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Palette.primary,
                        Palette.primary.withOpacity(0.6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Center(
                    child: Text(
                      (chat['name'] as String)[0].toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                // Online dot
                Positioned(
                  bottom: -2,
                  right: -2,
                  child: Container(
                    width: 14,
                    height: 14,
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
            ),

            const SizedBox(width: 14),

            // Name + preview
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chat['name'] as String,
                          style: const TextStyle(
                            fontFamily: Palette.fontDisplay,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Palette.primary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        chat['time'] as String,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Palette.onSurfaceVariant,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chat['lastMessage'] as String,
                          style: TextStyle(
                            fontSize: 13,
                            color: hasUnread
                                ? Palette.onSurface
                                : Palette.onSurfaceVariant,
                            fontWeight:
                                hasUnread ? FontWeight.w500 : FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (hasUnread)
                        Container(
                          min: const BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                          ).minWidth,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: Palette.primary,
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Text(
                            '$unread',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// BOTTOM NAV  – mobile floating dock
// ─────────────────────────────────────────────────────────────
class _BottomNav extends StatelessWidget {
  const _BottomNav({required this.selectedIndex, required this.onSelect});
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  static const _items = [
    (icon: Icons.chat_bubble_outline_rounded, label: 'Chats'),
    (icon: Icons.people_outline_rounded, label: 'Contacts'),
    (icon: Icons.explore_outlined, label: 'Discover'),
    (icon: Icons.person_outline_rounded, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      // Ghost border fallback at very low opacity
      decoration: BoxDecoration(
        color: Palette.surface.withOpacity(0.92),
        boxShadow: [
          BoxShadow(
            color: Palette.primary.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (i) {
              final active = i == selectedIndex;
              final item = _items[i];
              return GestureDetector(
                onTap: () => onSelect(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(
                    color: active
                        ? Palette.primary.withOpacity(0.10)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item.icon,
                        size: 24,
                        color: active ? Palette.primary : Palette.outline,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight:
                              active ? FontWeight.w700 : FontWeight.w400,
                          color: active ? Palette.primary : Palette.outline,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// NEW MESSAGE BUTTON
// ─────────────────────────────────────────────────────────────
class _NewMessageButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => LiquidRouter.go(context, LiquidRouter.groupCreation),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Palette.primary, Color(0xFF2C3E9E)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Palette.primary.withOpacity(0.28),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_rounded, color: Colors.white, size: 20),
            SizedBox(width: 6),
            Text(
              'New Message',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
