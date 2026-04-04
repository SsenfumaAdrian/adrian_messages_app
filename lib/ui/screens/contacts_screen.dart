// FILE: lib/ui/screens/contacts_screen.dart
//
// Matches: stitch/adrian_messages_contacts_circles/screen.png
// Design:  Two-section layout — People + Circles
//          Light theme, surfaceContainerLowest cards, no visible borders.

import 'package:flutter/material.dart';

import '../../core/constants/palette.dart';
import '../../core/navigation/liquid_router.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  final _searchCtrl = TextEditingController();
  String _query = '';

  static final _contacts = [
    const _Contact(
        name: 'Elena Vance', role: 'Design Lead', online: true, initials: 'EV'),
    const _Contact(
        name: 'Marcus Reid', role: 'Engineering', online: true, initials: 'MR'),
    const _Contact(
        name: 'Sarah Miller',
        role: 'Product Manager',
        online: false,
        initials: 'SM'),
    const _Contact(
        name: 'James Okonkwo',
        role: 'Data Science',
        online: true,
        initials: 'JO'),
    const _Contact(
        name: 'Priya Sharma',
        role: 'Legal & Compliance',
        online: false,
        initials: 'PS'),
    const _Contact(
        name: 'Leo Fontaine', role: 'Marketing', online: true, initials: 'LF'),
  ];

  static final _circles = [
    const _Circle(
        name: 'Project Alpha', members: 8, icon: Icons.rocket_launch_outlined),
    const _Circle(name: 'Design Team', members: 5, icon: Icons.palette_outlined),
    const _Circle(name: 'Leadership', members: 4, icon: Icons.shield_outlined),
    const _Circle(name: 'All Hands', members: 24, icon: Icons.groups_outlined),
  ];

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
    _searchCtrl.addListener(() => setState(() => _query = _searchCtrl.text));
  }

  @override
  void dispose() {
    _tabs.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.surface,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ───────────────────────────────────────
            _Header(
              searchCtrl: _searchCtrl,
              query: _query,
              tabs: _tabs,
            ),

            // ── Tab views ────────────────────────────────────
            Expanded(
              child: TabBarView(
                controller: _tabs,
                children: [
                  _PeopleTab(contacts: _contacts, query: _query),
                  _CirclesTab(circles: _circles),
                ],
              ),
            ),
          ],
        ),
      ),

      // FAB — new contact
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Palette.primary, Color(0xFF2C3E9E)],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Palette.primary.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person_add_outlined,
                      color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Add Contact',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// HEADER — search + tab bar
// ─────────────────────────────────────────────────────────────
class _Header extends StatelessWidget {
  const _Header({
    required this.searchCtrl,
    required this.query,
    required this.tabs,
  });

  final TextEditingController searchCtrl;
  final String query;
  final TabController tabs;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.surface,
      padding: EdgeInsets.fromLTRB(24, 8, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title row
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                color: Palette.onSurface,
                onPressed: () => Navigator.maybePop(context),
              ),
              const Text(
                'Contacts & Circles',
                style: TextStyle(
                  fontFamily: Palette.fontDisplay,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Palette.onSurface,
                  letterSpacing: -0.4,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Search — no border, surface-container-low pill
          Container(
            decoration: BoxDecoration(
              color: Palette.surfaceContainerLow,
              borderRadius: BorderRadius.circular(99),
            ),
            child: TextField(
              controller: searchCtrl,
              style: const TextStyle(
                fontSize: 14,
                color: Palette.onSurface,
              ),
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: Palette.outline,
                  size: 20,
                ),
                hintText: 'Search people or circles…',
                hintStyle: TextStyle(
                  color: Palette.outline,
                  fontSize: 14,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Tabs
          TabBar(
            controller: tabs,
            labelColor: Palette.primary,
            unselectedLabelColor: Palette.outline,
            labelStyle: const TextStyle(
              fontFamily: Palette.fontDisplay,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            indicator: BoxDecoration(
              color: Palette.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(99),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent, // No lines
            tabs: const [
              Tab(text: 'People'),
              Tab(text: 'Circles'),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// PEOPLE TAB
// ─────────────────────────────────────────────────────────────
class _PeopleTab extends StatelessWidget {
  const _PeopleTab({required this.contacts, required this.query});
  final List<_Contact> contacts;
  final String query;

  @override
  Widget build(BuildContext context) {
    final filtered = query.isEmpty
        ? contacts
        : contacts
            .where((c) =>
                c.name.toLowerCase().contains(query.toLowerCase()) ||
                c.role.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.separated(
      padding: EdgeInsets.all(16),
      itemCount: filtered.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) => _ContactTile(contact: filtered[i]),
    );
  }
}

class _ContactTile extends StatelessWidget {
  const _ContactTile({required this.contact});
  final _Contact contact;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Palette.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Palette.primary.withValues(alpha: 0.04),
            blurRadius: 10,
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
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Palette.primary, Color(0xFF3949AB)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    contact.initials,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              if (contact.online)
                Positioned(
                  bottom: -2,
                  right: -2,
                  child: Container(
                    width: 12,
                    height: 12,
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

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact.name,
                  style: const TextStyle(
                    fontFamily: Palette.fontDisplay,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Palette.primary,
                  ),
                ),
                Text(
                  contact.role,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Palette.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          // Message button
          _ActionBtn(
            icon: Icons.chat_bubble_outline_rounded,
            onTap: () => LiquidRouter.go(
              context,
              LiquidRouter.chat,
              arguments: {'name': contact.name},
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// CIRCLES TAB
// ─────────────────────────────────────────────────────────────
class _CirclesTab extends StatelessWidget {
  const _CirclesTab({required this.circles});
  final List<_Circle> circles;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(16),
      itemCount: circles.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) => _CircleTile(circle: circles[i]),
    );
  }
}

class _CircleTile extends StatelessWidget {
  const _CircleTile({required this.circle});
  final _Circle circle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Palette.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Palette.primary.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Palette.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(circle.icon, color: Palette.primary, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  circle.name,
                  style: const TextStyle(
                    fontFamily: Palette.fontDisplay,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Palette.onSurface,
                  ),
                ),
                Text(
                  '${circle.members} members',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Palette.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          _ActionBtn(
            icon: Icons.arrow_forward_ios_rounded,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// SHARED WIDGETS
// ─────────────────────────────────────────────────────────────
class _ActionBtn extends StatelessWidget {
  const _ActionBtn({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Palette.surfaceContainerHigh,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Icon(icon, size: 18, color: Palette.primary),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// DATA MODELS
// ─────────────────────────────────────────────────────────────
class _Contact {
  const _Contact({
    required this.name,
    required this.role,
    required this.online,
    required this.initials,
  });
  final String name;
  final String role;
  final bool online;
  final String initials;
}

class _Circle {
  const _Circle({
    required this.name,
    required this.members,
    required this.icon,
  });
  final String name;
  final int members;
  final IconData icon;
}
