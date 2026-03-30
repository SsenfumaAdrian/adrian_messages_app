// FILE: lib/ui/screens/audit_log_screen.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../../core/navigation/liquid_router.dart';
import '../components/app_shell.dart';

class AuditLogScreen extends StatefulWidget {
  const AuditLogScreen({super.key});
  @override
  State<AuditLogScreen> createState() => _State();
}

class _State extends State<AuditLogScreen> {
  int _filter = 0;
  static const _filters = ['All', 'Login', 'Access', 'Security', 'Vault'];

  static const _events = [
    _Event(
        type: _EventType.login,
        title: 'Successful Login',
        sub: 'MacBook Pro · Kampala, UG',
        time: '2 min ago',
        ok: true),
    _Event(
        type: _EventType.security,
        title: 'Biometric Auth Used',
        sub: 'iPhone 16 Pro · App unlock',
        time: '14 min ago',
        ok: true),
    _Event(
        type: _EventType.access,
        title: 'Vault Accessed',
        sub: 'Project Chimera Vault opened',
        time: '1 hr ago',
        ok: true),
    _Event(
        type: _EventType.security,
        title: 'Failed Login Attempt',
        sub: 'Unknown device · Lagos, NG',
        time: '3 hrs ago',
        ok: false),
    _Event(
        type: _EventType.login,
        title: 'New Session Started',
        sub: 'iPad Air · Chrome 125',
        time: '5 hrs ago',
        ok: true),
    _Event(
        type: _EventType.access,
        title: 'Admin Settings Accessed',
        sub: 'Web dashboard · macOS',
        time: 'Yesterday',
        ok: true),
    _Event(
        type: _EventType.security,
        title: 'Password Changed',
        sub: 'Verified via email OTP',
        time: '2 days ago',
        ok: true),
    _Event(
        type: _EventType.vault,
        title: 'Encrypted File Uploaded',
        sub: 'Legal Docs · 4.2 MB added',
        time: '3 days ago',
        ok: true),
    _Event(
        type: _EventType.security,
        title: '2FA Code Requested',
        sub: 'Authenticator app · iOS',
        time: '4 days ago',
        ok: true),
    _Event(
        type: _EventType.login,
        title: 'Session Revoked',
        sub: 'Old browser session terminated',
        time: '5 days ago',
        ok: true),
  ];

  @override
  Widget build(BuildContext context) {
    final visible = _filter == 0
        ? _events
        : _events.where((e) => e.type.index == _filter - 1).toList();

    return AppShell(
      activeRoute: LiquidRouter.auditLog,
      title: 'Audit Log & Security',
      child: Column(children: [
        // Security score banner
        Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [Palette.primary, Color(0xFF163A72)]),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                  color: Palette.primary.withOpacity(0.28),
                  blurRadius: 20,
                  offset: const Offset(0, 8))
            ],
          ),
          child: Row(children: [
            const Icon(Icons.shield_rounded, color: Colors.white, size: 40),
            const SizedBox(width: 16),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  const Text('Security Status: Excellent',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  const Text(
                      '1 warning in the last 30 days · No breaches detected',
                      style: TextStyle(color: Colors.white60, fontSize: 12)),
                  const SizedBox(height: 10),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: const LinearProgressIndicator(
                          value: 0.92,
                          minHeight: 5,
                          backgroundColor: Colors.white24,
                          color: Palette.accentCyan)),
                  const SizedBox(height: 4),
                  const Text('Score: 92 / 100',
                      style: TextStyle(
                          color: Palette.accentCyan,
                          fontSize: 11,
                          fontWeight: FontWeight.w700)),
                ])),
          ]),
        ),

        // Filter chips
        SizedBox(
          height: 44,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: _filters.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, i) => GestureDetector(
              onTap: () => setState(() => _filter = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                    color: _filter == i
                        ? Palette.primary
                        : Palette.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(99)),
                child: Text(_filters[i],
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: _filter == i ? Colors.white : Palette.primary)),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Event timeline
        Expanded(
            child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          itemCount: visible.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (_, i) => _EventTile(event: visible[i]),
        )),
      ]),
    );
  }
}

enum _EventType { login, access, security, vault }

class _Event {
  const _Event(
      {required this.type,
      required this.title,
      required this.sub,
      required this.time,
      required this.ok});
  final _EventType type;
  final String title, sub, time;
  final bool ok;
}

class _EventTile extends StatelessWidget {
  const _EventTile({required this.event});
  final _Event event;

  static IconData _icon(_EventType t) => switch (t) {
        _EventType.login => Icons.login_rounded,
        _EventType.access => Icons.key_rounded,
        _EventType.security => Icons.verified_user_outlined,
        _EventType.vault => Icons.lock_outline_rounded,
      };

  static Color _color(_EventType t) => switch (t) {
        _EventType.login => const Color(0xFF0F6FFF),
        _EventType.access => Palette.primary,
        _EventType.security => Palette.accentCyan,
        _EventType.vault => const Color(0xFF00695C),
      };

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Palette.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(18),
          border: event.ok
              ? null
              : Border.all(color: Palette.error.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
                color: Palette.primary.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 2))
          ],
        ),
        child: Row(children: [
          Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                  color: _color(event.type).withOpacity(0.10),
                  borderRadius: BorderRadius.circular(14)),
              child:
                  Icon(_icon(event.type), color: _color(event.type), size: 22)),
          const SizedBox(width: 12),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Row(children: [
                  Expanded(
                      child: Text(event.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              color: Palette.onSurface))),
                  Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: event.ok ? Palette.success : Palette.error)),
                ]),
                const SizedBox(height: 3),
                Text(event.sub,
                    style: const TextStyle(
                        fontSize: 11, color: Palette.onSurfaceVariant)),
              ])),
          const SizedBox(width: 10),
          Text(event.time,
              style: const TextStyle(
                  fontSize: 10,
                  color: Palette.outline,
                  fontWeight: FontWeight.w600)),
        ]),
      );
}
