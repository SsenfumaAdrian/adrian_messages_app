// FILE: lib/ui/screens/circle_management_screen.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../../core/navigation/liquid_router.dart';
import '../components/app_shell.dart';

class CircleManagementScreen extends StatefulWidget {
  const CircleManagementScreen({super.key});
  @override
  State<CircleManagementScreen> createState() => _State();
}

class _State extends State<CircleManagementScreen> {
  final _perms = {
    'Send Messages': [true, true, true],
    'Share Files': [true, true, false],
    'Invite Members': [true, false, false],
    'Delete Messages': [true, false, false],
    'Manage Roles': [true, false, false],
    'View Analytics': [true, true, false],
  };

  static const _roles = ['Owner', 'Admin', 'Member'];

  static const _members = [
    _Member('Elena Vance', 'Owner', true, 'EV'),
    _Member('Marcus Reid', 'Admin', true, 'MR'),
    _Member('Sarah Miller', 'Member', false, 'SM'),
    _Member('James Okonkwo', 'Member', true, 'JO'),
    _Member('Priya Sharma', 'Admin', true, 'PS'),
  ];

  @override
  Widget build(BuildContext context) {
    return AppShell(
      activeRoute: LiquidRouter.circleManage,
      title: 'Circle Management',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Circle card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Palette.primary, Color(0xFF3949AB)]),
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                      color: Palette.primary.withOpacity(0.28),
                      blurRadius: 20,
                      offset: const Offset(0, 8))
                ]),
            child: Row(children: [
              Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(16)),
                  child: const Icon(Icons.workspaces_rounded,
                      color: Colors.white, size: 28)),
              const SizedBox(width: 14),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    const Text('Executive Board',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800)),
                    const Text('5 members · Private circle · Created Jan 2025',
                        style: TextStyle(color: Colors.white60, fontSize: 12)),
                  ])),
              IconButton(
                  icon: const Icon(Icons.person_add_outlined,
                      color: Colors.white, size: 22),
                  onPressed: () {}),
            ]),
          ),
          const SizedBox(height: 24),

          // Members list
          _SHead('Members'),
          const SizedBox(height: 12),
          ..._members.map((m) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                    color: Palette.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          color: Palette.primary.withOpacity(0.04),
                          blurRadius: 8)
                    ]),
                child: Row(children: [
                  Stack(clipBehavior: Clip.none, children: [
                    Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [Palette.primary, Color(0xFF3949AB)]),
                            borderRadius: BorderRadius.circular(14)),
                        child: Center(
                            child: Text(m.initials,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 13)))),
                    if (m.online)
                      Positioned(
                          bottom: -2,
                          right: -2,
                          child: Container(
                              width: 11,
                              height: 11,
                              decoration: BoxDecoration(
                                  color: Palette.accentCyan,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Palette.surfaceContainerLowest,
                                      width: 2)))),
                  ]),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(m.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                color: Palette.onSurface)),
                        Text(m.role,
                            style: const TextStyle(
                                fontSize: 11, color: Palette.onSurfaceVariant)),
                      ])),
                  _RoleChip(role: m.role),
                  const SizedBox(width: 4),
                  const Icon(Icons.more_vert_rounded,
                      color: Palette.outline, size: 18),
                ]),
              )),

          const SizedBox(height: 24),

          // Permissions matrix
          _SHead('Role Permissions'),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
                color: Palette.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Palette.primary.withOpacity(0.04), blurRadius: 12)
                ]),
            child: Column(children: [
              // Role header
              Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(children: [
                    const Expanded(flex: 3, child: SizedBox()),
                    ..._roles.map((r) => Expanded(
                        child: Text(r,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: Palette.fontDisplay,
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: Palette.primary)))),
                  ])),
              const Divider(height: 1, color: Color(0x08000000)),
              ..._perms.entries.map((e) {
                final vals = e.value;
                return Column(children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Row(children: [
                        Expanded(
                            flex: 3,
                            child: Text(e.key,
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Palette.onSurface))),
                        ...List.generate(
                            3,
                            (i) => Expanded(
                                    child: GestureDetector(
                                  onTap: () =>
                                      setState(() => vals[i] = !vals[i]),
                                  child: Center(
                                      child: AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                              color: vals[i]
                                                  ? Palette.primary
                                                  : Palette
                                                      .surfaceContainerHigh,
                                              borderRadius:
                                                  BorderRadius.circular(7)),
                                          child: vals[i]
                                              ? const Icon(Icons.check_rounded,
                                                  color: Colors.white, size: 14)
                                              : null)),
                                ))),
                      ])),
                  if (e.key != _perms.keys.last)
                    const Divider(
                        height: 1,
                        indent: 16,
                        endIndent: 16,
                        color: Color(0x06000000)),
                ]);
              }),
            ]),
          ),
          const SizedBox(height: 32),
        ]),
      ),
    );
  }
}

class _Member {
  const _Member(this.name, this.role, this.online, this.initials);
  final String name, role, initials;
  final bool online;
}

class _RoleChip extends StatelessWidget {
  const _RoleChip({required this.role});
  final String role;
  static Color _color(String r) => r == 'Owner'
      ? const Color(0xFF7B1FA2)
      : r == 'Admin'
          ? Palette.primary
          : Palette.outline;
  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
          color: _color(role).withOpacity(0.10),
          borderRadius: BorderRadius.circular(99)),
      child: Text(role,
          style: TextStyle(
              fontSize: 11, fontWeight: FontWeight.w700, color: _color(role))));
}

Widget _SHead(String t) => Text(t,
    style: TextStyle(
        fontFamily: Palette.fontDisplay,
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: Palette.primary));
