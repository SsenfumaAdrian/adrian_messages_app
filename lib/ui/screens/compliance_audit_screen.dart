// FILE: lib/ui/screens/compliance_audit_screen.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../components/app_scaffold.dart';

class ComplianceAuditScreen extends StatelessWidget {
  const ComplianceAuditScreen({super.key});

  static const _checks = [
    _Check('GDPR Article 32', 'Encryption at rest and in transit', true,
        'Compliant'),
    _Check('HIPAA Security Rule', 'Access controls and audit logs', true,
        'Compliant'),
    _Check('SOC 2 Type II', 'Annual security audit', true, 'Certified'),
    _Check('ISO 27001', 'Information security management', false, 'In Review'),
    _Check('CCPA Compliance', 'California consumer privacy', true, 'Compliant'),
    _Check(
        'NIS2 Directive', 'Network and information security', false, 'Pending'),
    _Check('PCI DSS Level 1', 'Payment card data handling', true, 'Certified'),
  ];

  static const _timeline = [
    _TLine('Q1 2026', 'ISO 27001 certification audit completed. Report filed.'),
    _TLine('Q4 2025', 'SOC 2 Type II report received. Zero exceptions noted.'),
    _TLine(
        'Q3 2025', 'GDPR data mapping exercise refreshed across all services.'),
    _TLine('Q2 2025',
        'NIS2 readiness gap assessment initiated with external counsel.'),
    _TLine('Q1 2025', 'HIPAA BAA signed with all third-party sub-processors.'),
  ];

  @override
  Widget build(BuildContext ctx) => AppScaffold(
      title: 'Compliance Audit',
      actions: [
        TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.download_outlined, size: 16),
            label: const Text('Export',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
            style: TextButton.styleFrom(
                foregroundColor: Palette.onSurfaceVariant)),
      ],
      child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Summary cards
            Row(children: [
              Expanded(
                  child: _SummaryCard(
                      label: 'Compliant', count: 5, color: Palette.success)),
              const SizedBox(width: 10),
              Expanded(
                  child: _SummaryCard(
                      label: 'In Review', count: 1, color: Colors.orange)),
              const SizedBox(width: 10),
              Expanded(
                  child: _SummaryCard(
                      label: 'Pending', count: 1, color: Palette.outline)),
            ]),
            const SizedBox(height: 24),

            // Compliance checks
            _sectionHead('Regulatory Framework'),
            const SizedBox(height: 12),
            ..._checks.map((c) => Container(
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
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                          color: (c.ok ? Palette.success : Colors.orange)
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(13)),
                      child: Icon(
                          c.ok
                              ? Icons.verified_rounded
                              : Icons.pending_outlined,
                          color: c.ok ? Palette.success : Colors.orange,
                          size: 22)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(c.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                color: Palette.onSurface)),
                        Text(c.detail,
                            style: const TextStyle(
                                fontSize: 11, color: Palette.onSurfaceVariant)),
                      ])),
                  Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          color: (c.ok ? Palette.success : Colors.orange)
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(99)),
                      child: Text(c.status,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: c.ok ? Palette.success : Colors.orange))),
                ]))),
            const SizedBox(height: 24),

            // Timeline
            _sectionHead('Audit Timeline'),
            const SizedBox(height: 16),
            ..._timeline.asMap().entries.map((e) =>
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Column(children: [
                    Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                            color: Palette.primary, shape: BoxShape.circle)),
                    if (e.key < _timeline.length - 1)
                      Container(
                          width: 2,
                          height: 56,
                          color: Palette.outlineVariant.withValues(alpha: 0.4)),
                  ]),
                  const SizedBox(width: 14),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(e.value.period,
                                    style: TextStyle(
                                        fontFamily: Palette.fontDisplay,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: Palette.primary)),
                                const SizedBox(height: 4),
                                Text(e.value.event,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color: Palette.onSurface,
                                        height: 1.4)),
                              ]))),
                ])),
            const SizedBox(height: 32),
          ])));
}

class _Check {
  const _Check(this.name, this.detail, this.ok, this.status);
  final String name, detail, status;
  final bool ok;
}

class _TLine {
  const _TLine(this.period, this.event);
  final String period, event;
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard(
      {required this.label, required this.count, required this.color});
  final String label;
  final int count;
  final Color color;
  @override
  Widget build(BuildContext ctx) => Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: color.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(16)),
      child: Column(children: [
        Text('$count',
            style: TextStyle(
                fontFamily: Palette.fontDisplay,
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: color)),
        Text(label,
            style: TextStyle(
                fontSize: 11, fontWeight: FontWeight.w700, color: color)),
      ]));
}

Widget _sectionHead(String t) => Text(t,
    style: TextStyle(
        fontFamily: Palette.fontDisplay,
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: Palette.primary));
