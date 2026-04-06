// FILE: lib/ui/screens/archived_vault_screen.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../components/app_scaffold.dart';

class ArchivedVaultScreen extends StatefulWidget {
  const ArchivedVaultScreen({super.key});
  @override
  State<ArchivedVaultScreen> createState() => _State();
}

class _State extends State<ArchivedVaultScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Vault & Archive',
      child: Column(children: [
        // Tabs
        Container(
            color: Palette.surface,
            child: TabBar(
              controller: _tabs,
              labelColor: Palette.primary,
              unselectedLabelColor: Palette.outline,
              indicator: BoxDecoration(
                  color: Palette.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(99)),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(text: 'Archived Chats'),
                Tab(text: 'Secure Vault')
              ],
            )),
        Expanded(
            child: TabBarView(controller: _tabs, children: [
          _ArchivedTab(),
          _VaultTab(),
        ])),
      ]),
    );
  }
}

class _ArchivedTab extends StatelessWidget {
  static const _items = [
    (
      'Project Alpha — Q2 Retrospective',
      'Last message 45 days ago',
      '18 msgs',
      Icons.archive_outlined
    ),
    (
      'Design Sprint Week 3',
      'Last message 62 days ago',
      '94 msgs',
      Icons.archive_outlined
    ),
    (
      'Offsite Planning 2024',
      'Last message 90 days ago',
      '211 msgs',
      Icons.archive_outlined
    ),
    (
      'Legal Review — Contracts',
      'Last message 30 days ago',
      '7 msgs',
      Icons.archive_outlined
    ),
    (
      'Vendor Negotiations',
      'Last message 120 days ago',
      '56 msgs',
      Icons.archive_outlined
    ),
  ];
  @override
  Widget build(BuildContext context) => ListView.separated(
        padding: EdgeInsets.all(20),
        itemCount: _items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, i) {
          final item = _items[i];
          return Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Palette.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                      color: Palette.primary.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: Offset(0, 2))
                ]),
            child: Row(children: [
              Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                      color: Palette.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(14)),
                  child: Icon(item.$4, color: Palette.outline, size: 22)),
              const SizedBox(width: 12),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(item.$1,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: Palette.onSurface)),
                    Text(item.$2,
                        style: const TextStyle(
                            fontSize: 11, color: Palette.onSurfaceVariant)),
                  ])),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text(item.$3,
                    style: const TextStyle(
                        fontSize: 10,
                        color: Palette.outline,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                GestureDetector(
                    onTap: () {},
                    child: const Text('Restore',
                        style: TextStyle(
                            fontSize: 11,
                            color: Palette.primary,
                            fontWeight: FontWeight.w700))),
              ]),
            ]),
          );
        },
      );
}

class _VaultTab extends StatefulWidget {
  @override
  State<_VaultTab> createState() => _VaultTabState();
}

class _VaultTabState extends State<_VaultTab> {
  bool _unlocked = false;

  @override
  Widget build(BuildContext context) {
    if (!_unlocked) {
      return Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Palette.primary, Color(0xFF3949AB)]),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                      color: Palette.primary.withValues(alpha: 0.3),
                      blurRadius: 24,
                      offset: Offset(0, 8))
                ]),
            child: const Icon(Icons.enhanced_encryption_outlined,
                color: Colors.white, size: 38)),
        const SizedBox(height: 20),
        Text('Encrypted Vault',
            style: TextStyle(
                fontFamily: Palette.fontDisplay,
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Palette.onSurface)),
        const SizedBox(height: 8),
        const Text('Authenticate to access your secure files',
            style: TextStyle(color: Palette.onSurfaceVariant, fontSize: 13)),
        const SizedBox(height: 28),
        GestureDetector(
            onTap: () => setState(() => _unlocked = true),
            child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Palette.primary, Color(0xFF2C3E9E)]),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          color: Palette.primary.withValues(alpha: 0.28),
                          blurRadius: 20,
                          offset: Offset(0, 6))
                    ]),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.fingerprint_rounded,
                      color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text('Unlock with Biometrics',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14)),
                ]))),
      ]));
    }

    return ListView.separated(
      padding: EdgeInsets.all(20),
      itemCount: _vaultItems.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) {
        final item = _vaultItems[i];
        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Palette.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                    color: Palette.primary.withValues(alpha: 0.04), blurRadius: 10)
              ]),
          child: Row(children: [
            Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                    color: Palette.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(14)),
                child: Icon(item.$3, color: Palette.primary, size: 22)),
            const SizedBox(width: 12),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(item.$1,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          color: Palette.onSurface)),
                  Text(item.$2,
                      style: const TextStyle(
                          fontSize: 11, color: Palette.onSurfaceVariant)),
                ])),
            const Icon(Icons.more_vert_rounded,
                color: Palette.outline, size: 18),
          ]),
        );
      },
    );
  }

  static const _vaultItems = [
    (
      'Legal Agreements 2025',
      '3 files · 4.2 MB · E2E Encrypted',
      Icons.gavel_rounded
    ),
    ('Private Notes', '12 notes · Last edited 2 hrs ago', Icons.note_outlined),
    (
      'Contracts Archive',
      '8 files · 18.4 MB · Zero-knowledge',
      Icons.folder_outlined
    ),
    (
      'Medical Records',
      '5 files · 24.1 MB · Biometric lock',
      Icons.medical_information_outlined
    ),
    (
      'ID & Passports',
      '4 files · 8.9 MB · Hardware encrypted',
      Icons.badge_outlined
    ),
  ];
}
