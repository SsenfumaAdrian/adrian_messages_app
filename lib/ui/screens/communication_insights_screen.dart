// FILE: lib/ui/screens/communication_insights_screen.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../../core/navigation/liquid_router.dart';
import '../components/app_shell.dart';

class CommunicationInsightsScreen extends StatelessWidget {
  const CommunicationInsightsScreen({super.key});
  @override
  Widget build(BuildContext ctx) => AppShell(
      activeRoute: LiquidRouter.insights,
      title: 'Communication Intelligence',
      child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // KPI row
            const Row(children: [
              Expanded(
                  child: _KpiCard(
                      label: 'Msgs Sent',
                      value: '1,248',
                      delta: '+12%',
                      up: true)),
              SizedBox(width: 12),
              Expanded(
                  child: _KpiCard(
                      label: 'Avg Response',
                      value: '4.2 min',
                      delta: '-8%',
                      up: true)),
              SizedBox(width: 12),
              Expanded(
                  child: _KpiCard(
                      label: 'Active Circles',
                      value: '14',
                      delta: '+2',
                      up: true)),
            ]),
            const SizedBox(height: 24),

            // Activity chart placeholder
            Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Palette.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Palette.primary.withOpacity(0.04),
                          blurRadius: 12,
                          offset: const Offset(0, 3))
                    ]),
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Weekly Activity',
                              style: TextStyle(
                                  fontFamily: Palette.fontDisplay,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Palette.primary)),
                          const SizedBox(height: 16),
                          Expanded(
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    0.4,
                                    0.75,
                                    0.55,
                                    0.9,
                                    0.65,
                                    0.85,
                                    0.5
                                  ]
                                      .asMap()
                                      .entries
                                      .map((e) => Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                AnimatedContainer(
                                                    duration: Duration(
                                                        milliseconds:
                                                            400 + e.key * 80),
                                                    width: 28,
                                                    height: 100 * e.value,
                                                    decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter,
                                                            colors: [
                                                              Palette.primary,
                                                              Palette.primary
                                                                  .withOpacity(
                                                                      0.4)
                                                            ]),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8))),
                                                const SizedBox(height: 4),
                                                Text(
                                                    [
                                                      'M',
                                                      'T',
                                                      'W',
                                                      'T',
                                                      'F',
                                                      'S',
                                                      'S'
                                                    ][e.key],
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        color:
                                                            Palette.outline)),
                                              ]))
                                      .toList())),
                        ]))),
            const SizedBox(height: 20),

            const Text('Top Contacts',
                style: TextStyle(
                    fontFamily: Palette.fontDisplay,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Palette.primary)),
            const SizedBox(height: 12),
            ...[
              'Elena Vance',
              'Marcus Reid',
              'Sarah Miller'
            ].asMap().entries.map((e) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                    color: Palette.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(16)),
                child: Row(children: [
                  Text('${e.key + 1}',
                      style: const TextStyle(
                          fontFamily: Palette.fontDisplay,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Palette.primary,
                          width: 28)),
                  Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [Palette.primary, Color(0xFF3949AB)]),
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                          child: Text(e.value[0],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800)))),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Text(e.value,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: Palette.onSurface))),
                  Container(
                      width: 80,
                      height: 6,
                      decoration: BoxDecoration(
                          color: Palette.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(3)),
                      child: FractionallySizedBox(
                          widthFactor: [0.9, 0.72, 0.55][e.key],
                          alignment: Alignment.centerLeft,
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Palette.primary,
                                  borderRadius: BorderRadius.circular(3))))),
                ]))),
          ])));
}

class _KpiCard extends StatelessWidget {
  const _KpiCard(
      {required this.label,
      required this.value,
      required this.delta,
      required this.up});
  final String label, value, delta;
  final bool up;
  @override
  Widget build(BuildContext ctx) => Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: Palette.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
                color: Palette.primary.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 2))
          ]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label,
            style: const TextStyle(
                fontSize: 10,
                color: Palette.onSurfaceVariant,
                fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
                fontFamily: Palette.fontDisplay,
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Palette.onSurface)),
        const SizedBox(height: 4),
        Row(children: [
          Icon(up ? Icons.trending_up_rounded : Icons.trending_down_rounded,
              size: 12, color: up ? Palette.success : Palette.error),
          const SizedBox(width: 3),
          Text(delta,
              style: TextStyle(
                  fontSize: 10,
                  color: up ? Palette.success : Palette.error,
                  fontWeight: FontWeight.w700))
        ]),
      ]));
}
