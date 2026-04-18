// FILE: lib/ui/screens/platform_wide_search_archive_screen.dart
// Matches: stitch/platform_wide_search_archive
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../components/app_scaffold.dart';

class PlatformWideSearchArchiveScreen extends StatefulWidget {
  const PlatformWideSearchArchiveScreen({super.key});
  @override State<PlatformWideSearchArchiveScreen> createState() => _State();
}

class _State extends State<PlatformWideSearchArchiveScreen> {
  final _ctrl = TextEditingController();
  String _filter = 'All';
  static const _filters = ['All', 'Messages', 'Files', 'People', 'Vault'];
  static const _results = [
    (who: 'Sarah Chen', msg: 'Q4 strategy finalised — board approved ✓', file: '', time: '14 Oct 2023', type: 'message'),
    (who: 'Global Ops Circle', msg: '', file: 'Q4_Strategy_Executive_Final.pdf', time: '14 Oct 2023', type: 'file'),
    (who: 'Marcus Reid', msg: 'The architecture review is scheduled for Monday', file: '', time: '12 Oct 2023', type: 'message'),
    (who: 'Design Collective', msg: 'New brand tokens landed in Figma', file: '', time: '10 Oct 2023', type: 'message'),
    (who: 'Elena Vance', msg: '', file: 'LiquidGlass_Spec_v3.fig', time: '09 Oct 2023', type: 'file'),
    (who: 'James Okonkwo', msg: 'Budget approved for Q1 expansion 🚀', file: '', time: '07 Oct 2023', type: 'message'),
  ];

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Search Archive',
      child: Column(children: [
        // Search bar
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(color: Palette.surfaceContainerLow, borderRadius: BorderRadius.circular(18)),
                child: Row(children: [
                  const Icon(Icons.search_rounded, color: Palette.outline, size: 20),
                  const SizedBox(width: 10),
                  Expanded(child: TextField(
                    controller: _ctrl,
                    style: const TextStyle(fontSize: 15, color: Palette.onSurface),
                    decoration: const InputDecoration(hintText: 'Search across all messages, files, people…', border: InputBorder.none, hintStyle: TextStyle(color: Palette.outline), isDense: true, contentPadding: EdgeInsets.zero),
                  )),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: Palette.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(8)),
                    child: const Text('1,284 matches', style: TextStyle(fontSize: 11, color: Palette.primary, fontWeight: FontWeight.w700)),
                  ),
                ]),
              ),
            ),
          ),
        ),
        // Filters
        SizedBox(height: 40, child: ListView(scrollDirection: Axis.horizontal, padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          children: _filters.map((f) {
            final active = f == _filter;
            return GestureDetector(
              onTap: () => setState(() => _filter = f),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(color: active ? Palette.primary : Palette.surfaceContainerHigh, borderRadius: BorderRadius.circular(99)),
                child: Text(f, style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: active ? Colors.white : Palette.onSurfaceVariant)),
              ),
            );
          }).toList(),
        )),
        // Results
        Expanded(child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
          itemCount: _results.length + 1,
          itemBuilder: (_, i) {
            if (i == 0) return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text('October 2023', style: TextStyle(fontFamily: Palette.fontDisplay, fontSize: 11, fontWeight: FontWeight.w800, color: Palette.outline, letterSpacing: 1.2)),
            );
            final r = _results[i - 1];
            final isFile = r.type == 'file';
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: Palette.surfaceContainerLowest, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Palette.primary.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))]),
              child: Row(children: [
                Container(width: 40, height: 40, decoration: BoxDecoration(color: isFile ? Palette.accentCyan.withValues(alpha: 0.1) : Palette.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(12)),
                  child: Icon(isFile ? Icons.insert_drive_file_outlined : Icons.chat_bubble_outline_rounded, size: 18, color: isFile ? Palette.accentCyan : Palette.primary)),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(r.who, style: TextStyle(fontFamily: Palette.fontDisplay, fontSize: 13, fontWeight: FontWeight.w700, color: Palette.onSurface)),
                  Text(isFile ? r.file : r.msg, style: const TextStyle(fontSize: 12.5, color: Palette.onSurfaceVariant), maxLines: 1, overflow: TextOverflow.ellipsis),
                ])),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(r.time, style: const TextStyle(fontSize: 10, color: Palette.outline)),
                  const SizedBox(height: 4),
                  const Text('Jump to context', style: TextStyle(fontSize: 10, color: Palette.primary, fontWeight: FontWeight.w600)),
                ]),
              ]),
            );
          },
        )),
      ]),
    );
  }
}
