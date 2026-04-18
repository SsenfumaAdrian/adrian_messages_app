// FILE: lib/ui/screens/digital_will_data_legacy.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../components/app_scaffold.dart';

class DigitalWillDataLegacy extends StatefulWidget {
  const DigitalWillDataLegacy({super.key});
  @override State<DigitalWillDataLegacy> createState() => _S();
}
class _S extends State<DigitalWillDataLegacy> {
  int _inactivityDays = 365;
  static const _contacts = [
    ('Sarah Miller', 'Full vault access + message history', Icons.person_outline_rounded),
    ('James Okonkwo', 'Read-only archive access', Icons.person_outline_rounded),
  ];

  @override Widget build(BuildContext c) => AppScaffold(
    title: 'Digital Legacy Vault',
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF0D1A4A), Color(0xFF1A237E)]), borderRadius: BorderRadius.circular(20)),
          child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(Icons.auto_stories_outlined, color: Colors.white, size: 32),
            SizedBox(height: 12),
            Text('Digital Legacy Vault', style: TextStyle(color: Colors.white, fontFamily: 'Manrope', fontSize: 22, fontWeight: FontWeight.w900)),
            SizedBox(height: 6),
            Text('Your data. Your terms. Even after you\'re gone.', style: TextStyle(color: Colors.white60, fontSize: 13)),
          ])),
        const SizedBox(height: 24),

        _SectionHead('Inactivity Release Trigger'),
        Container(padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Palette.surfaceContainerLowest, borderRadius: BorderRadius.circular(18)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Release after $_inactivityDays days of inactivity', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Palette.onSurface)),
            const SizedBox(height: 4),
            const Text('Your legacy contacts will be notified and given access', style: TextStyle(fontSize: 12, color: Palette.onSurfaceVariant)),
            Slider(value: _inactivityDays.toDouble(), min: 90, max: 730, divisions: 13,
              onChanged: (v) => setState(() => _inactivityDays = v.round()),
              activeColor: Palette.primary, inactiveColor: Palette.outlineVariant),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
              Text('90 days', style: TextStyle(fontSize: 11, color: Palette.outline)),
              Text('2 years', style: TextStyle(fontSize: 11, color: Palette.outline)),
            ]),
          ])),
        const SizedBox(height: 20),

        _SectionHead('Legacy Contacts'),
        ..._contacts.map((ct) => Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: Palette.surfaceContainerLowest, borderRadius: BorderRadius.circular(16)),
          child: Row(children: [
            Container(width: 44, height: 44, decoration: BoxDecoration(gradient: const LinearGradient(colors: [Palette.primary, Color(0xFF3949AB)]), borderRadius: BorderRadius.circular(14)),
              child: Center(child: Text(ct.$1[0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)))),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(ct.$1, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Palette.onSurface)),
              Text(ct.$2, style: const TextStyle(fontSize: 11.5, color: Palette.onSurfaceVariant)),
            ])),
            Icon(ct.$3, color: Palette.outline, size: 20),
          ])),
        ),
        TextButton.icon(icon: const Icon(Icons.add_rounded, size: 18), label: const Text('Add Legacy Contact'),
          onPressed: () {},
          style: TextButton.styleFrom(foregroundColor: Palette.primary)),
        const SizedBox(height: 32),
      ]),
    ),
  );
}

class _SectionHead extends StatelessWidget {
  const _SectionHead(this.t);
  final String t;
  @override Widget build(BuildContext c) => Padding(padding: const EdgeInsets.only(bottom: 10, left: 2),
    child: Text(t, style: TextStyle(fontFamily: 'Manrope', fontSize: 17, fontWeight: FontWeight.w800, color: Palette.onSurface)));
}
