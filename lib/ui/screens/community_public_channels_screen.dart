// FILE: lib/ui/screens/community_public_channels_screen.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../components/app_scaffold.dart';

class CommunityPublicChannelsScreen extends StatefulWidget {
  const CommunityPublicChannelsScreen({super.key});
  @override State<CommunityPublicChannelsScreen> createState() => _State();
}
class _State extends State<CommunityPublicChannelsScreen> {
  String _category = 'All';
  static const _cats = ['All', 'Finance', 'Tech', 'Design', 'Leadership', 'Wellness'];
  static const _channels = [
    (name: 'Fintech Strategy Hub', members: '4.2k', tag: 'Finance', live: true, icon: Icons.trending_up_rounded),
    (name: 'Modern Architecture Guild', members: '1.8k', tag: 'Tech', live: false, icon: Icons.architecture_rounded),
    (name: 'Executive Leadership 2024', members: '892', tag: 'Leadership', live: true, icon: Icons.groups_rounded),
    (name: 'Design Systems Network', members: '3.1k', tag: 'Design', live: false, icon: Icons.design_services_outlined),
    (name: 'AI & ML Practitioners', members: '6.7k', tag: 'Tech', live: true, icon: Icons.auto_awesome_outlined),
    (name: 'Global Founders Circle', members: '541', tag: 'Leadership', live: false, icon: Icons.public_rounded),
    (name: 'Creative Directors Forum', members: '2.3k', tag: 'Design', live: false, icon: Icons.brush_rounded),
    (name: 'Wellness at Work', members: '1.1k', tag: 'Wellness', live: false, icon: Icons.spa_outlined),
  ];

  List<({String name, String members, String tag, bool live, IconData icon})> get _filtered => _category == 'All' ? _channels.toList() : _channels.where((c) => c.tag == _category).toList();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Community Hub',
      child: CustomScrollView(slivers: [
        // Featured banner
        SliverToBoxAdapter(child: Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Palette.primary, Color(0xFF1565C0)], begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [BoxShadow(color: Palette.primary.withValues(alpha: 0.30), blurRadius: 24, offset: const Offset(0, 8))],
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Palette.accentCyan.withValues(alpha: 0.20), borderRadius: BorderRadius.circular(99)),
                child: const Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.star_rounded, color: Palette.accentCyan, size: 12),
                  SizedBox(width: 4),
                  Text('FEATURED CIRCLE', style: TextStyle(color: Palette.accentCyan, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 0.8)),
                ])),
              const Spacer(),
              const Text('4.2k Members', style: TextStyle(color: Colors.white70, fontSize: 12)),
            ]),
            const SizedBox(height: 12),
            Text('Fintech Strategy Hub', style: TextStyle(fontFamily: Palette.fontDisplay, fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white)),
            const SizedBox(height: 6),
            const Text('Where the next wave of financial innovation gets shaped.', style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4)),
            const SizedBox(height: 16),
            Row(children: [
              Expanded(child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                child: const Center(child: Text('Join Circle', style: TextStyle(color: Palette.primary, fontWeight: FontWeight.w700, fontSize: 13))),
              )),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)),
                child: const Text('Preview', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
              ),
            ]),
          ]),
        )),

        // Category filters
        SliverToBoxAdapter(child: SizedBox(height: 52, child: ListView(scrollDirection: Axis.horizontal, padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          children: _cats.map((c) {
            final active = c == _category;
            return GestureDetector(onTap: () => setState(() => _category = c), child: AnimatedContainer(
              duration: const Duration(milliseconds: 200), margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              decoration: BoxDecoration(color: active ? Palette.primary : Palette.surfaceContainerHigh, borderRadius: BorderRadius.circular(99)),
              child: Text(c, style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: active ? Colors.white : Palette.onSurfaceVariant)),
            ));
          }).toList(),
        ))),

        SliverToBoxAdapter(child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text('Recommended Channels', style: TextStyle(fontFamily: Palette.fontDisplay, fontSize: 16, fontWeight: FontWeight.w800, color: Palette.onSurface)),
        )),

        SliverList(delegate: SliverChildBuilderDelegate(
          (_, i) {
            final ch = _filtered[i];
            return Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Palette.surfaceContainerLowest, borderRadius: BorderRadius.circular(18), boxShadow: [BoxShadow(color: Palette.primary.withValues(alpha: 0.04), blurRadius: 10)]),
              child: Row(children: [
                Container(width: 48, height: 48, decoration: BoxDecoration(gradient: LinearGradient(colors: [Palette.primary, Palette.primary.withValues(alpha: 0.6)]), borderRadius: BorderRadius.circular(15)),
                  child: Icon(ch.icon, color: Colors.white, size: 22)),
                const SizedBox(width: 14),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Text(ch.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Palette.onSurface)),
                    if (ch.live) ...[const SizedBox(width: 6), Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.red.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)), child: const Text('LIVE', style: TextStyle(fontSize: 9, color: Colors.red, fontWeight: FontWeight.w800, letterSpacing: 0.5)))],
                  ]),
                  Text('${ch.members} members · ${ch.tag}', style: const TextStyle(fontSize: 12, color: Palette.onSurfaceVariant)),
                ])),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(color: Palette.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(10)),
                  child: const Text('Join', style: TextStyle(color: Palette.primary, fontSize: 12, fontWeight: FontWeight.w700)),
                ),
              ]),
            );
          },
          childCount: _filtered.length,
        )),
        const SliverPadding(padding: EdgeInsets.only(bottom: 40)),
      ]),
    );
  }
}
