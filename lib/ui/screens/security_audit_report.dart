// FILE: lib/ui/screens/security_audit_report.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../components/app_scaffold.dart';

class SecurityAuditReport extends StatelessWidget {
  const SecurityAuditReport({super.key});

  static const _checks = [
    ('End-to-End Encryption', 'AES-256 active on all conversations', true, Icons.lock_rounded),
    ('Zero-Knowledge Architecture', 'Server cannot read message content', true, Icons.visibility_off_rounded),
    ('Biometric Vault', 'Hardware-secured key storage enabled', true, Icons.fingerprint_rounded),
    ('2-Factor Authentication', 'TOTP active on this account', true, Icons.verified_user_outlined),
    ('Session Management', '3 active sessions — review recommended', false, Icons.devices_rounded),
    ('Data Residency', 'EU servers · GDPR compliant', true, Icons.public_rounded),
    ('Audit Logging', 'All admin actions logged & tamper-proof', true, Icons.history_rounded),
  ];

  @override Widget build(BuildContext c) => AppScaffold(
    title: 'Security Audit Report',
    actions: [
      Container(margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(gradient: const LinearGradient(colors: [Palette.primary, Color(0xFF3949AB)]), borderRadius: BorderRadius.circular(10)),
        child: const Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.download_rounded, color: Colors.white, size: 16),
          SizedBox(width: 6),
          Text('Export PDF', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
        ])),
    ],
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Score card
        Container(padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(gradient: const LinearGradient(colors: [Palette.primary, Color(0xFF3949AB)]), borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Palette.primary.withValues(alpha: 0.28), blurRadius: 24, offset: const Offset(0, 8))]),
          child: Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Security Audit Q4', style: TextStyle(color: Colors.white60, fontSize: 12, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                const Text('98', style: TextStyle(color: Colors.white, fontSize: 64, fontWeight: FontWeight.w900, height: 1, fontFamily: 'Manrope')),
                const Text('/100', style: TextStyle(color: Colors.white60, fontSize: 20, fontWeight: FontWeight.w700)),
              ]),
              const SizedBox(height: 6),
              Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(color: const Color(0xFF00695C), borderRadius: BorderRadius.circular(99)),
                child: const Text('EXCELLENT SCORE', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 0.8))),
            ]),
            const Spacer(),
            SizedBox(width: 100, height: 100,
              child: Stack(children: [
                CircularProgressIndicator(value: 0.98, strokeWidth: 8, backgroundColor: Colors.white.withValues(alpha: 0.2), valueColor: const AlwaysStoppedAnimation(Colors.white)),
                const Center(child: Icon(Icons.shield_rounded, color: Colors.white, size: 36)),
              ])),
          ])),
        const SizedBox(height: 24),

        // Checks
        Text('Security Checks', style: TextStyle(fontFamily: 'Manrope', fontSize: 17, fontWeight: FontWeight.w800, color: Palette.onSurface)),
        const SizedBox(height: 12),
        ..._checks.map((ch) => Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: Palette.surfaceContainerLowest, borderRadius: BorderRadius.circular(16),
            border: ch.$3 ? null : Border.all(color: const Color(0xFFFFBB33).withValues(alpha: 0.4)),
            boxShadow: [BoxShadow(color: Palette.primary.withValues(alpha: 0.04), blurRadius: 8)]),
          child: Row(children: [
            Container(width: 40, height: 40,
              decoration: BoxDecoration(color: ch.$3 ? const Color(0xFF00695C).withValues(alpha: 0.1) : const Color(0xFFFFBB33).withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)),
              child: Icon(ch.$4, color: ch.$3 ? const Color(0xFF00695C) : const Color(0xFFFF8F00), size: 20)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(ch.$1, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: Palette.onSurface)),
              Text(ch.$2, style: const TextStyle(fontSize: 12, color: Palette.onSurfaceVariant)),
            ])),
            Icon(ch.$3 ? Icons.check_circle_rounded : Icons.warning_amber_rounded,
              color: ch.$3 ? const Color(0xFF00695C) : const Color(0xFFFF8F00), size: 20),
          ]),
        )),
        const SizedBox(height: 16),
        // Last audit info
        Container(padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Palette.primary.withValues(alpha: 0.04), borderRadius: BorderRadius.circular(14)),
          child: const Row(children: [
            Icon(Icons.info_outline_rounded, color: Palette.primary, size: 18),
            SizedBox(width: 10),
            Expanded(child: Text('Last full audit: April 1, 2026 · Next scheduled: July 1, 2026', style: TextStyle(fontSize: 12.5, color: Palette.primary, fontWeight: FontWeight.w600))),
          ])),
        const SizedBox(height: 32),
      ]),
    ),
  );
}
