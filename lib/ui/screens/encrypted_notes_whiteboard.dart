// FILE: lib/ui/screens/encrypted_notes_whiteboard.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../components/app_scaffold.dart';

class EncryptedNotesWhiteboard extends StatefulWidget {
  const EncryptedNotesWhiteboard({super.key});
  @override State<EncryptedNotesWhiteboard> createState() => _S();
}
class _S extends State<EncryptedNotesWhiteboard> {
  int _selected = 0;
  static const _notes = [
    ('Architecture Overview', 'Phase 1: Discovery\nMap all existing touchpoints and user pain-points across the messaging landscape…', '2h ago', Icons.description_outlined),
    ('Q4 Strategy Memo', 'Key objectives for Q4:\n• Ship Liquid Glass redesign\n• Launch Circle Communities…', 'Yesterday', Icons.article_outlined),
    ('Encrypted Draft', 'Draft board resolution for Series B…', '3 days ago', Icons.lock_outline_rounded),
    ('Whiteboard — Platform Arch', 'Architecture diagram exported', '1 week ago', Icons.draw_outlined),
  ];

  @override Widget build(BuildContext c) {
    final wide = MediaQuery.sizeOf(c).width > 700;
    return AppScaffold(
      title: 'Encrypted Notes',
      actions: [
        IconButton(icon: const Icon(Icons.add_rounded, color: Palette.primary, size: 22), onPressed: () {}),
        IconButton(icon: const Icon(Icons.draw_outlined, color: Palette.primary, size: 20), onPressed: () {}),
      ],
      child: wide
        ? Row(children: [
            SizedBox(width: 260, child: _NotesList(notes: _notes, selected: _selected, onSelect: (i) => setState(()=>_selected=i))),
            const VerticalDivider(width: 1, color: Color(0xFFEAE7EF)),
            Expanded(child: _NoteDetail(note: _notes[_selected])),
          ])
        : Column(children: [
            SizedBox(height: 180, child: _NotesList(notes: _notes, selected: _selected, onSelect: (i) => setState(()=>_selected=i), horizontal: true)),
            Expanded(child: _NoteDetail(note: _notes[_selected])),
          ]),
    );
  }
}

class _NotesList extends StatelessWidget {
  const _NotesList({required this.notes, required this.selected, required this.onSelect, this.horizontal = false});
  final List<(String, String, String, IconData)> notes;
  final int selected;
  final ValueChanged<int> onSelect;
  final bool horizontal;

  @override Widget build(BuildContext c) {
    final items = List.generate(notes.length, (i) {
      final active = i == selected;
      final n = notes[i];
      return GestureDetector(
        onTap: () => onSelect(i),
        child: Container(
          margin: EdgeInsets.all(horizontal ? 8 : 0).add(EdgeInsets.symmetric(vertical: horizontal ? 0 : 4, horizontal: horizontal ? 0 : 8)),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: active ? Palette.primary.withValues(alpha: 0.08) : Colors.transparent, borderRadius: BorderRadius.circular(14),
            border: active ? Border.all(color: Palette.primary.withValues(alpha: 0.2)) : null),
          child: horizontal
            ? Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                Icon(n.$4, color: active ? Palette.primary : Palette.outline, size: 18),
                const SizedBox(height: 6),
                Text(n.$1, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: active ? Palette.primary : Palette.onSurface), maxLines: 2),
                const SizedBox(height: 4),
                Text(n.$3, style: const TextStyle(fontSize: 10, color: Palette.outline)),
              ])
            : Row(children: [
                Container(width: 36, height: 36, decoration: BoxDecoration(color: active ? Palette.primary.withValues(alpha: 0.1) : Palette.surfaceContainerHigh, borderRadius: BorderRadius.circular(10)),
                  child: Icon(n.$4, color: active ? Palette.primary : Palette.outline, size: 18)),
                const SizedBox(width: 10),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(n.$1, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: active ? Palette.primary : Palette.onSurface), maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text(n.$3, style: const TextStyle(fontSize: 11, color: Palette.outline)),
                ])),
              ]),
        ),
      );
    });
    return horizontal
      ? ListView(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 8), children: items)
      : ListView(padding: const EdgeInsets.symmetric(vertical: 8), children: [
          Container(margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [Palette.primary, Color(0xFF3949AB)]), borderRadius: BorderRadius.circular(14)),
            child: const Row(children: [
              Icon(Icons.add_rounded, color: Colors.white, size: 18),
              SizedBox(width: 8),
              Text('New Encrypted Note', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13)),
            ])),
          ...items,
        ]);
  }
}

class _NoteDetail extends StatelessWidget {
  const _NoteDetail({required this.note});
  final (String, String, String, IconData) note;
  @override Widget build(BuildContext c) => Padding(
    padding: const EdgeInsets.all(24),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Expanded(child: Text(note.$1, style: TextStyle(fontFamily: 'Manrope', fontSize: 22, fontWeight: FontWeight.w800, color: Palette.onSurface))),
        Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(color: Palette.accentCyan.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(99)),
          child: const Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.lock_outline_rounded, size: 12, color: Palette.accentCyan),
            SizedBox(width: 4),
            Text('Encrypted', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Palette.accentCyan)),
          ])),
      ]),
      const SizedBox(height: 4),
      Text(note.$3, style: const TextStyle(fontSize: 12, color: Palette.outline)),
      const SizedBox(height: 20),
      Expanded(child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Palette.surfaceContainerLowest, borderRadius: BorderRadius.circular(16)),
        child: Text(note.$2, style: const TextStyle(fontSize: 15, color: Palette.onSurface, height: 1.7)),
      )),
    ]),
  );
}
