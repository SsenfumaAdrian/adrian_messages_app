// FILE: lib/ui/screens/ai_conflict_resolution_screen.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../components/app_scaffold.dart';

class AiConflictResolutionScreen extends StatefulWidget {
  const AiConflictResolutionScreen({super.key});
  @override
  State<AiConflictResolutionScreen> createState() => _State();
}

class _State extends State<AiConflictResolutionScreen> {
  int _step = 0; // 0=analysis, 1=mediating, 2=resolved

  @override
  Widget build(BuildContext ctx) => AppScaffold(
      title: 'AI Conflict Resolution',
      child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Status pill
            Center(
                child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        color: [
                          Colors.orange,
                          Palette.primary,
                          Palette.success
                        ][_step]
                            .withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(99)),
                    child: Text(
                        [
                          'Analysing Conflict',
                          'AI Mediating',
                          'Resolved'
                        ][_step],
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                            color: [
                              Colors.orange,
                              Palette.primary,
                              Palette.success
                            ][_step])))),
            const SizedBox(height: 20),

            // Conflict summary
            Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Palette.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Palette.primary.withValues(alpha: 0.04),
                          blurRadius: 12)
                    ]),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        const Icon(Icons.balance_outlined,
                            color: Palette.primary, size: 20),
                        const SizedBox(width: 8),
                        Text('Conflict Summary',
                            style: TextStyle(
                                fontFamily: Palette.fontDisplay,
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Palette.primary)),
                      ]),
                      const SizedBox(height: 12),
                      const Text(
                          'A scheduling disagreement was detected between Elena Vance and Marcus Reid regarding the Q4 launch timeline. '
                          'Both parties have expressed strong positions in the last 14 messages. Adrian AI has been requested to mediate.',
                          style: TextStyle(
                              fontSize: 13,
                              color: Palette.onSurface,
                              height: 1.5)),
                      const SizedBox(height: 14),
                      Row(children: [
                        _Party(
                            name: 'Elena Vance',
                            position: 'Launch by Nov 1st',
                            initials: 'EV'),
                        const SizedBox(width: 12),
                        const Icon(Icons.compare_arrows_rounded,
                            color: Palette.outline, size: 22),
                        const SizedBox(width: 12),
                        _Party(
                            name: 'Marcus Reid',
                            position: 'Need until Nov 15th',
                            initials: 'MR'),
                      ]),
                    ])),
            const SizedBox(height: 20),

            // AI suggestions
            Text('AI Suggestions',
                style: TextStyle(
                    fontFamily: Palette.fontDisplay,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Palette.primary)),
            const SizedBox(height: 12),
            ...const [
              (
                Icons.calendar_today_rounded,
                'Compromise: Nov 8th soft launch, Nov 15th full release',
                'Satisfies both timelines with a phased approach'
              ),
              (
                Icons.group_outlined,
                'Schedule a 30-min sync call between both parties',
                'Direct dialogue often resolves timeline conflicts fastest'
              ),
              (
                Icons.task_alt_rounded,
                'Create a shared milestone tracker in the circle',
                'Visibility into progress may ease Marcus\'s concerns'
              ),
            ].map(
              (s) => Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      color: Palette.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            color: Palette.primary.withValues(alpha: 0.04),
                            blurRadius: 8)
                      ]),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                                color: Palette.primary.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(12)),
                            child:
                                Icon(s.$1, color: Palette.primary, size: 20)),
                        const SizedBox(width: 12),
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text(s.$2,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                      color: Palette.onSurface)),
                              const SizedBox(height: 3),
                              Text(s.$3,
                                  style: const TextStyle(
                                      fontSize: 11,
                                      color: Palette.onSurfaceVariant)),
                            ])),
                      ])),
            ),
            const SizedBox(height: 20),

            // Action buttons
            Row(children: [
              Expanded(
                  child: _GradBtn(
                      label: 'Apply Suggestion',
                      onTap: () => setState(
                          () => _step = _step < 2 ? _step + 1 : _step))),
              const SizedBox(width: 12),
              Expanded(
                  child: _OutlineBtn2(label: 'Draft Message', onTap: () {})),
            ]),
            const SizedBox(height: 32),
          ])));
}

class _Party extends StatelessWidget {
  const _Party(
      {required this.name, required this.position, required this.initials});
  final String name, position, initials;
  @override
  Widget build(BuildContext ctx) => Expanded(
      child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Palette.surfaceContainerLow,
              borderRadius: BorderRadius.circular(14)),
          child: Column(children: [
            Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Palette.primary, Color(0xFF3949AB)]),
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                    child: Text(initials,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 12)))),
            const SizedBox(height: 6),
            Text(name,
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: Palette.onSurface),
                textAlign: TextAlign.center),
            Text(position,
                style: const TextStyle(
                    fontSize: 10, color: Palette.onSurfaceVariant),
                textAlign: TextAlign.center),
          ])));
}

class _GradBtn extends StatelessWidget {
  const _GradBtn({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext ctx) => GestureDetector(
      onTap: onTap,
      child: Container(
          height: 50,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Palette.primary, Color(0xFF2C3E9E)]),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                    color: Palette.primary.withValues(alpha: 0.28),
                    blurRadius: 16,
                    offset: Offset(0, 5))
              ]),
          child: Center(
              child: Text(label,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 13)))));
}

class _OutlineBtn2 extends StatelessWidget {
  const _OutlineBtn2({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext ctx) => GestureDetector(
      onTap: onTap,
      child: Container(
          height: 50,
          decoration: BoxDecoration(
              color: Palette.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Palette.outlineVariant)),
          child: Center(
              child: Text(label,
                  style: const TextStyle(
                      color: Palette.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 13)))));
}
