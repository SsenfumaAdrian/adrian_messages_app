// FILE: lib/ui/screens/global_translation_localization.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../components/app_scaffold.dart';

class GlobalTranslationLocalization extends StatefulWidget {
  const GlobalTranslationLocalization({super.key});
  @override State<GlobalTranslationLocalization> createState() => _S();
}
class _S extends State<GlobalTranslationLocalization> {
  bool _autoTranslate = true;
  static const _pairs = [
    ('English', 'Mandarin', '🇺🇸', '🇨🇳', true),
    ('English', 'French', '🇺🇸', '🇫🇷', true),
    ('English', 'Swahili', '🇺🇸', '🇰🇪', false),
  ];
  static const _languages = ['English', 'Mandarin', 'Spanish', 'French', 'Arabic', 'Hindi', 'Swahili', 'Portuguese', 'Japanese', 'Korean'];

  @override Widget build(BuildContext c) => AppScaffold(
    title: 'Translation & Localization',
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Header
        Container(padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(gradient: const LinearGradient(colors: [Palette.primary, Color(0xFF3949AB)]), borderRadius: BorderRadius.circular(20)),
          child: Row(children: [
            const Text('🌐', style: TextStyle(fontSize: 36)),
            const SizedBox(width: 16),
            const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Localization Ecosystem', style: TextStyle(color: Colors.white, fontFamily: 'Manrope', fontSize: 18, fontWeight: FontWeight.w900)),
              SizedBox(height: 4),
              Text('Real-time AI translation across 48 languages', style: TextStyle(color: Colors.white60, fontSize: 12)),
            ])),
          ])),
        const SizedBox(height: 20),

        // Auto-translate toggle
        Container(padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Palette.surfaceContainerLowest, borderRadius: BorderRadius.circular(16)),
          child: Row(children: [
            const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Auto-Translate Messages', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Palette.onSurface)),
              Text('Automatically translate incoming messages', style: TextStyle(fontSize: 12, color: Palette.onSurfaceVariant)),
            ])),
            Switch.adaptive(value: _autoTranslate, onChanged: (v) => setState(() => _autoTranslate = v), activeThumbColor: Palette.primary),
          ])),
        const SizedBox(height: 20),

        Text('Active Language Pairs', style: TextStyle(fontFamily: 'Manrope', fontSize: 17, fontWeight: FontWeight.w800, color: Palette.onSurface)),
        const SizedBox(height: 12),
        ..._pairs.map((p) => Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Palette.surfaceContainerLowest, borderRadius: BorderRadius.circular(16),
            border: p.$5 ? Border.all(color: Palette.accentCyan.withValues(alpha: 0.3)) : null),
          child: Row(children: [
            Text(p.$3, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 8),
            Text(p.$1, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Palette.primary)),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Icon(Icons.arrow_forward_rounded, color: Palette.outline, size: 16)),
            Text(p.$4, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 8),
            Text(p.$2, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Palette.primary)),
            const Spacer(),
            if (p.$5) Container(width: 8, height: 8, decoration: const BoxDecoration(color: Palette.accentCyan, shape: BoxShape.circle))
            else const Icon(Icons.add_rounded, color: Palette.outline, size: 18),
          ]),
        )),
        const SizedBox(height: 20),

        Text('Supported Languages', style: TextStyle(fontFamily: 'Manrope', fontSize: 17, fontWeight: FontWeight.w800, color: Palette.onSurface)),
        const SizedBox(height: 12),
        Wrap(spacing: 8, runSpacing: 8, children: _languages.map((l) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(color: Palette.surfaceContainerHigh, borderRadius: BorderRadius.circular(99)),
          child: Text(l, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: Palette.onSurface)),
        )).toList()),
        const SizedBox(height: 32),
      ]),
    ),
  );
}
