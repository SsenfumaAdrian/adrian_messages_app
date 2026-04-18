// FILE: lib/ui/screens/global_translation_localization_screen.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../components/app_scaffold.dart';

class GlobalTranslationLocalizationScreen extends StatefulWidget {
  const GlobalTranslationLocalizationScreen({super.key});
  @override State<GlobalTranslationLocalizationScreen> createState() => _State();
}
class _State extends State<GlobalTranslationLocalizationScreen> {
  bool _autoTranslate = true;
  String _primaryLang = 'English';
  static const _langs = ['English', 'Spanish', 'Mandarin', 'French', 'Arabic', 'Portuguese', 'Japanese', 'German'];
  static const _active = ['Spanish', 'French', 'Japanese'];
  @override
  Widget build(BuildContext context) => AppScaffold(
    title: 'Global Translation',
    child: SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(gradient: const LinearGradient(colors: [Palette.primary, Color(0xFF1565C0)]), borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Palette.primary.withValues(alpha: 0.30), blurRadius: 20, offset: const Offset(0, 6))]),
        child: Row(children: [
          const Icon(Icons.language_rounded, color: Palette.accentCyan, size: 32),
          const SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Auto-Translation Active', style: TextStyle(fontFamily: Palette.fontDisplay, fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white)),
            const Text('Messages are translated in real-time', style: TextStyle(color: Colors.white60, fontSize: 12)),
          ])),
          Switch.adaptive(value: _autoTranslate, onChanged: (v) => setState(() => _autoTranslate = v), activeThumbColor: Palette.accentCyan),
        ])),
      const SizedBox(height: 20),
      const Text('PRIMARY LANGUAGE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Palette.outline, letterSpacing: 1.2)),
      const SizedBox(height: 10),
      Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: Palette.surfaceContainerLowest, borderRadius: BorderRadius.circular(16), border: Border.all(color: Palette.outlineVariant.withValues(alpha: 0.25))),
        child: DropdownButton<String>(value: _primaryLang, isExpanded: true, underline: const SizedBox.shrink(), padding: const EdgeInsets.symmetric(horizontal: 12),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Palette.primary),
          onChanged: (v) { if (v != null) setState(() => _primaryLang = v); },
          items: _langs.map((l) => DropdownMenuItem(value: l, child: Text(l))).toList())),
      const SizedBox(height: 20),
      const Text('AUTO-TRANSLATE TO', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Palette.outline, letterSpacing: 1.2)),
      const SizedBox(height: 10),
      Wrap(spacing: 8, runSpacing: 8, children: _langs.map((l) {
        final active = _active.contains(l);
        return GestureDetector(onTap: () {}, child: AnimatedContainer(duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(color: active ? Palette.primary : Palette.surfaceContainerHigh, borderRadius: BorderRadius.circular(99)),
          child: Text(l, style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: active ? Colors.white : Palette.onSurfaceVariant))));
      }).toList()),
      const SizedBox(height: 24),
      // Preview chat
      const Text('TRANSLATION PREVIEW', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Palette.outline, letterSpacing: 1.2)),
      const SizedBox(height: 10),
      Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Palette.surfaceContainerLowest, borderRadius: BorderRadius.circular(16)), child: Column(children: [
        _TranslateBubble(original: 'Hola, ¿cómo estás?', translated: 'Hello, how are you?', from: 'Spanish'),
        const SizedBox(height: 8),
        _TranslateBubble(original: '会議は明日の3時です', translated: 'The meeting is at 3 PM tomorrow', from: 'Japanese'),
      ])),
      const SizedBox(height: 24),
    ])),
  );
}

class _TranslateBubble extends StatelessWidget {
  const _TranslateBubble({required this.original, required this.translated, required this.from});
  final String original, translated, from;
  @override Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Palette.surfaceContainerHigh, borderRadius: BorderRadius.circular(12)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Palette.accentCyan.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(6)),
          child: Text(from, style: const TextStyle(fontSize: 10, color: Palette.accentCyan, fontWeight: FontWeight.w700))),
      ]),
      const SizedBox(height: 6),
      Text(original, style: const TextStyle(fontSize: 13, color: Palette.onSurface)),
      const SizedBox(height: 4),
      Row(children: [const Icon(Icons.translate_rounded, size: 13, color: Palette.outline), const SizedBox(width: 4), Text(translated, style: const TextStyle(fontSize: 12, color: Palette.onSurfaceVariant, fontStyle: FontStyle.italic))]),
    ]));
}