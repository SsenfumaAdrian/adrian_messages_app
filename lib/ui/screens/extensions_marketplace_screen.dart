// FILE: lib/ui/screens/extensions_marketplace_screen.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../../core/navigation/liquid_router.dart';
import '../components/app_shell.dart';

class ExtensionsMarketplaceScreen extends StatefulWidget {
  const ExtensionsMarketplaceScreen({super.key});
  @override
  State<ExtensionsMarketplaceScreen> createState() => _State();
}

class _State extends State<ExtensionsMarketplaceScreen> {
  int _cat = 0;
  static const _cats = [
    'All',
    'Productivity',
    'Security',
    'AI',
    'Integrations'
  ];
  final _installed = <String>{};

  static const _extensions = [
    _Ext(
        'Smart Summariser',
        'AI-powered chat summariser. Get TL;DR on any conversation in one tap.',
        Icons.summarize_outlined,
        'AI',
        4.8,
        12400,
        false),
    _Ext(
        'Notion Sync',
        'Sync messages, files and vault items directly into Notion pages.',
        Icons.integration_instructions_outlined,
        'Integrations',
        4.6,
        8900,
        true),
    _Ext(
        'Schedule Assistant',
        'Let Adrian auto-detect meeting requests and add them to your calendar.',
        Icons.event_outlined,
        'Productivity',
        4.7,
        6200,
        false),
    _Ext(
        'Secure Link Scanner',
        'Every link is scanned for phishing, malware and data leaks before opening.',
        Icons.security_outlined,
        'Security',
        4.9,
        21000,
        true),
    _Ext(
        'Tone Analyser',
        'Real-time emotional tone detection to help you communicate with empathy.',
        Icons.psychology_outlined,
        'AI',
        4.5,
        3800,
        false),
    _Ext(
        'Slack Bridge',
        'Mirror your Slack channels into Adrian Circles — bi-directional sync.',
        Icons.swap_horiz_rounded,
        'Integrations',
        4.4,
        5100,
        false),
  ];

  @override
  Widget build(BuildContext ctx) => AppShell(
      activeRoute: LiquidRouter.marketplace,
      title: 'Extensions Marketplace',
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Hero
        Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Palette.primary, Color(0xFF3949AB)]),
                borderRadius: BorderRadius.circular(22)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Supercharge your\nworkflow.',
                  style: TextStyle(
                      fontFamily: Palette.fontDisplay,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.2)),
              const SizedBox(height: 6),
              const Text('48 extensions available · 2 installed',
                  style: TextStyle(color: Colors.white60, fontSize: 12)),
              const SizedBox(height: 14),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(children: const [
                    Icon(Icons.search_rounded, color: Colors.white54, size: 18),
                    SizedBox(width: 8),
                    Text('Search extensions...',
                        style: TextStyle(color: Colors.white38, fontSize: 13)),
                  ])),
            ])),
        // Category filter
        SizedBox(
            height: 44,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _cats.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) => GestureDetector(
                    onTap: () => setState(() => _cat = i),
                    child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                            color: _cat == i
                                ? Palette.primary
                                : Palette.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(99)),
                        child: Text(_cats[i],
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: _cat == i
                                    ? Colors.white
                                    : Palette.primary)))))),
        const SizedBox(height: 12),
        // Grid
        Expanded(
            child: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.78),
          itemCount: _cat == 0
              ? _extensions.length
              : _extensions.where((e) => e.category == _cats[_cat]).length,
          itemBuilder: (_, i) {
            final list = _cat == 0
                ? _extensions
                : _extensions.where((e) => e.category == _cats[_cat]).toList();
            final ext = list[i];
            return _ExtCard(
                ext: ext,
                installed: _installed.contains(ext.name),
                onToggle: () => setState(() => _installed.contains(ext.name)
                    ? _installed.remove(ext.name)
                    : _installed.add(ext.name)));
          },
        )),
      ]));
}

class _Ext {
  const _Ext(this.name, this.desc, this.icon, this.category, this.rating,
      this.installs, this.featured);
  final String name, desc, category;
  final IconData icon;
  final double rating;
  final int installs;
  final bool featured;
}

class _ExtCard extends StatelessWidget {
  const _ExtCard(
      {required this.ext, required this.installed, required this.onToggle});
  final _Ext ext;
  final bool installed;
  final VoidCallback onToggle;
  @override
  Widget build(BuildContext ctx) => Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Palette.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Palette.primary.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 2))
          ]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                  color: Palette.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(14)),
              child: Icon(ext.icon, color: Palette.primary, size: 22)),
          const Spacer(),
          if (ext.featured)
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                    color: Palette.accentCyan.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(99)),
                child: const Text('⭐', style: TextStyle(fontSize: 10))),
        ]),
        const SizedBox(height: 10),
        Text(ext.name,
            style: TextStyle(
                fontFamily: Palette.fontDisplay,
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: Palette.onSurface)),
        const SizedBox(height: 4),
        Expanded(
            child: Text(ext.desc,
                style: const TextStyle(
                    fontSize: 11, color: Palette.onSurfaceVariant, height: 1.4),
                overflow: TextOverflow.fade)),
        const SizedBox(height: 10),
        Row(children: [
          const Icon(Icons.star_rounded, color: Colors.amber, size: 13),
          const SizedBox(width: 3),
          Text('${ext.rating}',
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Palette.onSurface)),
          const SizedBox(width: 4),
          Text('(${(ext.installs / 1000).toStringAsFixed(0)}k)',
              style: const TextStyle(fontSize: 10, color: Palette.outline)),
        ]),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: onToggle,
          child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                  color: installed
                      ? Palette.surfaceContainerHigh
                      : Palette.primary,
                  borderRadius: BorderRadius.circular(10)),
              child: Text(installed ? 'Installed ✓' : 'Install',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: installed
                          ? Palette.onSurfaceVariant
                          : Colors.white))),
        ),
      ]));
}
