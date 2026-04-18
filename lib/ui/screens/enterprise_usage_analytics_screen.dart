// FILE: lib/ui/screens/enterprise_usage_analytics_screen.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../components/app_scaffold.dart';

class EnterpriseUsageAnalyticsScreen extends StatelessWidget {
  const EnterpriseUsageAnalyticsScreen({super.key});
  @override
  Widget build(BuildContext context) => AppScaffold(
    title: 'Usage Analytics',
    child: SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // KPI grid
      GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.6, children: const [
        _KpiCard(value: '14,802', label: 'Total Messages', delta: '+12%', up: true, accent: true),
        _KpiCard(value: '847', label: 'Active Users', delta: '+5%', up: true, accent: false),
        _KpiCard(value: '99.98%', label: 'Uptime SLA', delta: '0%', up: true, accent: false),
        _KpiCard(value: '2.4 TB', label: 'Data Stored', delta: '+8%', up: true, accent: false),
      ]),
      const SizedBox(height: 24),
      const Text('TOP CIRCLES BY ACTIVITY', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Palette.outline, letterSpacing: 1.2)),
      const SizedBox(height: 10),
      ...const [
        _CircleStat(name: 'Project Alpha', msgs: '2,841 messages', pct: 0.92, color: 0xFF00695C),
        _CircleStat(name: 'Leadership Circle', msgs: '1,203 messages', pct: 0.65, color: 0xFF1A237E),
        _CircleStat(name: 'Design Collective', msgs: '987 messages', pct: 0.52, color: 0xFF880E4F),
        _CircleStat(name: 'Global Ops', msgs: '741 messages', pct: 0.38, color: 0xFFE65100),
      ].map((c) => Padding(padding: const EdgeInsets.only(bottom: 14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(c.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Palette.onSurface)),
          const Spacer(),
          Text(c.msgs, style: const TextStyle(fontSize: 11.5, color: Palette.onSurfaceVariant)),
        ]),
        const SizedBox(height: 6),
        ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: c.pct, backgroundColor: Palette.surfaceContainerHigh, valueColor: AlwaysStoppedAnimation<Color>(Color(c.color)), minHeight: 6)),
      ]))).toList(),
    ])),
  );
}

class _KpiCard extends StatelessWidget {
  const _KpiCard({required this.value, required this.label, required this.delta, required this.up, required this.accent});
  final String value, label, delta;
  final bool up, accent;
  @override Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(
    gradient: accent ? const LinearGradient(colors: [Palette.primary, Color(0xFF3949AB)]) : null,
    color: accent ? null : Palette.surfaceContainerLowest,
    borderRadius: BorderRadius.circular(18), boxShadow: [BoxShadow(color: Palette.primary.withValues(alpha: accent ? 0.28 : 0.04), blurRadius: 14, offset: const Offset(0, 4))]),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(value, style: TextStyle(fontFamily: Palette.fontDisplay, fontSize: 22, fontWeight: FontWeight.w900, color: accent ? Colors.white : Palette.onSurface)),
      Text(label, style: TextStyle(fontSize: 11.5, color: accent ? Colors.white60 : Palette.onSurfaceVariant)),
      Row(children: [Icon(up ? Icons.trending_up_rounded : Icons.trending_down_rounded, size: 13, color: up ? Palette.accentCyan : Palette.error), const SizedBox(width: 3), Text(delta, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: up ? Palette.accentCyan : Palette.error))]),
    ]));
}

class _CircleStat {
  const _CircleStat({required this.name, required this.msgs, required this.pct, required this.color});
  final String name, msgs;
  final double pct;
  final int color;
}
