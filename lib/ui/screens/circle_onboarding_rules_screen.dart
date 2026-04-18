// FILE: lib/ui/screens/circle_onboarding_rules_screen.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../components/app_scaffold.dart';

class CircleOnboardingRulesScreen extends StatefulWidget {
  const CircleOnboardingRulesScreen({super.key});
  @override State<CircleOnboardingRulesScreen> createState() => _State();
}
class _State extends State<CircleOnboardingRulesScreen> {
  int _step = 0;
  static const _steps = ['Welcome', 'Guidelines', 'Roles', 'Confirm'];
  // ignore: prefer_const_declarations
  static final List<({IconData icon, String rule})> _rules = [
    (icon: Icons.handshake_outlined, rule: 'Respect and professionalism at all times'),
    (icon: Icons.lock_outline_rounded, rule: "What's shared here, stays here"),
    (icon: Icons.flag_outlined, rule: 'Stay on-topic and add value to discussions'),
    (icon: Icons.auto_awesome_outlined, rule: 'AI summaries are shared unless opted out'),
  ];
  @override
  Widget build(BuildContext context) => AppScaffold(
    title: 'Circle Onboarding',
    child: Column(children: [
      // Progress bar
      Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Row(children: List.generate(_steps.length, (i) => Expanded(child: Row(children: [
          Expanded(child: AnimatedContainer(duration: const Duration(milliseconds: 300),
            height: 4, decoration: BoxDecoration(color: i <= _step ? Palette.primary : Palette.surfaceContainerHigh, borderRadius: BorderRadius.circular(2)))),
          if (i < _steps.length - 1) const SizedBox(width: 4),
        ])))),
      ),
      Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 24), child: Column(children: [
        Icon(_step == 0 ? Icons.groups_rounded : _step == 1 ? Icons.rule_rounded : _step == 2 ? Icons.people_outline_rounded : Icons.check_circle_rounded, size: 52, color: Palette.primary),
        const SizedBox(height: 16),
        Text(_steps[_step], style: TextStyle(fontFamily: Palette.fontDisplay, fontSize: 28, fontWeight: FontWeight.w900, color: Palette.onSurface)),
        const SizedBox(height: 24),
        if (_step == 1) ..._rules.map((r) => Padding(padding: const EdgeInsets.only(bottom: 12), child: Row(children: [
          Container(width: 38, height: 38, decoration: BoxDecoration(color: Palette.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(10)), child: Icon(r.icon, size: 18, color: Palette.primary)),
          const SizedBox(width: 12),
          Expanded(child: Text(r.rule, style: const TextStyle(fontSize: 14, color: Palette.onSurface))),
        ]))).toList(),
        if (_step != 1) Text(_step == 0 ? 'Welcome to Project Alpha — an encrypted space for the core team.' : _step == 2 ? 'Members start as Contributors. Admins may upgrade your role.' : "placeholder",
          style: const TextStyle(fontSize: 15, color: Palette.onSurfaceVariant, height: 1.6), textAlign: TextAlign.center),
      ]))),
      Padding(padding: const EdgeInsets.fromLTRB(24, 0, 24, 32), child: Row(children: [
        if (_step > 0) Expanded(child: GestureDetector(onTap: () => setState(() => _step--), child: Container(height: 50, decoration: BoxDecoration(color: Palette.surfaceContainerHigh, borderRadius: BorderRadius.circular(14)), child: const Center(child: Text('Back', style: TextStyle(color: Palette.onSurface, fontWeight: FontWeight.w600, fontSize: 14)))))),
        if (_step > 0) const SizedBox(width: 12),
        Expanded(flex: 2, child: GestureDetector(
          onTap: () { if (_step < 3) { setState(() => _step++); } else { Navigator.pop(context); } },
          child: Container(height: 50, decoration: BoxDecoration(gradient: const LinearGradient(colors: [Palette.primary, Color(0xFF3949AB)]), borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Palette.primary.withValues(alpha: 0.28), blurRadius: 16, offset: const Offset(0, 4))]),
            child: Center(child: Text(_step == 3 ? 'Join Circle 🚀' : 'Continue', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14)))))),
      ])),
    ]),
  );
}

class _StepBody extends StatelessWidget {
  const _StepBody({required this.step});
  final int step;

  static const _texts = [
    'Welcome to Project Alpha — an encrypted space for the core team.',
    '',
    'Members start as Contributors. Admins may upgrade your role.',
    "By joining, you agree to the circle's guidelines.",
  ];

  @override
  Widget build(BuildContext context) => Text(
    _texts[step],
    style: const TextStyle(fontSize: 15, color: Palette.onSurfaceVariant, height: 1.6),
    textAlign: TextAlign.center,
  );
}
