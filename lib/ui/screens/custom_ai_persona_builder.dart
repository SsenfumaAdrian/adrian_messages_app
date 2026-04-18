// FILE: lib/ui/screens/custom_ai_persona_builder.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../components/app_scaffold.dart';

class CustomAiPersonaBuilder extends StatefulWidget {
  const CustomAiPersonaBuilder({super.key});
  @override State<CustomAiPersonaBuilder> createState() => _S();
}
class _S extends State<CustomAiPersonaBuilder> {
  int _tone = 1; // 0=formal, 1=balanced, 2=casual
  final _nameCtrl = TextEditingController(text: 'Adrian');
  double _verbosity = 0.5;
  final _skills = <String>{'Strategy', 'Technical', 'Creative'};
  static const _tones = ['Formal', 'Balanced', 'Casual'];
  static const _allSkills = ['Strategy', 'Technical', 'Creative', 'Analytics', 'Legal', 'Finance', 'Research', 'Design'];

  @override void dispose() { _nameCtrl.dispose(); super.dispose(); }

  @override Widget build(BuildContext c) => AppScaffold(
    title: 'AI Persona Studio',
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Header card
        Container(padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(gradient: const LinearGradient(colors: [Palette.primary, Color(0xFF3949AB)]), borderRadius: BorderRadius.circular(20)),
          child: Row(children: [
            ClipRRect(borderRadius: BorderRadius.circular(16),
              child: Container(width: 60, height: 60, color: Colors.white.withValues(alpha: 0.15),
                child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 32))),
            const SizedBox(width: 16),
            const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Persona Configuration', style: TextStyle(color: Colors.white60, fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
              SizedBox(height: 4),
              Text('AI Persona Studio', style: TextStyle(color: Colors.white, fontFamily: 'Manrope', fontSize: 20, fontWeight: FontWeight.w900)),
              Text('Customise how Adrian communicates for you', style: TextStyle(color: Colors.white60, fontSize: 12)),
            ])),
          ])),
        const SizedBox(height: 24),

        _SectionHead('Identity Core'),
        _Card(child: Column(children: [
          _LabeledField('Persona Name', _nameCtrl, 'e.g. Adrian'),
          const SizedBox(height: 12),
          const _LabelRow(label: 'Communication Tone'),
          const SizedBox(height: 8),
          Row(children: List.generate(_tones.length, (i) => Expanded(
            child: GestureDetector(onTap: () => setState(() => _tone = i),
              child: AnimatedContainer(duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.only(right: i < 2 ? 8 : 0),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(color: _tone==i ? Palette.primary : Palette.surfaceContainerHigh, borderRadius: BorderRadius.circular(10)),
                child: Center(child: Text(_tones[i], style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: _tone==i ? Colors.white : Palette.onSurfaceVariant))),
              )),
          ))),
          const SizedBox(height: 16),
          const _LabelRow(label: 'Response Verbosity'),
          Slider(value: _verbosity, onChanged: (v) => setState(() => _verbosity = v), activeColor: Palette.primary, inactiveColor: Palette.outlineVariant),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
            Text('Concise', style: TextStyle(fontSize: 11, color: Palette.outline)),
            Text('Detailed', style: TextStyle(fontSize: 11, color: Palette.outline)),
          ]),
        ])),
        const SizedBox(height: 20),

        _SectionHead('Specialized Knowledge'),
        _Card(child: Wrap(spacing: 8, runSpacing: 8,
          children: _allSkills.map((s) {
            final on = _skills.contains(s);
            return GestureDetector(
              onTap: () => setState(() => on ? _skills.remove(s) : _skills.add(s)),
              child: AnimatedContainer(duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(color: on ? Palette.primary : Palette.surfaceContainerHigh, borderRadius: BorderRadius.circular(99)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  if (on) const Padding(padding: EdgeInsets.only(right: 5), child: Icon(Icons.check_circle_rounded, color: Colors.white, size: 14)),
                  Text(s, style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: on ? Colors.white : Palette.onSurfaceVariant)),
                ])),
            );
          }).toList())),
        const SizedBox(height: 24),

        SizedBox(width: double.infinity, height: 54,
          child: DecoratedBox(
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [Palette.primary, Color(0xFF2C3E9E)]), borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Palette.primary.withValues(alpha: 0.28), blurRadius: 20, offset: const Offset(0, 6))]),
            child: TextButton(onPressed: () {},
              style: TextButton.styleFrom(foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
              child: const Text('Save Persona Configuration', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15))),
          )),
        const SizedBox(height: 32),
      ]),
    ),
  );
}

class _SectionHead extends StatelessWidget {
  const _SectionHead(this.t);
  final String t;
  @override Widget build(BuildContext c) => Padding(padding: const EdgeInsets.only(bottom: 10, left: 4),
    child: Text(t, style: TextStyle(fontFamily: 'Manrope', fontSize: 17, fontWeight: FontWeight.w800, color: Palette.onSurface)));
}
class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;
  @override Widget build(BuildContext c) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: Palette.surfaceContainerLowest, borderRadius: BorderRadius.circular(18),
      boxShadow: [BoxShadow(color: Palette.primary.withValues(alpha: 0.04), blurRadius: 10)]),
    child: child);
}
class _LabelRow extends StatelessWidget {
  const _LabelRow({required this.label});
  final String label;
  @override Widget build(BuildContext c) => Text(label, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: Palette.onSurfaceVariant, letterSpacing: 0.2));
}
class _LabeledField extends StatelessWidget {
  const _LabeledField(this.label, this.ctrl, this.hint);
  final String label, hint;
  final TextEditingController ctrl;
  @override Widget build(BuildContext c) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    _LabelRow(label: label),
    const SizedBox(height: 6),
    TextField(controller: ctrl, style: const TextStyle(fontSize: 14, color: Palette.onSurface),
      decoration: InputDecoration(hintText: hint, hintStyle: const TextStyle(color: Palette.outline),
        filled: true, fillColor: Palette.surfaceContainerLow,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none))),
  ]);
}
