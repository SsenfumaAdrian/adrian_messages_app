// FILE: lib/ui/screens/shared_media_screen.dart
import 'package:flutter/material.dart';

import '../../core/constants/palette.dart';
import '../components/app_scaffold.dart';

class SharedMediaScreen extends StatefulWidget {
  const SharedMediaScreen({super.key});

  @override
  State<SharedMediaScreen> createState() => _SharedMediaScreenState();
}

class _SharedMediaScreenState extends State<SharedMediaScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Shared Media & Files',
      child: Column(children: [
        // ── Tab bar ──────────────────────────────────────────
        Container(
          color: Palette.surface,
          child: TabBar(
            controller: _tabs,
            labelColor: Palette.primary,
            unselectedLabelColor: Palette.outline,
            indicator: BoxDecoration(
              color: Palette.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(99),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            tabs: const [
              Tab(text: 'Media'),
              Tab(text: 'Docs'),
              Tab(text: 'Links'),
              Tab(text: 'Audio'),
            ],
          ),
        ),

        // ── Tab views ────────────────────────────────────────
        Expanded(
          child: TabBarView(
            controller: _tabs,
            children: const [
              _MediaGrid(),
              _DocList(),
              _LinkList(),
              _AudioList(),
            ],
          ),
        ),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// MEDIA GRID
// ─────────────────────────────────────────────────────────────
class _MediaGrid extends StatelessWidget {
  const _MediaGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: 18,
      itemBuilder: (_, i) => Container(
        decoration: BoxDecoration(
          color: Palette.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Stack(children: [
          Center(
            child: Icon(
              i % 3 == 0
                  ? Icons.play_circle_outline_rounded
                  : Icons.image_outlined,
              color: Palette.outline,
              size: 28,
            ),
          ),
          Positioned(
            bottom: 6, right: 6,
            child: Text(
              '${i + 1}',
              style: const TextStyle(fontSize: 10, color: Palette.outline),
            ),
          ),
        ]),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// DOCUMENTS LIST
// ─────────────────────────────────────────────────────────────
class _DocList extends StatelessWidget {
  const _DocList();

  static const _docs = [
    (name: 'Project Brief Q4.pdf', size: '2.4 MB', icon: Icons.picture_as_pdf_outlined),
    (name: 'Design System v3.fig', size: '18 MB',  icon: Icons.design_services_outlined),
    (name: 'Meeting Notes.docx',   size: '340 KB', icon: Icons.article_outlined),
    (name: 'Budget 2026.xlsx',     size: '1.1 MB', icon: Icons.table_chart_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(16),
      itemCount: _docs.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) {
        final d = _docs[i];
        return Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Palette.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(children: [
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(
                color: Palette.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(d.icon, color: Palette.primary, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(d.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Palette.onSurface,
                      )),
                  Text(d.size,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Palette.onSurfaceVariant,
                      )),
                ],
              ),
            ),
            const Icon(Icons.download_outlined,
                color: Palette.outline, size: 20),
          ]),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────
// LINKS LIST
// ─────────────────────────────────────────────────────────────
class _LinkList extends StatelessWidget {
  const _LinkList();

  static const _links = [
    (title: 'Figma Design File',    domain: 'figma.com',  age: '2 days ago'),
    (title: 'Linear Project Board', domain: 'linear.app', age: '5 days ago'),
    (title: 'Notion Workspace',     domain: 'notion.so',  age: '1 week ago'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(16),
      itemCount: _links.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) {
        final l = _links[i];
        return Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Palette.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(children: [
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(
                color: Palette.accentCyan.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.link_rounded,
                  color: Palette.accentCyan, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Palette.onSurface,
                      )),
                  Text('${l.domain} · ${l.age}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Palette.onSurfaceVariant,
                      )),
                ],
              ),
            ),
            const Icon(Icons.open_in_new_rounded,
                color: Palette.outline, size: 18),
          ]),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────
// AUDIO LIST
// ─────────────────────────────────────────────────────────────
class _AudioList extends StatelessWidget {
  const _AudioList();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: 4,
      itemBuilder: (_, i) => Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Palette.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              color: Palette.primary.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.play_arrow_rounded,
                color: Palette.primary, size: 26),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Voice Note ${i + 1}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Palette.onSurface,
                    )),
                Text('0:${(i + 1) * 12}s',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Palette.onSurfaceVariant,
                    )),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
