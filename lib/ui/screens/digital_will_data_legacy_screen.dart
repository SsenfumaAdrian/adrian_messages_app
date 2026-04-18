// FILE: lib/ui/screens/digital_will_data_legacy_screen.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../components/app_scaffold.dart';

class DigitalWillDataLegacyScreen extends StatefulWidget {
  const DigitalWillDataLegacyScreen({super.key});
  @override State<DigitalWillDataLegacyScreen> createState() => _State();
}
class _State extends State<DigitalWillDataLegacyScreen> {
  bool _legacyEnabled = true;
  static const _trustees = [
    (name: 'Elena Vance', role: 'Primary Trustee', email: 'e.vance@adrian.io', icon: 0xFF7B1FA2),
    (name: 'Marcus Reid', role: 'Secondary Trustee', email: 'm.reid@adrian.io', icon: 0xFFB71C1C),
  ];
  @override
  Widget build(BuildContext context) => AppScaffold(
    title: 'Digital Legacy Vault',
    child: SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Hero
      Container(padding: const EdgeInsets.all(22), decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF0D1A4A), Color(0xFF1A237E)]), borderRadius: BorderRadius.circular(22), boxShadow: [BoxShadow(color: Palette.primary.withValues(alpha: 0.30), blurRadius: 24, offset: const Offset(0, 8))]),
        child: Column(children: [
          const Icon(Icons.auto_awesome_rounded, color: Palette.accentCyan, size: 36),
          const SizedBox(height: 12),
          Text('Your digital estate is protected', textAlign: TextAlign.center, style: const TextStyle(fontFamily: 'Manrope', fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white)),
          const SizedBox(height: 8),
          const Text('Trusted contacts will receive your designated messages and vault access after a 90-day inactivity window.', style: TextStyle(color: Colors.white60, fontSize: 13, height: 1.5)),
          const SizedBox(height: 16),
          Row(children: [
            const Text('Legacy Mode', style: TextStyle(color: Colors.white70, fontSize: 13)),
            const Spacer(),
            Switch.adaptive(value: _legacyEnabled, onChanged: (v) => setState(() => _legacyEnabled = v), activeThumbColor: Palette.accentCyan),
          ]),
        ])),
      const SizedBox(height: 24),
      const Text('TRUSTED CONTACTS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Palette.outline, letterSpacing: 1.2)),
      const SizedBox(height: 10),
      ..._trustees.map((t) => Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Palette.surfaceContainerLowest, borderRadius: BorderRadius.circular(16)),
        child: Row(children: [
          Container(width: 44, height: 44, decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(t.icon), Color(t.icon).withValues(alpha: 0.6)]), shape: BoxShape.circle),
            child: Center(child: Text(t.name[0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)))),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(t.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Palette.onSurface)),
            Text(t.role, style: const TextStyle(fontSize: 12, color: Palette.primary, fontWeight: FontWeight.w600)),
            Text(t.email, style: const TextStyle(fontSize: 11, color: Palette.onSurfaceVariant)),
          ])),
          const Icon(Icons.edit_outlined, size: 18, color: Palette.outline),
        ]))),
      const SizedBox(height: 8),
      GestureDetector(onTap: () {}, child: Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: Palette.surfaceContainerLowest, borderRadius: BorderRadius.circular(14), border: Border.all(color: Palette.outlineVariant.withValues(alpha: 0.30))),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.add_rounded, color: Palette.primary, size: 18), const SizedBox(width: 8), const Text('Add Trusted Contact', style: TextStyle(color: Palette.primary, fontWeight: FontWeight.w600, fontSize: 14))]))),
      const SizedBox(height: 24),
      const Text('VAULT INHERITANCE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Palette.outline, letterSpacing: 1.2)),
      const SizedBox(height: 10),
      Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Palette.surfaceContainerLowest, borderRadius: BorderRadius.circular(16)), child: Column(children: [
        _LegacyOption(icon: Icons.chat_bubble_outline_rounded, label: 'Personal Messages', sub: 'Share all message history'),
        Divider(height: 1, indent: 52, color: Palette.outlineVariant.withValues(alpha: 0.15)),
        _LegacyOption(icon: Icons.lock_outline_rounded, label: 'Vault Contents', sub: 'Transfer encrypted files'),
        Divider(height: 1, indent: 52, color: Palette.outlineVariant.withValues(alpha: 0.15)),
        _LegacyOption(icon: Icons.auto_awesome_outlined, label: 'AI Insights Archive', sub: 'Preserve AI conversation history'),
      ])),
      const SizedBox(height: 24),
    ])),
  );
}

class _LegacyOption extends StatelessWidget {
  const _LegacyOption({required this.icon, required this.label, required this.sub});
  final IconData icon;
  final String label, sub;
  @override Widget build(BuildContext context) => ListTile(contentPadding: EdgeInsets.zero,
    leading: Container(width: 36, height: 36, decoration: BoxDecoration(color: Palette.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(10)), child: Icon(icon, size: 18, color: Palette.primary)),
    title: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Palette.onSurface)),
    subtitle: Text(sub, style: const TextStyle(fontSize: 11.5, color: Palette.onSurfaceVariant)),
    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 13, color: Palette.outline));
}