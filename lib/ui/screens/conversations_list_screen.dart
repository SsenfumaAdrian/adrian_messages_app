// FILE: lib/ui/screens/conversations_list_screen.dart
//
// Matches: stitch/adrian_messages_conversations_list/screen.png
// Design:  Left sidebar (desktop) or bottom nav (mobile), light surface,
//          conversation cards on surface-container-lowest.
// The "No-Line Rule": no visible borders — sections separated by color shifts.

import 'dart:ui';
import 'package:flutter/material.dart';

import '../../core/constants/palette.dart';
import '../components/liquid_glass.dart';
import '../../core/navigation/liquid_router.dart';
import '../../data/mock/dummy_data.dart';

class ConversationsListScreen extends StatefulWidget {
  const ConversationsListScreen({super.key});

  @override
  State<ConversationsListScreen> createState() =>
      _ConversationsListScreenState();
}

class _ConversationsListScreenState extends State<ConversationsListScreen> {
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
              filterIndex: _filterIndex,
              filters: _filters,
              onFilter: (i) => setState(() => _filterIndex = i),
            )
          : _ContentColumn(
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
    required this.filterIndex,
    required this.filters,
    required this.onFilter,
  });

  final int filterIndex;
  final List<String> filters;
  final ValueChanged<int> onFilter;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TopBar(filters: filters, filterIndex: filterIndex, onFilter: onFilter),
        const Expanded(child: _ConversationFeed()),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// MOBILE (<900px) — top bar + list + bottom nav
// ─────────────────────────────────────────────────────────────
class _ContentColumn extends StatelessWidget {
  const _ContentColumn({
    required this.filterIndex,
    required this.filters,
    required this.onFilter,
  });

  final int filterIndex;
  final List<String> filters;
  final ValueChanged<int> onFilter;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TopBar(filters: filters, filterIndex: filterIndex, onFilter: onFilter),
        const Expanded(child: _ConversationFeed()),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────

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
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withValues(alpha: 0.90),
              Colors.white.withValues(alpha: 0.70),
            ],
          ),
          border: Border(
            bottom: BorderSide(
              color: Colors.white.withValues(alpha: 0.80),
              width: 0.8,
            ),
          ),
        ),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, 12, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title row
                  Row(
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
                            duration: Duration(milliseconds: 200),
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.symmetric(
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


class _IconBtn extends StatelessWidget {
  _IconBtn({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return LiquidGlassButton(
      icon: icon,
      size: 38,
      iconSize: 19,
      tint: Palette.primary,
      onTap: () {},
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
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: chats.length,
      // No dividers — gap only (per design rules)
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, i) => _ConversationTile(
        chat: chats[i],
        onTap: () => Navigator.pushNamed(context, LiquidRouter.chat, arguments: {'name': chats[i]['name']}),
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
        duration: Duration(milliseconds: 180),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          // "Pop" forward on surface-container-lowest — no border
          color: Palette.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Palette.primary.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: Offset(0, 2),
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
                        Palette.primary.withValues(alpha: 0.6),
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
                          
                          padding: EdgeInsets.symmetric(
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
