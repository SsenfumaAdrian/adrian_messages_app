// FILE: lib/ui/screens/automated_workflow_builder_screen.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../components/app_scaffold.dart';

class AutomatedWorkflowBuilderScreen extends StatefulWidget {
  const AutomatedWorkflowBuilderScreen({super.key});
  @override State<AutomatedWorkflowBuilderScreen> createState() => _State();
}
class _State extends State<AutomatedWorkflowBuilderScreen> {
  int _activeWorkflow = 1;

  void selectWorkflow(int i) => setState(() => _activeWorkflow = i);
  static const _templates = [
    (name: 'Emergency Filter', desc: 'Auto-surface urgent messages from VIPs', icon: Icons.priority_high_rounded, color: 0xFFB71C1C, active: false),
    (name: 'Daily Digest', desc: 'Morning summary of all unread threads', icon: Icons.wb_sunny_outlined, color: 0xFFE65100, active: true),
    (name: 'Smart Archive', desc: 'Archive resolved conversations after 7 days', icon: Icons.archive_outlined, color: 0xFF1565C0, active: false),
    (name: 'Adrian AI Assistant', desc: 'Let AI draft replies when you\'re offline', icon: Icons.auto_awesome_outlined, color: 0xFF4A148C, active: false),
  ];
  static const _activeSteps = [
    (step: '1', title: 'Trigger', desc: 'Every day at 8:00 AM', icon: Icons.schedule_rounded),
    (step: '2', title: 'Filter', desc: 'Unread messages from last 24h', icon: Icons.filter_list_rounded),
    (step: '3', title: 'Summarise', desc: 'Adrian AI generates digest', icon: Icons.auto_awesome_rounded),
    (step: '4', title: 'Deliver', desc: 'Send to your inbox + notification', icon: Icons.send_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return AppScaffold(
      title: 'Workflow Builder',
      actions: [
        Container(margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(gradient: const LinearGradient(colors: [Palette.primary, Color(0xFF3949AB)]), borderRadius: BorderRadius.circular(10)),
          child: const Text('+ New Workflow', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700))),
      ],
      child: w >= 800 ? _WideBody(state: this) : _NarrowBody(state: this),
    );
  }
}

class _WideBody extends StatelessWidget {
  const _WideBody({required this.state});
  final _State state;
  @override Widget build(BuildContext context) => Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    SizedBox(width: 280, child: _TemplateList(activeIndex: state._activeWorkflow, onSelect: state.selectWorkflow)),
    Container(width: 1, color: Palette.outlineVariant.withValues(alpha: 0.15)),
    Expanded(child: _WorkflowDetail(state: state)),
  ]);
}
class _NarrowBody extends StatelessWidget {
  const _NarrowBody({required this.state});
  final _State state;
  @override Widget build(BuildContext context) => Column(children: [_TemplateList(activeIndex: state._activeWorkflow, onSelect: state.selectWorkflow, compact: true), _WorkflowDetail(state: state)]);
}

class _TemplateList extends StatelessWidget {
  const _TemplateList({required this.activeIndex, required this.onSelect, this.compact = false});
  final int activeIndex;
  final ValueChanged<int> onSelect;
  final bool compact;
  @override Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Padding(padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text('Core Templates', style: TextStyle(fontFamily: Palette.fontDisplay, fontSize: 13, fontWeight: FontWeight.w800, color: Palette.outline, letterSpacing: 1))),
    ...List.generate(_State._templates.length, (i) {
      final t = _State._templates[i];
      final sel = i == activeIndex;
      return GestureDetector(
        onTap: () => onSelect(i),
        child: Container(margin: const EdgeInsets.fromLTRB(8, 0, 8, 6), padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: sel ? Palette.primary.withValues(alpha: 0.07) : Colors.transparent, borderRadius: BorderRadius.circular(14), border: sel ? Border.all(color: Palette.primary.withValues(alpha: 0.20)) : null),
          child: Row(children: [
            Container(width: 38, height: 38, decoration: BoxDecoration(color: Color(t.color).withValues(alpha: 0.12), borderRadius: BorderRadius.circular(10)),
              child: Icon(t.icon, size: 18, color: Color(t.color))),
            const SizedBox(width: 10),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(t.name, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: sel ? Palette.primary : Palette.onSurface)),
              if (!compact) Text(t.desc, style: const TextStyle(fontSize: 11, color: Palette.onSurfaceVariant), maxLines: 1, overflow: TextOverflow.ellipsis),
            ])),
            if (t.active) Container(width: 8, height: 8, decoration: const BoxDecoration(color: Palette.accentCyan, shape: BoxShape.circle)),
          ]),
        ),
      );
    }),
  ]);
}

