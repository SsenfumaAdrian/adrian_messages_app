// FILE: lib/ui/screens/group_creation_screen.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../../core/navigation/liquid_router.dart';
import '../components/app_shell.dart';

class GroupCreationScreen extends StatefulWidget {
  const GroupCreationScreen({super.key});
  @override State<GroupCreationScreen> createState() => _State();
}
class _State extends State<GroupCreationScreen> {
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  String _type = 'Private';
  final _selected = <String>{};

  static const _contacts = ['Elena Vance', 'Marcus Reid', 'Sarah Miller', 'James Okonkwo', 'Priya Sharma', 'Leo Fontaine'];

  @override void dispose() { _nameCtrl.dispose(); _descCtrl.dispose(); super.dispose(); }

  @override Widget build(BuildContext context) {
    return AppShell(activeRoute: LiquidRouter.groupCreation, title: 'Create New Circle',
      child: SingleChildScrollView(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Circle icon picker
        Center(child: Column(children: [
          Container(width: 88, height: 88, decoration: BoxDecoration(color: Palette.surfaceContainerHigh, borderRadius: BorderRadius.circular(28),
            border: Border.all(color: Palette.outlineVariant.withOpacity(0.3), width: 2, style: BorderStyle.solid)),
            child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.add_photo_alternate_outlined, color: Palette.outline, size: 28),
              SizedBox(height: 4),
              Text('Add Icon', style: TextStyle(fontSize: 10, color: Palette.outline, fontWeight: FontWeight.w600)),
            ])),
          const SizedBox(height: 8),
          Text('Circle Icon', style: const TextStyle(fontSize: 12, color: Palette.onSurfaceVariant)),
        ])),
        const SizedBox(height: 28),

        _Label('Circle Name'),
        _Field(ctrl: _nameCtrl, hint: 'e.g. Project Alpha, Leadership...'),
        const SizedBox(height: 16),
        _Label('Description'),
        _Field(ctrl: _descCtrl, hint: 'What\'s this circle for?', maxLines: 3),
        const SizedBox(height: 20),

        _Label('Type'),
        Row(children: ['Private', 'Team', 'Open'].map((t) => Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(onTap: () => setState(() => _type = t),
            child: AnimatedContainer(duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(color: _type == t ? Palette.primary : Palette.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(12)),
              child: Text(t, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700,
                color: _type == t ? Colors.white : Palette.primary))))
        )).toList()),
        const SizedBox(height: 28),

        _Label('Add Members'),
        ..._contacts.map((c) => Padding(padding: const EdgeInsets.only(bottom: 8),
          child: GestureDetector(onTap: () => setState(() => _selected.contains(c) ? _selected.remove(c) : _selected.add(c)),
            child: Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(
              color: _selected.contains(c) ? Palette.primary.withOpacity(0.08) : Palette.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _selected.contains(c) ? Palette.primary.withOpacity(0.3) : Colors.transparent)),
              child: Row(children: [
                Container(width: 38, height: 38, decoration: BoxDecoration(gradient: const LinearGradient(colors: [Palette.primary, Color(0xFF3949AB)]),
                  borderRadius: BorderRadius.circular(12)), child: Center(child: Text(c[0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)))),
                const SizedBox(width: 12),
                Expanded(child: Text(c, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Palette.onSurface))),
                if (_selected.contains(c)) const Icon(Icons.check_circle_rounded, color: Palette.primary, size: 20)
                else const Icon(Icons.radio_button_unchecked_rounded, color: Palette.outline, size: 20),
              ])))),
        const SizedBox(height: 28),

        SizedBox(width: double.infinity, height: 56, child: DecoratedBox(decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Palette.primary, Color(0xFF2C3E9E)]),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [BoxShadow(color: Palette.primary.withOpacity(0.28), blurRadius: 20, offset: const Offset(0,6))]),
          child: TextButton(onPressed: () => Navigator.pop(context), style: TextButton.styleFrom(foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
            child: Text('Create Circle${_selected.isNotEmpty ? ' (${_selected.length})' : ''}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15))))),
        const SizedBox(height: 24),
      ])));
  }
}
Widget _Label(String t) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(t, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: Palette.onSurfaceVariant, letterSpacing: 0.3)));
Widget _Field({required TextEditingController ctrl, required String hint, int maxLines = 1}) => TextField(controller: ctrl, maxLines: maxLines,
  style: const TextStyle(fontSize: 14, color: Palette.onSurface),
  decoration: InputDecoration(hintText: hint, hintStyle: const TextStyle(color: Palette.outline, fontSize: 14), filled: true, fillColor: Palette.surfaceContainerLowest,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: Palette.outlineVariant.withOpacity(0.25))),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Palette.primary, width: 1.5))));