// FILE: lib/ui/screens/security_audit_report_screen.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../components/app_scaffold.dart';

class SecurityAuditReportScreen extends StatelessWidget {
  const SecurityAuditReportScreen({super.key});
  static const _checks = [
    (label: 'End-to-End Encryption', status: 'Pass', score: 100),
    (label: 'Zero-Knowledge Architecture', status: 'Pass', score: 100),
    (label: 'Multi-Factor Authentication', status: 'Pass', score: 95),
    (label: 'Device Trust Score', status: 'Pass', score: 98),
    (label: 'Session Management', status: 'Warning', score: 82),
    (label: 'Data Residency Compliance', status: 'Pass', score: 100),
  ];
  @override
  Widget build(BuildContext context) => AppScaffold(
    title: 'Security Audit Q4',
    child: SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Overall score
      Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(gradient: const LinearGradient(colors: [Palette.primary, Color(0xFF1565C0)]), borderRadius: BorderRadius.circular(22), boxShadow: [BoxShadow(color: Palette.primary.withValues(alpha: 0.30), blurRadius: 24, offset: const Offset(0, 8))]),
        child: Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('OVERALL SECURITY SCORE', style: TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1)),
            const SizedBox(height: 8),
            Text('96/100', style: TextStyle(fontFamily: Palette.fontDisplay, fontSize: 40, fontWeight: FontWeight.w900, color: Colors.white, height: 1)),
            const SizedBox(height: 4),
            const Text('Enterprise Grade — Excellent', style: TextStyle(color: Colors.white70, fontSize: 13)),
          ])),
          CircularProgressIndicator(value: 0.96, strokeWidth: 8, color: Palette.accentCyan, backgroundColor: Colors.white.withValues(alpha: 0.15)),
        ])),
      const SizedBox(height: 24),
      const Text('AUDIT CHECKS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Palette.outline, letterSpacing: 1.2)),
      const SizedBox(height: 10),
      ..._checks.map((c) {
        final isWarn = c.status == 'Warning';
        return Container(margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: Palette.surfaceContainerLowest, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Palette.primary.withValues(alpha: 0.04), blurRadius: 8)]),
          child: Row(children: [
            Icon(isWarn ? Icons.warning_amber_rounded : Icons.check_circle_rounded, size: 22, color: isWarn ? const Color(0xFFE65100) : const Color(0xFF00695C)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(c.label, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: Palette.onSurface)),
              ClipRRect(borderRadius: BorderRadius.circular(3), child: LinearProgressIndicator(value: c.score / 100, backgroundColor: Palette.surfaceContainerHigh, valueColor: AlwaysStoppedAnimation<Color>(isWarn ? const Color(0xFFE65100) : const Color(0xFF00695C)), minHeight: 4)),
            ])),
            const SizedBox(width: 10),
            Text('${c.score}%', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: isWarn ? const Color(0xFFE65100) : const Color(0xFF00695C))),
          ]));
      }).toList(),
      const SizedBox(height: 16),
      GestureDetector(onTap: () {}, child: Container(width: double.infinity, height: 50, decoration: BoxDecoration(color: Palette.surfaceContainerLowest, borderRadius: BorderRadius.circular(14), border: Border.all(color: Palette.outlineVariant.withValues(alpha: 0.30))),
        child: const Center(child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.download_rounded, color: Palette.primary, size: 18), SizedBox(width: 8), Text('Download Full Report (PDF)', style: TextStyle(color: Palette.primary, fontWeight: FontWeight.w600, fontSize: 13))])))),
      const SizedBox(height: 24),
    ])),
  );
}