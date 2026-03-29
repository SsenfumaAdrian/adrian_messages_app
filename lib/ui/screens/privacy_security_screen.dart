// FILE: lib/ui/screens/privacy_security_screen.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../../core/navigation/liquid_router.dart';
import '../components/app_shell.dart';

class PrivacySecurityScreen extends StatefulWidget {
  const PrivacySecurityScreen({super.key});
  @override
  State<PrivacySecurityScreen> createState() => _State();
}

class _State extends State<PrivacySecurityScreen> {
  bool _e2e = true,
      _biometric = true,
      _screenLock = false,
      _stealth = false,
      _vpn = false;

  @override
  Widget build(BuildContext ctx) => AppShell(
      activeRoute: LiquidRouter.privacy,
      title: 'Privacy & Security',
      child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Security score card
            Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Palette.primary, Color(0xFF163A72)]),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                          color: Palette.primary.withOpacity(0.3),
                          blurRadius: 24,
                          offset: const Offset(0, 8))
                    ]),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(children: [
                        Icon(Icons.verified_user_rounded,
                            color: Colors.white, size: 22),
                        SizedBox(width: 8),
                        Text('Security Score',
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                                fontWeight: FontWeight.w600))
                      ]),
                      const SizedBox(height: 12),
                      const Text('92 / 100',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -1)),
                      const SizedBox(height: 8),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                              value: 0.92,
                              minHeight: 6,
                              backgroundColor: Colors.white24,
                              color: Palette.accentCyan)),
                      const SizedBox(height: 8),
                      const Text(
                          'Your account is highly secure. Enable Screen Lock to reach 100.',
                          style:
                              TextStyle(color: Colors.white60, fontSize: 12)),
                    ])),
            const SizedBox(height: 24),

            _SectionHeader('Encryption'),
            _SecurityTile(
                title: 'End-to-End Encryption',
                sub: 'All messages are E2E encrypted by default',
                icon: Icons.lock_rounded,
                value: _e2e,
                onChanged: (v) => setState(() => _e2e = v)),
            _SecurityTile(
                title: 'Biometric Authentication',
                sub: 'Use Face ID or fingerprint to unlock',
                icon: Icons.fingerprint_rounded,
                value: _biometric,
                onChanged: (v) => setState(() => _biometric = v)),
            const SizedBox(height: 20),

            _SectionHeader('Privacy Controls'),
            _SecurityTile(
                title: 'Screen Lock',
                sub: 'Auto-lock after 1 minute of inactivity',
                icon: Icons.screen_lock_portrait_rounded,
                value: _screenLock,
                onChanged: (v) => setState(() => _screenLock = v)),
            _SecurityTile(
                title: 'Stealth Mode',
                sub: 'Hide app content in app switcher',
                icon: Icons.visibility_off_outlined,
                value: _stealth,
                onChanged: (v) => setState(() => _stealth = v)),
            _SecurityTile(
                title: 'VPN Integration',
                sub: 'Route traffic through secure VPN',
                icon: Icons.vpn_key_rounded,
                value: _vpn,
                onChanged: (v) => setState(() => _vpn = v)),
            const SizedBox(height: 20),

            _SectionHeader('Audit & Access'),
            _ArrowTile(
                icon: Icons.history_rounded,
                title: 'Security Audit Log',
                sub: 'View all login & access events',
                onTap: () => LiquidRouter.go(ctx, LiquidRouter.auditLog)),
            _ArrowTile(
                icon: Icons.devices_rounded,
                title: 'Active Sessions',
                sub: '3 devices currently signed in',
                onTap: () {}),
            _ArrowTile(
                icon: Icons.admin_panel_settings_outlined,
                title: 'Two-Factor Authentication',
                sub: 'Authenticator app enabled',
                onTap: () {}),
            const SizedBox(height: 20),

            _SectionHeader('Data & Privacy'),
            _ArrowTile(
                icon: Icons.download_rounded,
                title: 'Export My Data',
                sub: 'Download a copy of your data',
                onTap: () {}),
            _ArrowTile(
                icon: Icons.delete_outline_rounded,
                title: 'Delete Account',
                sub: 'Permanently remove account & data',
                onTap: () {},
                danger: true),
            const SizedBox(height: 32),
          ])));
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;
  @override
  Widget build(BuildContext ctx) => Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 10),
      child: Text(title,
          style: TextStyle(
              fontFamily: Palette.fontDisplay,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Palette.primary,
              letterSpacing: 0.4)));
}

class _SecurityTile extends StatelessWidget {
  const _SecurityTile(
      {required this.title,
      required this.sub,
      required this.icon,
      required this.value,
      required this.onChanged});
  final String title, sub;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;
  @override
  Widget build(BuildContext ctx) => Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
          color: Palette.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16)),
      child: Row(children: [
        Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: (value ? Palette.primary : Palette.surfaceContainerHigh),
                borderRadius: BorderRadius.circular(12)),
            child: Icon(icon,
                color: value ? Colors.white : Palette.outline, size: 20)),
        const SizedBox(width: 12),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Palette.onSurface)),
          Text(sub,
              style: const TextStyle(
                  fontSize: 11, color: Palette.onSurfaceVariant)),
        ])),
        Switch.adaptive(
            value: value, onChanged: onChanged, activeColor: Palette.primary),
      ]));
}

class _ArrowTile extends StatelessWidget {
  const _ArrowTile(
      {required this.icon,
      required this.title,
      required this.sub,
      required this.onTap,
      this.danger = false});
  final IconData icon;
  final String title, sub;
  final VoidCallback onTap;
  final bool danger;
  @override
  Widget build(BuildContext ctx) => GestureDetector(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
              color: Palette.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(16)),
          child: Row(children: [
            Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: danger
                        ? const Color(0x15B3261E)
                        : Palette.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(12)),
                child: Icon(icon,
                    color: danger ? Palette.error : Palette.primary, size: 20)),
            const SizedBox(width: 12),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(title,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: danger ? Palette.error : Palette.onSurface)),
                  Text(sub,
                      style: const TextStyle(
                          fontSize: 11, color: Palette.onSurfaceVariant)),
                ])),
            const Icon(Icons.arrow_forward_ios_rounded,
                size: 13, color: Palette.outline),
          ])));
}
