// FILE: lib/ui/screens/cross_platform_device_management_screen.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../components/app_scaffold.dart';

class CrossPlatformDeviceManagementScreen extends StatelessWidget {
  const CrossPlatformDeviceManagementScreen({super.key});
  static const _devices = [
    (name: 'MacBook Pro 16"', os: 'macOS Sonoma', status: 'ACTIVE NOW', loc: 'London, UK', trust: 'Trusted', icon: Icons.laptop_mac_rounded, color: 0xFF00695C),
    (name: 'iPhone 15 Pro', os: 'iOS 18.1', status: 'ACTIVE 2H AGO', loc: 'London, UK', trust: 'Trusted', icon: Icons.phone_iphone_rounded, color: 0xFF1565C0),
    (name: 'Chrome — Windows', os: 'Windows 11', status: 'ACTIVE 3 DAYS AGO', loc: 'Manchester, UK', trust: 'Verified', icon: Icons.language_rounded, color: 0xFFE65100),
    (name: 'iPad Pro 12.9"', os: 'iPadOS 18', status: 'ACTIVE 1 WEEK AGO', loc: 'London, UK', trust: 'Trusted', icon: Icons.tablet_mac_rounded, color: 0xFF4A148C),
  ];
  @override
  Widget build(BuildContext context) => AppScaffold(
    title: 'Device Security',
    child: SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Stats row
      Row(children: [
        _StatCard(value: '${_devices.length}', label: 'Linked Devices', icon: Icons.devices_rounded, color: Palette.primary),
        const SizedBox(width: 12),
        _StatCard(value: '1', label: 'Active Now', icon: Icons.online_prediction_rounded, color: Color(0xFF00695C)),
        const SizedBox(width: 12),
        _StatCard(value: '0', label: 'Unverified', icon: Icons.warning_outlined, color: Color(0xFFE65100)),
      ]),
      const SizedBox(height: 24),
      const Text('LINKED DEVICES', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Palette.outline, letterSpacing: 1.2)),
      const SizedBox(height: 12),
      ..._devices.map((d) => Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Palette.surfaceContainerLowest, borderRadius: BorderRadius.circular(18), boxShadow: [BoxShadow(color: Palette.primary.withValues(alpha: 0.04), blurRadius: 10)]),
        child: Row(children: [
          Container(width: 44, height: 44, decoration: BoxDecoration(color: Color(d.color).withValues(alpha: 0.10), borderRadius: BorderRadius.circular(13)), child: Icon(d.icon, size: 22, color: Color(d.color))),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(d.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Palette.onSurface)),
            Text(d.os, style: const TextStyle(fontSize: 11.5, color: Palette.onSurfaceVariant)),
            Row(children: [
              Text(d.status, style: TextStyle(fontSize: 10, color: d.status.contains('NOW') ? Palette.accentCyan : Palette.outline, fontWeight: FontWeight.w700, letterSpacing: 0.4)),
              Text(' • ${d.loc}', style: const TextStyle(fontSize: 10, color: Palette.outline)),
            ]),
          ])),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: Color(d.color).withValues(alpha: 0.10), borderRadius: BorderRadius.circular(8)),
              child: Text(d.trust, style: TextStyle(fontSize: 10, color: Color(d.color), fontWeight: FontWeight.w700))),
            const SizedBox(height: 6),
            const Text('Sign out', style: TextStyle(fontSize: 10.5, color: Palette.outline, fontWeight: FontWeight.w600)),
          ]),
        ]))),
      const SizedBox(height: 16),
      GestureDetector(onTap: () {}, child: Container(
        width: double.infinity, height: 50,
        decoration: BoxDecoration(color: Palette.surfaceContainerLowest, borderRadius: BorderRadius.circular(14), border: Border.all(color: Palette.outlineVariant.withValues(alpha: 0.30))),
        child: const Center(child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.add_circle_outline_rounded, color: Palette.primary, size: 18), SizedBox(width: 8),
          Text('Link New Device', style: TextStyle(color: Palette.primary, fontWeight: FontWeight.w600, fontSize: 14))])),
      )),
    ])),
  );
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.value, required this.label, required this.icon, required this.color});
  final String value, label;
  final IconData icon;
  final Color color;
  @override Widget build(BuildContext context) => Expanded(child: Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: Palette.surfaceContainerLowest, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: color.withValues(alpha: 0.06), blurRadius: 10)]),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, size: 20, color: color),
      const SizedBox(height: 8),
      Text(value, style: TextStyle(fontFamily: Palette.fontDisplay, fontSize: 22, fontWeight: FontWeight.w800, color: color)),
      Text(label, style: const TextStyle(fontSize: 10.5, color: Palette.onSurfaceVariant, height: 1.3)),
    ])));
}