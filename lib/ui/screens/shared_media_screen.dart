// FILE: lib/ui/screens/shared_media_screen.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../../core/navigation/liquid_router.dart';
import '../components/app_shell.dart';

class SharedMediaScreen extends StatefulWidget {
  const SharedMediaScreen({super.key});
  @override State<SharedMediaScreen> createState() => _State();
}
class _State extends State<SharedMediaScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  @override void initState() { super.initState(); _tabs = TabController(length: 4, vsync: this); }
  @override void dispose() { _tabs.dispose(); super.dispose(); }

  @override Widget build(BuildContext context) {
    return AppShell(activeRoute: LiquidRouter.sharedMedia, title: 'Shared Media & Files',
      child: Column(children: [
        Container(color: Palette.surface, child: TabBar(controller: _tabs,
          labelColor: Palette.primary, unselectedLabelColor: Palette.outline,
          indicator: BoxDecoration(color: Palette.primary.withOpacity(0.10), borderRadius: BorderRadius.circular(99)),
          indicatorSize: TabBarIndicatorSize.tab, dividerColor: Colors.transparent,
          tabs: const [Tab(text: 'Media'), Tab(text: 'Docs'), Tab(text: 'Links'), Tab(text: 'Audio')])),
        Expanded(child: TabBarView(controller: _tabs, children: [
          _MediaGrid(), _DocList(), _LinkList(), _AudioList(),
        ])),
      ]));
  }
}

class _MediaGrid extends StatelessWidget {
  @override Widget build(BuildContext ctx) => GridView.builder(padding: const EdgeInsets.all(16),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
    itemCount: 18,
    itemBuilder: (_, i) => Container(decoration: BoxDecoration(color: Palette.surfaceContainerHigh, borderRadius: BorderRadius.circular(14)),
      child: Stack(children: [
        Center(child: Icon(i % 3 == 0 ? Icons.play_circle_outline_rounded : Icons.image_outlined, color: Palette.outline, size: 28)),
        Positioned(bottom: 6, right: 6, child: Text('${i + 1}', style: const TextStyle(fontSize: 10, color: Palette.outline))),
      ])));
}

class _DocList extends StatelessWidget {
  static const _docs = [
    ('Project Brief Q4.pdf', '2.4 MB', Icons.picture_as_pdf_outlined),
    ('Design System v3.fig', '18 MB', Icons.design_services_outlined),
    ('Meeting Notes.docx', '340 KB', Icons.article_outlined),
    ('Budget 2026.xlsx', '1.1 MB', Icons.table_chart_outlined),
  ];
  @override Widget build(BuildContext ctx) => ListView.separated(padding: const EdgeInsets.all(16),
    itemCount: _docs.length, separatorBuilder: (_, __) => const SizedBox(height: 10),
    itemBuilder: (_, i) { final d = _docs[i]; return Container(padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Palette.surfaceContainerLowest, borderRadius: BorderRadius.circular(16)),
      child: Row(children: [
        Container(width: 44, height: 44, decoration: BoxDecoration(color: Palette.primary.withOpacity(0.08), borderRadius: BorderRadius.circular(12)),
          child: Icon(d.$3, color: Palette.primary, size: 22)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(d.$1, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Palette.onSurface)),
          Text(d.$2, style: const TextStyle(fontSize: 11, color: Palette.onSurfaceVariant)),
        ])),
        const Icon(Icons.download_outlined, color: Palette.outline, size: 20),
      ]));
    });
}

class _LinkList extends StatelessWidget {
  static const _links = [
    ('Figma Design File', 'figma.com', '2 days ago'),
    ('Linear Project Board', 'linear.app', '5 days ago'),
    ('Notion Workspace', 'notion.so', '1 week ago'),
  ];
  @override Widget build(BuildContext ctx) => ListView.separated(padding: const EdgeInsets.all(16),
    itemCount: _links.length, separatorBuilder: (_, __) => const SizedBox(height: 10),
    itemBuilder: (_, i) { final l = _links[i]; return Container(padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Palette.surfaceContainerLowest, borderRadius: BorderRadius.circular(16)),
      child: Row(children: [
        Container(width: 44, height: 44, decoration: BoxDecoration(color: Palette.accentCyan.withOpacity(0.10), borderRadius: BorderRadius.circular(12)),
          child: const Icon(Icons.link_rounded, color: Palette.accentCyan, size: 22)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(l.$1, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Palette.onSurface)),
          Text('${l.$2} · ${l.$3}', style: const TextStyle(fontSize: 11, color: Palette.onSurfaceVariant)),
        ])),
        const Icon(Icons.open_in_new_rounded, color: Palette.outline, size: 18),
      ]));
    });
}

class _AudioList extends StatelessWidget {
  @override Widget build(BuildContext ctx) => ListView.builder(padding: const EdgeInsets.all(16),
    itemCount: 4,
    itemBuilder: (_, i) => Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Palette.surfaceContainerLowest, borderRadius: BorderRadius.circular(16)),
      child: Row(children: [
        Container(width: 44, height: 44, decoration: BoxDecoration(color: Palette.primary.withOpacity(0.08), shape: BoxShape.circle),
          child: const Icon(Icons.play_arrow_rounded, color: Palette.primary, size: 26)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Voice Note ${i + 1}', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Palette.onSurface)),
          Text('0:${(i + 1) * 12}s', style: const TextStyle(fontSize: 11, color: Palette.onSurfaceVariant)),
        ])),
      ]));
  );
}