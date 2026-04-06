// FILE: lib/ui/screens/conversations_list_screen.dart
// World-class conversations list — combines WhatsApp, iMessage, Telegram, Signal patterns.

import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../../core/navigation/liquid_router.dart';
import '../../data/mock/dummy_data.dart';
import '../components/liquid_glass.dart';

class ConversationsListScreen extends StatefulWidget {
  const ConversationsListScreen({super.key});
  @override State<ConversationsListScreen> createState() => _State();
}

class _State extends State<ConversationsListScreen> with SingleTickerProviderStateMixin {
  static const _filters = ['All', 'Unread', 'Groups', 'Pinned'];
  int _filterIndex = 0;
  bool _showSearch = false;
  final _searchCtrl = TextEditingController();

  @override void dispose() { _searchCtrl.dispose(); super.dispose(); }

  List<Conversation> get _filtered {
    const all = DummyData.conversations;
    switch (_filterIndex) {
      case 1: return all.where((c) => c.unread > 0).toList();
      case 2: return all.where((c) => c.isGroup).toList();
      case 3: return all.where((c) => c.isPinned).toList();
      default: return all;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.surface,
      body: Column(children: [
        _Header(
          showSearch: _showSearch,
          searchCtrl: _searchCtrl,
          onSearchToggle: () => setState(() => _showSearch = !_showSearch),
        ),
        _StatusRow(),
        _FilterBar(
          filters: _filters,
          index: _filterIndex,
          onTap: (i) => setState(() => _filterIndex = i),
        ),
        Expanded(
          child: _ConversationList(
            items: _filtered,
            onTap: (c) => Navigator.pushNamed(
              context, LiquidRouter.chat,
              arguments: {'name': c.name},
            ),
          ),
        ),
      ]),
      floatingActionButton: _ComposeFAB(),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// HEADER — glass top bar
// ─────────────────────────────────────────────────────────────
class _Header extends StatelessWidget {
  const _Header({required this.showSearch, required this.searchCtrl, required this.onSearchToggle});
  final bool showSearch;
  final TextEditingController searchCtrl;
  final VoidCallback onSearchToggle;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter, end: Alignment.bottomCenter,
              colors: [Colors.white.withValues(alpha: 0.92), Colors.white.withValues(alpha: 0.70)],
            ),
            border: Border(bottom: BorderSide(color: Colors.white.withValues(alpha: 0.80), width: 0.8)),
          ),
          child: SafeArea(
            bottom: false,
            child: AnimatedCrossFade(
              duration: const Duration(milliseconds: 250),
              crossFadeState: showSearch ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              firstChild: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 14, 10),
                child: Row(children: [
                  Text('Messages', style: TextStyle(fontFamily: Palette.fontDisplay, fontSize: 26, fontWeight: FontWeight.w900, color: Palette.onSurface, letterSpacing: -0.6)),
                  const Spacer(),
                  LiquidGlassButton(icon: Icons.search_rounded, size: 40, iconSize: 19, tint: Palette.primary, onTap: onSearchToggle),
                  const SizedBox(width: 6),
                  LiquidGlassButton(icon: Icons.edit_square, size: 40, iconSize: 19, tint: Palette.primary, tooltip: 'New message', onTap: () {}),
                  const SizedBox(width: 6),
                  LiquidGlassButton(icon: Icons.tune_rounded, size: 40, iconSize: 19, tint: Palette.primary, onTap: () {}),
                ]),
              ),
              secondChild: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 14, 8),
                child: Row(children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: Palette.surfaceContainerLow,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(children: [
                            Icon(Icons.search_rounded, size: 18, color: Palette.outline),
                            const SizedBox(width: 8),
                            Expanded(child: TextField(
                              controller: searchCtrl,
                              autofocus: true,
                              style: const TextStyle(fontSize: 15, color: Palette.onSurface),
                              decoration: const InputDecoration(hintText: 'Search messages, people…', border: InputBorder.none, hintStyle: TextStyle(color: Palette.outline), isDense: true, contentPadding: EdgeInsets.zero),
                            )),
                          ]),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  TextButton(onPressed: onSearchToggle, child: const Text('Cancel', style: TextStyle(color: Palette.primary, fontWeight: FontWeight.w600))),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// STATUS ROW — WhatsApp/Instagram-style story bubbles
// ─────────────────────────────────────────────────────────────
class _StatusRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const statuses = DummyData.statusUpdates;
    return SizedBox(
      height: 96,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        children: [
          // Add my status
          _StatusBubble(
            name: 'My Status',
            initials: 'A',
            color: Palette.primary,
            isAdd: true,
          ),
          ...statuses.map((s) => _StatusBubble(
            name: s.$1.split(' ').first,
            initials: s.$1[0],
            color: Color(s.$4),
          )),
        ],
      ),
    );
  }
}

