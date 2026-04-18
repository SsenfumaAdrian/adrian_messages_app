// FILE: lib/ui/screens/custom_ai_persona_builder_screen.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../components/app_scaffold.dart';

class CustomAiPersonaBuilderScreen extends StatefulWidget {
  const CustomAiPersonaBuilderScreen({super.key});
  @override State<CustomAiPersonaBuilderScreen> createState() => _State();
}
class _State extends State<CustomAiPersonaBuilderScreen> {
  int _toneIndex = 1;
  int _verbosityIndex = 1;
  bool _proactiveInsights = true;
  bool _meetingSummaries = true;
  final _nameCtrl = TextEditingController(text: 'Adrian');
  static const _tones = ['Formal', 'Balanced', 'Casual'];
  static const _verbosity = ['Concise', 'Default', 'Detailed'];
  static const _personas = [
    (name: 'Executive', desc: 'Formal, decisive, strategic', icon: Icons.business_center_rounded, color: 0xFF1A237E),
    (name: 'Creative', desc: 'Expressive, playful, ideas-first', icon: Icons.palette_rounded, color: 0xFF880E4F),
    (name: 'Technical', desc: 'Precise, logical, data-driven', icon: Icons.code_rounded, color: 0xFF00695C),
    (name: 'Mentor', desc: 'Empathetic, guiding, patient', icon: Icons.school_outlined, color: 0xFFE65100),
  ];
  int _personaIndex = 0;
  @override void dispose() { _nameCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'AI Persona Studio',
      child: SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Persona name
        _SectionLabel('AI Name'),
        Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4), decoration: BoxDecoration(color: Palette.surfaceContainerLowest, borderRadius: BorderRadius.circular(14), border: Border.all(color: Palette.outlineVariant.withValues(alpha: 0.3))),
          child: TextField(controller: _nameCtrl, style: TextStyle(fontFamily: Palette.fontDisplay, fontSize: 15, fontWeight: FontWeight.w700, color: Palette.primary),
            decoration: const InputDecoration(border: InputBorder.none, hintText: 'Name your AI', isDense: true))),
        const SizedBox(height: 20),

        // Persona presets
        _SectionLabel('Personality Preset'),
        GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 2.4,
          children: List.generate(_personas.length, (i) {
            final p = _personas[i];
            final sel = i == _personaIndex;
            return GestureDetector(onTap: () => setState(() => _personaIndex = i),
              child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: sel ? Color(p.color).withValues(alpha: 0.10) : Palette.surfaceContainerLowest, borderRadius: BorderRadius.circular(14), border: Border.all(color: sel ? Color(p.color) : Palette.outlineVariant.withValues(alpha: 0.20), width: sel ? 1.5 : 1)),
                child: Row(children: [
                  Icon(p.icon, size: 20, color: Color(p.color)),
                  const SizedBox(width: 8),
                  Flexible(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                    Text(p.name, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: sel ? Color(p.color) : Palette.onSurface)),
                    Text(p.desc, style: const TextStyle(fontSize: 10, color: Palette.onSurfaceVariant), overflow: TextOverflow.ellipsis),
                  ])),
                ])));
          }),
        ),
        const SizedBox(height: 20),

        // Tone
        _SectionLabel('Communication Tone'),
        _SegmentedPicker(options: _tones, selected: _toneIndex, onSelect: (i) => setState(() => _toneIndex = i)),
        const SizedBox(height: 16),

        // Verbosity
        _SectionLabel('Response Length'),
        _SegmentedPicker(options: _verbosity, selected: _verbosityIndex, onSelect: (i) => setState(() => _verbosityIndex = i)),
        const SizedBox(height: 20),

        // Features
        _SectionLabel('Capabilities'),
        Container(decoration: BoxDecoration(color: Palette.surfaceContainerLowest, borderRadius: BorderRadius.circular(18)), child: Column(children: [
          _FeatureToggle(icon: Icons.lightbulb_outline_rounded, label: 'Proactive Insights', sub: 'Surface relevant context unprompted', value: _proactiveInsights, onChanged: (v) => setState(() => _proactiveInsights = v)),
          Divider(height: 1, indent: 56, endIndent: 16, color: Palette.outlineVariant.withValues(alpha: 0.15)),
          _FeatureToggle(icon: Icons.summarize_outlined, label: 'Meeting Summaries', sub: 'Auto-generate after long threads', value: _meetingSummaries, onChanged: (v) => setState(() => _meetingSummaries = v)),
        ])),
        const SizedBox(height: 24),

        // Preview chat
        _SectionLabel('Preview'),
        Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Palette.surfaceContainerLowest, borderRadius: BorderRadius.circular(18)), child: Column(children: [
          _ChatPreviewBubble(text: 'What\'s my most urgent task today?', isMe: true),
          const SizedBox(height: 8),
          _ChatPreviewBubble(text: 'Based on your calendar and recent threads, your Q4 board deck review at 2 PM takes priority. I\'ve pre-summarised the three open comments for you.', isMe: false),
        ])),
        const SizedBox(height: 24),

        // Save button
        GestureDetector(onTap: () {}, child: Container(
          width: double.infinity, height: 54,
          decoration: BoxDecoration(gradient: const LinearGradient(colors: [Palette.primary, Color(0xFF3949AB)]), borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Palette.primary.withValues(alpha: 0.30), blurRadius: 20, offset: const Offset(0, 6))]),
          child: const Center(child: Text('Save Persona', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15))),
        )),
        const SizedBox(height: 24),
      ])),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;
  @override Widget build(BuildContext context) => Padding(padding: const EdgeInsets.only(bottom: 10),
    child: Text(text.toUpperCase(), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Palette.outline, letterSpacing: 1.2)));
}