class _WorkflowDetail extends StatelessWidget {
  const _WorkflowDetail({required this.state});
  final _State state;
  @override Widget build(BuildContext context) {
    final t = _State._templates[state._activeWorkflow];
    return SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(width: 48, height: 48, decoration: BoxDecoration(color: Color(t.color).withValues(alpha: 0.12), borderRadius: BorderRadius.circular(14)),
          child: Icon(t.icon, size: 22, color: Color(t.color))),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Active Workflow:', style: const TextStyle(fontSize: 11, color: Palette.outline, fontWeight: FontWeight.w700, letterSpacing: 0.5)),
          Text(t.name, style: TextStyle(fontFamily: Palette.fontDisplay, fontSize: 20, fontWeight: FontWeight.w800, color: Palette.onSurface)),
        ])),
        Switch.adaptive(value: state._activeWorkflow == 1, onChanged: (_) {}, activeThumbColor: Palette.primary),
      ]),
      const SizedBox(height: 8),
      Text(t.desc, style: const TextStyle(fontSize: 13, color: Palette.onSurfaceVariant, height: 1.5)),
      const SizedBox(height: 24),
      Text('Workflow Steps', style: TextStyle(fontFamily: Palette.fontDisplay, fontSize: 14, fontWeight: FontWeight.w800, color: Palette.outline, letterSpacing: 1)),
      const SizedBox(height: 12),
      ...List.generate(_State._activeSteps.length, (i) {
        final s = _State._activeSteps[i];
        return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Column(children: [
            Container(width: 36, height: 36, decoration: BoxDecoration(gradient: const LinearGradient(colors: [Palette.primary, Color(0xFF3949AB)]), borderRadius: BorderRadius.circular(10)),
              child: Icon(s.icon, size: 16, color: Colors.white)),
            if (i < _State._activeSteps.length - 1) Container(width: 2, height: 32, color: Palette.primary.withValues(alpha: 0.2)),
          ]),
          const SizedBox(width: 14),
          Expanded(child: Padding(padding: const EdgeInsets.only(bottom: 24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(s.title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Palette.onSurface)),
            Text(s.desc, style: const TextStyle(fontSize: 12, color: Palette.onSurfaceVariant)),
          ]))),
        ]);
      }),
      const SizedBox(height: 16),
      Row(children: [
        Expanded(child: Container(
          height: 50, decoration: BoxDecoration(gradient: const LinearGradient(colors: [Palette.primary, Color(0xFF3949AB)]), borderRadius: BorderRadius.circular(14),
            boxShadow: [BoxShadow(color: Palette.primary.withValues(alpha: 0.28), blurRadius: 16, offset: const Offset(0, 4))]),
          child: const Center(child: Text('Activate Workflow', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14))),
        )),
        const SizedBox(width: 10),
        Container(height: 50, width: 50, decoration: BoxDecoration(color: Palette.surfaceContainerHigh, borderRadius: BorderRadius.circular(14)),
          child: const Icon(Icons.edit_outlined, color: Palette.primary, size: 20)),
      ]),
    ]));
  }
}