class _StatusBubble extends StatelessWidget {
  const _StatusBubble({required this.name, required this.initials, required this.color, this.isAdd = false});
  final String name, initials;
  final Color color;
  final bool isAdd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 14),
      child: Column(children: [
        Stack(children: [
          Container(
            width: 52, height: 52,
            decoration: BoxDecoration(
              gradient: isAdd ? null : LinearGradient(colors: [color, color.withValues(alpha: 0.7)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              color: isAdd ? Palette.surfaceContainerHigh : null,
              shape: BoxShape.circle,
              border: isAdd ? null : Border.all(color: Palette.accentCyan, width: 2.5),
            ),
            child: Center(
              child: isAdd
                  ? const Icon(Icons.add_rounded, color: Palette.primary, size: 22)
                  : Text(initials, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
            ),
          ),
          if (isAdd) Positioned(
            bottom: 0, right: 0,
            child: Container(
              width: 18, height: 18,
              decoration: const BoxDecoration(color: Palette.primary, shape: BoxShape.circle),
              child: const Icon(Icons.add, color: Colors.white, size: 12),
            ),
          ),
        ]),
        const SizedBox(height: 5),
        Text(name, style: TextStyle(fontSize: 11, color: isAdd ? Palette.primary : Palette.onSurfaceVariant, fontWeight: FontWeight.w600), maxLines: 1),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// FILTER BAR — pill tabs like iMessage
// ─────────────────────────────────────────────────────────────
class _FilterBar extends StatelessWidget {
  const _FilterBar({required this.filters, required this.index, required this.onTap});
  final List<String> filters;
  final int index;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        children: List.generate(filters.length, (i) {
          final active = i == index;
          return GestureDetector(
            onTap: () => onTap(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: active ? Palette.primary : Palette.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(99),
              ),
              child: Text(
                filters[i],
                style: TextStyle(
                  fontSize: 12.5, fontWeight: FontWeight.w700,
                  color: active ? Colors.white : Palette.onSurfaceVariant,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// CONVERSATION LIST
// ─────────────────────────────────────────────────────────────
class _ConversationList extends StatelessWidget {
  const _ConversationList({required this.items, required this.onTap});
  final List<Conversation> items;
  final ValueChanged<Conversation> onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 100),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 6),
      itemBuilder: (_, i) => _ConversationTile(conv: items[i], onTap: () => onTap(items[i])),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// CONVERSATION TILE — the star of the screen
// ─────────────────────────────────────────────────────────────
class _ConversationTile extends StatelessWidget {
  const _ConversationTile({required this.conv, required this.onTap});
  final Conversation conv;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasUnread = conv.unread > 0;
    final avatarColor = Color(conv.avatarColor);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: hasUnread ? Palette.primary.withValues(alpha: 0.04) : Palette.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(18),
          border: conv.isPinned ? Border.all(color: Palette.accentCyan.withValues(alpha: 0.30), width: 1) : null,
          boxShadow: [
            BoxShadow(color: Palette.primary.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 2)),
          ],
        ),
        child: Row(children: [
          // ── Avatar ──────────────────────────────────────
          Stack(clipBehavior: Clip.none, children: [
            Container(
              width: 52, height: 52,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [avatarColor, avatarColor.withValues(alpha: 0.65)],
                  begin: Alignment.topLeft, end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(conv.isGroup ? 16 : 20),
                border: conv.isAI ? Border.all(color: Palette.accentCyan, width: 2) : null,
              ),
              child: Center(
                child: conv.isAI
                    ? const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 24)
                    : Text(conv.name[0].toUpperCase(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 20)),
              ),
            ),
            // Online dot
            if (!conv.isGroup && !conv.isAI)
              Positioned(
                bottom: 1, right: 1,
                child: Container(
                  width: 12, height: 12,
                  decoration: BoxDecoration(
                    color: conv.unread > 0 ? Palette.accentCyan : Palette.surfaceContainerHigh,
                    shape: BoxShape.circle,
                    border: Border.all(color: Palette.surfaceContainerLowest, width: 2),
                  ),
                ),
              ),
            // Pin indicator
            if (conv.isPinned)
              Positioned(
                top: -4, right: -4,
                child: Container(
                  width: 18, height: 18,
                  decoration: BoxDecoration(color: Palette.accentCyan, shape: BoxShape.circle, border: Border.all(color: Palette.surfaceContainerLowest, width: 1.5)),
                  child: const Icon(Icons.push_pin_rounded, color: Colors.white, size: 10),
                ),
              ),
          ]),

          const SizedBox(width: 12),

          // ── Message content ──────────────────────────────
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(
                  child: Row(children: [
                    if (conv.isEncrypted) const Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: Icon(Icons.lock_outline_rounded, size: 11, color: Palette.accentCyan),
                    ),
                    Flexible(
                      child: Text(
                        conv.name,
                        style: TextStyle(
                          fontFamily: Palette.fontDisplay,
                          fontSize: 14.5,
                          fontWeight: hasUnread ? FontWeight.w800 : FontWeight.w600,
                          color: Palette.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (conv.isGroup) Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(' ·  ${conv.members}', style: const TextStyle(fontSize: 11, color: Palette.outline, fontWeight: FontWeight.w500)),
                    ),
                  ]),
                ),
                const SizedBox(width: 8),
                if (conv.isMuted) const Padding(padding: EdgeInsets.only(right: 4), child: Icon(Icons.volume_off_rounded, size: 13, color: Palette.outline)),
                Text(conv.time, style: TextStyle(fontSize: 11.5, color: hasUnread ? Palette.primary : Palette.outline, fontWeight: hasUnread ? FontWeight.w700 : FontWeight.w400)),
              ]),

              const SizedBox(height: 4),

              Row(children: [
                Expanded(
                  child: conv.isTyping
                      ? Row(children: [
                          Text('typing', style: TextStyle(fontSize: 13, color: Palette.accentCyan, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic)),
                          const SizedBox(width: 4),
                          const _TypingDots(),
                        ])
                      : Text(
                          conv.lastMessage,
                          style: TextStyle(fontSize: 13, color: hasUnread ? Palette.onSurface : Palette.onSurfaceVariant, fontWeight: hasUnread ? FontWeight.w600 : FontWeight.w400),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                ),
                const SizedBox(width: 6),
                if (hasUnread)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(color: Palette.primary, borderRadius: BorderRadius.circular(99)),
                    child: Text('${conv.unread}', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800)),
                  ),
              ]),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _TypingDots extends StatelessWidget {
  const _TypingDots();
  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [
    _Dot(delay: 0), _Dot(delay: 150), _Dot(delay: 300),
  ]);
}

class _Dot extends StatefulWidget {
  const _Dot({required this.delay});
  final int delay;
  @override State<_Dot> createState() => _DotState();
}

class _DotState extends State<_Dot> with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _a;
  @override void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _a = Tween<double>(begin: 0.3, end: 1).animate(CurvedAnimation(parent: _c, curve: Curves.easeInOut));
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _c.repeat(reverse: true);
    });
  }
  @override void dispose() { _c.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => FadeTransition(
    opacity: _a,
    child: Container(
      width: 5, height: 5, margin: const EdgeInsets.only(right: 3),
      decoration: const BoxDecoration(color: Palette.accentCyan, shape: BoxShape.circle),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// COMPOSE FAB
// ─────────────────────────────────────────────────────────────
class _ComposeFAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, LiquidRouter.groupCreation),
          child: Container(
            height: 56, padding: const EdgeInsets.symmetric(horizontal: 22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Palette.primary, Color(0xFF3949AB)]),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.25), width: 0.8),
              boxShadow: [BoxShadow(color: Palette.primary.withValues(alpha: 0.35), blurRadius: 20, offset: const Offset(0, 6))],
            ),
            child: const Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.edit_square, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text('New Message', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14, fontFamily: 'Manrope')),
            ]),
          ),
        ),
      ),
    );
  }
}