class _SegmentedPicker extends StatelessWidget {
  const _SegmentedPicker({required this.options, required this.selected, required this.onSelect});
  final List<String> options;
  final int selected;
  final ValueChanged<int> onSelect;
  @override Widget build(BuildContext context) => Row(children: List.generate(options.length, (i) {
    final active = i == selected;
    return Expanded(child: GestureDetector(onTap: () => onSelect(i), child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: EdgeInsets.only(right: i < options.length - 1 ? 6 : 0),
      decoration: BoxDecoration(color: active ? Palette.primary : Palette.surfaceContainerHigh, borderRadius: BorderRadius.circular(10)),
      child: Center(child: Text(options[i], style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: active ? Colors.white : Palette.onSurfaceVariant))),
    )));
  }));
}

class _FeatureToggle extends StatelessWidget {
  const _FeatureToggle({required this.icon, required this.label, required this.sub, required this.value, required this.onChanged});
  final IconData icon;
  final String label, sub;
  final bool value;
  final ValueChanged<bool> onChanged;
  @override Widget build(BuildContext context) => ListTile(
    contentPadding: const EdgeInsets.fromLTRB(16, 4, 10, 4),
    leading: Container(width: 36, height: 36, decoration: BoxDecoration(color: Palette.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(10)), child: Icon(icon, size: 18, color: Palette.primary)),
    title: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Palette.onSurface)),
    subtitle: Text(sub, style: const TextStyle(fontSize: 11.5, color: Palette.onSurfaceVariant)),
    trailing: Switch.adaptive(value: value, onChanged: onChanged, activeThumbColor: Palette.primary),
  );
}

class _ChatPreviewBubble extends StatelessWidget {
  const _ChatPreviewBubble({required this.text, required this.isMe});
  final String text;
  final bool isMe;
  @override Widget build(BuildContext context) => Align(alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.78),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(color: isMe ? Palette.primary : Palette.surfaceContainerHigh, borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(16), topRight: const Radius.circular(16),
        bottomLeft: Radius.circular(isMe ? 16 : 4), bottomRight: Radius.circular(isMe ? 4 : 16))),
      child: Text(text, style: TextStyle(fontSize: 13, color: isMe ? Colors.white : Palette.onSurface, height: 1.4))));
}
