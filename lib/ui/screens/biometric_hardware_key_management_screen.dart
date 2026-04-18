// FILE: lib/ui/screens/biometric_hardware_key_management_screen.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../components/app_scaffold.dart';

class BiometricKeyManagementScreen extends StatelessWidget {
  const BiometricKeyManagementScreen({super.key});
  static const _keys = [
    (name: 'YubiKey 5 NFC', type: 'FIDO2 / WebAuthn', added: 'Mar 12, 2025', icon: Icons.usb_rounded),
    (name: 'MacBook Pro FaceID', type: 'Biometric — Secure Enclave', added: 'Jan 3, 2025', icon: Icons.laptop_mac_rounded),
    (name: 'iPhone 15 Pro Touch ID', type: 'Biometric — iOS Passkey', added: 'Dec 1, 2024', icon: Icons.fingerprint_rounded),
  ];
  @override
  Widget build(BuildContext context) => AppScaffold(
    title: 'Hardware & Biometrics',
    child: SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Security score hero
      Container(width: double.infinity, padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(gradient: const LinearGradient(colors: [Palette.primary, Color(0xFF1565C0)]), borderRadius: BorderRadius.circular(22),
          boxShadow: [BoxShadow(color: Palette.primary.withValues(alpha: 0.30), blurRadius: 24, offset: const Offset(0, 8))]),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text('Security Score', style: TextStyle(color: Colors.white70, fontSize: 13)),
            const SizedBox(width: 8),
            Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Palette.accentCyan.withValues(alpha: 0.20), borderRadius: BorderRadius.circular(99)),
              child: const Text('EXCELLENT', style: TextStyle(color: Palette.accentCyan, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 0.8))),
          ]),
          const SizedBox(height: 8),
          Text('98', style: TextStyle(fontFamily: Palette.fontDisplay, fontSize: 56, fontWeight: FontWeight.w900, color: Colors.white, height: 1)),
          const Text('/ 100', style: TextStyle(color: Colors.white60, fontSize: 14)),
        ])),
      const SizedBox(height: 24),
      Padding(padding: const EdgeInsets.only(bottom: 10), child: Text('REGISTERED HARDWARE KEYS', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Palette.outline, letterSpacing: 1.2))),
      ..._keys.map((k) => Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Palette.surfaceContainerLowest, borderRadius: BorderRadius.circular(18), boxShadow: [BoxShadow(color: Palette.primary.withValues(alpha: 0.04), blurRadius: 10)]),
        child: Row(children: [
          Container(width: 44, height: 44, decoration: BoxDecoration(color: Palette.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(13)), child: Icon(k.icon, size: 22, color: Palette.primary)),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(k.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Palette.onSurface)),
            Text(k.type, style: const TextStyle(fontSize: 12, color: Palette.onSurfaceVariant)),
            Text('Added ${k.added}', style: const TextStyle(fontSize: 11, color: Palette.outline)),
          ])),
          Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: Color(0xFF00695C).withValues(alpha: 0.10), borderRadius: BorderRadius.circular(8)),
            child: const Text('Active', style: TextStyle(color: Color(0xFF00695C), fontSize: 11, fontWeight: FontWeight.w700))),
        ]))),
      const SizedBox(height: 8),
      GestureDetector(onTap: () {}, child: Container(
        width: double.infinity, height: 50,
        decoration: BoxDecoration(gradient: const LinearGradient(colors: [Palette.primary, Color(0xFF3949AB)]), borderRadius: BorderRadius.circular(16)),
        child: const Center(child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.add_rounded, color: Colors.white, size: 18), SizedBox(width: 8),
          Text('Register New Key', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14))]))),
      ),
    ])),
  );
}