// FILE: lib/ui/screens/system_health_screen.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../components/app_scaffold.dart';

class SystemHealthScreen extends StatelessWidget {
  const SystemHealthScreen({super.key});

  static const _services = [
    _Service('Message Delivery', 99.98, true, '12 ms avg latency'),
    _Service('Encryption Layer', 100.0, true, 'All keys valid'),
    _Service('Vault Storage', 99.91, true, '1.2 TB used / 10 TB'),
    _Service('Push Notifications', 98.40, false, '2 degraded regions'),
    _Service('AI Assistant', 99.80, true, 'All models online'),
    _Service('Media CDN', 99.99, true, '34 edge nodes active'),
  ];

  @override
  Widget build(BuildContext ctx) => AppScaffold(
      title: 'System Health',
      child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Overall status
            Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Palette.success.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(color: Palette.success.withValues(alpha: 0.2))),
                child: Row(children: [
                  Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                          color: Palette.success.withValues(alpha: 0.12),
                          shape: BoxShape.circle),
                      child: Icon(Icons.check_circle_outline_rounded,
                          color: Palette.success, size: 28)),
                  const SizedBox(width: 14),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text('All Systems Operational',
                            style: TextStyle(
                                fontFamily: Palette.fontDisplay,
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                color: Palette.onSurface)),
                        const Text(
                            '1 minor degradation · Last checked 30 seconds ago',
                            style: TextStyle(
                                color: Palette.onSurfaceVariant, fontSize: 12)),
                      ])),
                ])),
            const SizedBox(height: 24),

            // Uptime row
            Row(children: [
              Expanded(
                  child: _UptimeCard(
                      label: 'Overall Uptime',
                      value: '99.97%',
                      period: 'Last 90 days')),
              const SizedBox(width: 12),
              Expanded(
                  child: _UptimeCard(
                      label: 'Incidents', value: '2', period: 'Last 30 days')),
              const SizedBox(width: 12),
              Expanded(
                  child: _UptimeCard(
                      label: 'Avg Response', value: '18 ms', period: 'Global')),
            ]),
            const SizedBox(height: 24),

            // Services list
            _sectionHead('Service Status'),
            const SizedBox(height: 12),
            ..._services.map(
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
                  child: Row(children: [
                    Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                s.healthy ? Palette.success : Colors.orange)),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text(s.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  color: Palette.onSurface)),
                          Text(s.detail,
                              style: const TextStyle(
                                  fontSize: 11,
                                  color: Palette.onSurfaceVariant)),
                        ])),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('${s.uptime}%',
                              style: TextStyle(
                                  fontFamily: Palette.fontDisplay,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: s.uptime > 99.9
                                      ? Palette.success
                                      : Colors.orange)),
                          const Text('uptime',
                              style: TextStyle(
                                  fontSize: 9, color: Palette.outline)),
                        ]),
                  ])),
            ),
            const SizedBox(height: 24),

            // Incident timeline
            _sectionHead('Recent Incidents'),
            const SizedBox(height: 12),
            ...[
              (
                'Push Notification Delay',
                'Resolved in 12 min',
                '2 days ago',
                false
              ),
              ('CDN Cache Miss Spike', 'Auto-resolved', '9 days ago', false),
              (
                'Scheduled Maintenance',
                'Completed on time',
                '14 days ago',
                true
              ),
            ].map(
              (inc) => Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      color: Palette.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(16)),
                  child: Row(children: [
                    Icon(
                        inc.$4
                            ? Icons.build_circle_outlined
                            : Icons.warning_amber_rounded,
                        color: inc.$4 ? Palette.outline : Colors.orange,
                        size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text(inc.$1,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  color: Palette.onSurface)),
                          Text(inc.$2,
                              style: const TextStyle(
                                  fontSize: 11,
                                  color: Palette.onSurfaceVariant)),
                        ])),
                    Text(inc.$3,
                        style: const TextStyle(
                            fontSize: 10,
                            color: Palette.outline,
                            fontWeight: FontWeight.w600)),
                  ])),
            ),
            const SizedBox(height: 32),
          ])));
}

class _Service {
  const _Service(this.name, this.uptime, this.healthy, this.detail);
  final String name, detail;
  final double uptime;
  final bool healthy;
}

class _UptimeCard extends StatelessWidget {
  const _UptimeCard(
      {required this.label, required this.value, required this.period});
  final String label, value, period;
  @override
  Widget build(BuildContext ctx) => Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: Palette.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Palette.primary.withValues(alpha: 0.04), blurRadius: 8)
          ]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(value,
            style: TextStyle(
                fontFamily: Palette.fontDisplay,
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Palette.onSurface)),
        Text(label,
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Palette.onSurfaceVariant)),
        Text(period,
            style: const TextStyle(fontSize: 10, color: Palette.outline)),
      ]));
}

Widget _sectionHead(String t) => Text(t,
    style: TextStyle(
        fontFamily: Palette.fontDisplay,
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: Palette.primary));
