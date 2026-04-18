// FILE: lib/ui/screens/encrypted_notes_whiteboard_screen.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../components/app_scaffold.dart';

class EncryptedNotesWhiteboardScreen extends StatefulWidget {
  const EncryptedNotesWhiteboardScreen({super.key});
  @override State<EncryptedNotesWhiteboardScreen> createState() => _State();
}
class _State extends State<EncryptedNotesWhiteboardScreen> {
  int _tab = 0;
  int _noteIndex = 0;

  void setTab(int i) => setState(() => _tab = i);
  void setNote(int i, {bool showEditor = false}) => setState(() { _noteIndex = i; if (showEditor) _tab = 1; });
  static const _notes = [
    (title: 'Brainstorm', preview: 'Phase 1: Discovery\nPhase 2: Design sprint\nPhase 3: Ship', tag: 'Workspace'),
    (title: 'Technical Specs.md', preview: '## Architecture\n- Liquid Glass renderer\n- Stitch Intelligence v2', tag: 'Engineering'),
    (title: 'Architecture Overview', preview: 'Core services:\n• Auth\n• Vault\n• Stitch Engine', tag: 'Design'),
    (title: 'Visual Concept: Security', preview: 'Biometric gate → vault → E2E layer', tag: 'Security'),
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final isWide = w >= 700;
    return AppScaffold(
      title: 'Encrypted Notes',
      actions: [
        ClipRRect(borderRadius: BorderRadius.circular(12), child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), child: GestureDetector(onTap: () {},
          child: Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), decoration: BoxDecoration(gradient: const LinearGradient(colors: [Palette.primary, Color(0xFF3949AB)]), borderRadius: BorderRadius.circular(12)),
            child: const Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.add_rounded, color: Colors.white, size: 16), SizedBox(width: 4), Text('New Note', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700))])))),
        ),
        const SizedBox(width: 8),
      ],
      child: isWide ? _WideLayout(state: this) : _NarrowLayout(state: this),
    );
  }
}

class _WideLayout extends StatelessWidget {
  const _WideLayout({required this.state});
  final _State state;
  @override Widget build(BuildContext context) => Row(children: [
    SizedBox(width: 260, child: _NotesList(state: state)),
    Container(width: 1, color: Palette.outlineVariant.withValues(alpha: 0.15)),
    Expanded(child: _NoteEditor(state: state)),
  ]);
}

class _NarrowLayout extends StatelessWidget {
  const _NarrowLayout({required this.state});
  final _State state;
  @override Widget build(BuildContext context) => Column(children: [
    _TabBar(currentTab: state._tab, onTabChanged: state.setTab),
    Expanded(child: state._tab == 0 ? _NotesList(state: state) : _NoteEditor(state: state)),
  ]);
}

class _TabBar extends StatelessWidget {
  const _TabBar({required this.onTabChanged, required this.currentTab});
  final ValueChanged<int> onTabChanged;
  final int currentTab;
  @override Widget build(BuildContext context) => Row(children: [
    Expanded(child: GestureDetector(onTap: () => onTabChanged(0),
      child: Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(border: Border(bottom: BorderSide(color: currentTab == 0 ? Palette.primary : Colors.transparent, width: 2))),
        child: Text('Notes', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w700, color: currentTab == 0 ? Palette.primary : Palette.outline))))),
    Expanded(child: GestureDetector(onTap: () => onTabChanged(1),
      child: Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(border: Border(bottom: BorderSide(color: currentTab == 1 ? Palette.primary : Colors.transparent, width: 2))),
        child: Text('Editor', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w700, color: currentTab == 1 ? Palette.primary : Palette.outline))))),
  ]);
}

class _NotesList extends StatelessWidget {
  const _NotesList({required this.state});
  final _State state;
  @override Widget build(BuildContext context) => Column(children: [
    Padding(padding: const EdgeInsets.all(12), child: Row(children: [
      Container(
        width: 10, height: 10, decoration: const BoxDecoration(color: Palette.accentCyan, shape: BoxShape.circle),
      ),
      const SizedBox(width: 6),
      Text('4 ONLINE', style: const TextStyle(fontSize: 10, color: Palette.accentCyan, fontWeight: FontWeight.w800, letterSpacing: 1)),
      const Spacer(),
      const Icon(Icons.lock_rounded, size: 14, color: Palette.outline),
      const SizedBox(width: 4),
      const Text('E2E', style: TextStyle(fontSize: 10, color: Palette.outline, fontWeight: FontWeight.w700)),
    ])),
    Expanded(child: ListView.builder(itemCount: _State._notes.length, padding: const EdgeInsets.symmetric(horizontal: 8),
      itemBuilder: (_, i) {
        final n = _State._notes[i];
        final active = i == state._noteIndex;
        return GestureDetector(
          onTap: () => state.setNote(i, showEditor: true),
          child: Container(margin: const EdgeInsets.only(bottom: 6), padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: active ? Palette.primary.withValues(alpha: 0.08) : Colors.transparent, borderRadius: BorderRadius.circular(12),
              border: active ? Border.all(color: Palette.primary.withValues(alpha: 0.20)) : null),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(child: Text(n.title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: active ? Palette.primary : Palette.onSurface))),
                Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Palette.accentCyan.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(6)),
                  child: Text(n.tag, style: const TextStyle(fontSize: 9, color: Palette.accentCyan, fontWeight: FontWeight.w700))),
              ]),
              const SizedBox(height: 4),
              Text(n.preview, style: const TextStyle(fontSize: 11, color: Palette.onSurfaceVariant), maxLines: 2, overflow: TextOverflow.ellipsis),
            ])),
        );
      },
    )),
  ]);
}

class _NoteEditor extends StatelessWidget {
  const _NoteEditor({required this.state});
  final _State state;
  @override Widget build(BuildContext context) {
    final note = _State._notes[state._noteIndex];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 8), child: Row(children: [
        Expanded(child: Text(note.title, style: TextStyle(fontFamily: Palette.fontDisplay, fontSize: 20, fontWeight: FontWeight.w800, color: Palette.onSurface))),
        const Icon(Icons.lock_outline_rounded, size: 16, color: Palette.accentCyan),
        const SizedBox(width: 4),
        const Text('Encrypted', style: TextStyle(fontSize: 11, color: Palette.accentCyan, fontWeight: FontWeight.w600)),
      ])),
      Divider(height: 1, color: Palette.outlineVariant.withValues(alpha: 0.15)),
      Expanded(child: Padding(padding: const EdgeInsets.all(20), child: TextField(
        maxLines: null,
        expands: true,
        style: const TextStyle(fontSize: 14, color: Palette.onSurface, height: 1.7),
        controller: TextEditingController(text: note.preview),
        decoration: const InputDecoration(border: InputBorder.none, hintText: 'Start writing…'),
      ))),
      // Toolbar
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(color: Palette.surfaceContainerLow, border: Border(top: BorderSide(color: Palette.outlineVariant.withValues(alpha: 0.15)))),
        child: Row(children: [
          for (final icon in [Icons.format_bold, Icons.format_italic, Icons.format_list_bulleted, Icons.link_rounded, Icons.image_outlined])
            Padding(padding: const EdgeInsets.only(right: 4), child: IconButton(icon: Icon(icon, size: 18, color: Palette.onSurfaceVariant), onPressed: () {}, padding: const EdgeInsets.all(6), constraints: const BoxConstraints())),
          const Spacer(),
          Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Palette.primary, borderRadius: BorderRadius.circular(8)),
            child: const Text('Save', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700))),
        ]),
      ),
    ]);
  }
}
