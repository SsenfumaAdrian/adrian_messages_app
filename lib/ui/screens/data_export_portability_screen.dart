// FILE: lib/ui/screens/data_export_portability_screen.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../components/app_scaffold.dart';

class DataExportPortabilityScreen extends StatefulWidget {
  const DataExportPortabilityScreen({super.key});
  @override State<DataExportPortabilityScreen> createState() => _State();
}
class _State extends State<DataExportPortabilityScreen> {
  final _selected = <String>{ 'messages', 'contacts' };
  String _format = 'JSON';
  static const _categories = [
    (key: 'messages', label: 'Messages & Threads', size: '2.4 GB', icon: Icons.chat_bubble_outline_rounded),
    (key: 'contacts', label: 'Contacts & Circles', size: '12 MB', icon: Icons.people_outline_rounded),
    (key: 'vault', label: 'Vault & Files', size: '8.1 GB', icon: Icons.lock_outline_rounded),
    (key: 'ai', label: 'AI History & Insights', size: '340 MB', icon: Icons.auto_awesome_outlined),
    (key: 'media', label: 'Media & Attachments', size: '5.2 GB', icon: Icons.photo_library_outlined),
  ];
  @override
  Widget build(BuildContext context) => AppScaffold(
    title: 'Data Export',
    child: SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('SELECT DATA', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Palette.outline, letterSpacing: 1.2)),
      const SizedBox(height: 10),
      ..._categories.map((c) {
        final sel = _selected.contains(c.key);
        return GestureDetector(onTap: () => setState(() => sel ? _selected.remove(c.key) : _selected.add(c.key)), child: Container(margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: sel ? Palette.primary.withValues(alpha: 0.05) : Palette.surfaceContainerLowest, borderRadius: BorderRadius.circular(16), border: Border.all(color: sel ? Palette.primary.withValues(alpha: 0.25) : Colors.transparent)),
          child: Row(children: [
            Container(width: 40, height: 40, decoration: BoxDecoration(color: sel ? Palette.primary.withValues(alpha: 0.12) : Palette.surfaceContainerHigh, borderRadius: BorderRadius.circular(12)), child: Icon(c.icon, size: 20, color: sel ? Palette.primary : Palette.outline)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(c.label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: sel ? Palette.primary : Palette.onSurface)),
              Text(c.size, style: const TextStyle(fontSize: 11.5, color: Palette.onSurfaceVariant)),
            ])),
            Icon(sel ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded, color: sel ? Palette.primary : Palette.outline, size: 22),
          ])));
      }).toList(),
      const SizedBox(height: 20),
      const Text('FORMAT', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Palette.outline, letterSpacing: 1.2)),
      const SizedBox(height: 10),
      Row(children: ['JSON', 'PDF', 'CSV'].map((f) => Expanded(child: GestureDetector(onTap: () => setState(() => _format = f), child: AnimatedContainer(duration: const Duration(milliseconds: 200), margin: const EdgeInsets.only(right: 8), padding: const EdgeInsets.symmetric(vertical: 10), decoration: BoxDecoration(color: _format == f ? Palette.primary : Palette.surfaceContainerHigh, borderRadius: BorderRadius.circular(10)), child: Center(child: Text(f, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _format == f ? Colors.white : Palette.onSurfaceVariant))))))).toList()),
      const SizedBox(height: 24),
      GestureDetector(onTap: () {}, child: Container(width: double.infinity, height: 54, decoration: BoxDecoration(gradient: const LinearGradient(colors: [Palette.primary, Color(0xFF3949AB)]), borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Palette.primary.withValues(alpha: 0.28), blurRadius: 20, offset: const Offset(0, 6))]),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.download_rounded, color: Colors.white, size: 20), const SizedBox(width: 8),
          Text('Export ${_selected.length} Category${_selected.length != 1 ? "s" : ""}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14))]))),
      const SizedBox(height: 32),
    ])),
  );
}