// FILE: lib/ui/screens/enterprise_support_screen.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../../core/navigation/liquid_router.dart';
import '../components/app_shell.dart';

class EnterpriseSupportScreen extends StatefulWidget {
  const EnterpriseSupportScreen({super.key});
  @override
  State<EnterpriseSupportScreen> createState() => _State();
}

class _State extends State<EnterpriseSupportScreen> {
  int _priority = 1;
  final _msgCtrl = TextEditingController();
  @override
  void dispose() {
    _msgCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) => AppShell(
      activeRoute: LiquidRouter.enterprise,
      title: 'Enterprise Support',
      child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Account manager card
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
                          color: Colors.white.withOpacity(0.15),
                          shape: BoxShape.circle),
                      child: const Center(
                          child: Text('JA',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18)))),
                  const SizedBox(width: 14),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        const Text('Your Account Manager',
                            style: TextStyle(
                                color: Colors.white60,
                                fontSize: 11,
                                fontWeight: FontWeight.w600)),
                        const Text('James Aldridge',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w800)),
                        const Text('Response time: < 2 hours',
                            style:
                                TextStyle(color: Colors.white60, fontSize: 11)),
                      ])),
                  Column(children: [
                    _ContactBtn(
                        icon: Icons.chat_bubble_outline_rounded, label: 'Chat'),
                    const SizedBox(height: 6),
                    _ContactBtn(icon: Icons.call_outlined, label: 'Call'),
                  ]),
                ])),
            const SizedBox(height: 24),

            // Open tickets
            _SHead('Open Tickets'),
            const SizedBox(height: 12),
            ...[
              ('API Rate Limit Increase', 'In Progress', 'HIGH', Colors.orange),
              ('SSO SAML Configuration', 'Pending', 'MED', Palette.primary),
              ('Custom Retention Policy', 'Open', 'LOW', Palette.outline),
            ].map((t) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                    color: Palette.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          color: Palette.primary.withOpacity(0.04),
                          blurRadius: 8)
                    ]),
                child: Row(children: [
                  Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                          color: Palette.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                          child: Text(t.$3,
                              style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w800,
                                  color: t.$4,
                                  letterSpacing: 0.5)))),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(t.$1,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                color: Palette.onSurface)),
                        Text(t.$2,
                            style: TextStyle(
                                fontSize: 11,
                                color: t.$4,
                                fontWeight: FontWeight.w600)),
                      ])),
                  const Icon(Icons.arrow_forward_ios_rounded,
                      size: 12, color: Palette.outline),
                ]))),
            const SizedBox(height: 24),

            // New ticket
            _SHead('Submit New Ticket'),
            const SizedBox(height: 12),
            Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Palette.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Palette.primary.withOpacity(0.04),
                          blurRadius: 10)
                    ]),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Priority',
                          style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: Palette.onSurfaceVariant)),
                      const SizedBox(height: 8),
                      Row(
                          children: ['Low', 'Medium', 'High']
                              .asMap()
                              .entries
                              .map((e) => GestureDetector(
                                  onTap: () =>
                                      setState(() => _priority = e.key),
                                  child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      margin: const EdgeInsets.only(right: 8),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14, vertical: 8),
                                      decoration: BoxDecoration(
                                          color: _priority == e.key
                                              ? Palette.primary
                                              : Palette.surfaceContainerHigh,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(e.value,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: _priority == e.key
                                                  ? Colors.white
                                                  : Palette
                                                      .onSurfaceVariant)))))
                              .toList()),
                      const SizedBox(height: 14),
                      const Text('Description',
                          style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: Palette.onSurfaceVariant)),
                      const SizedBox(height: 8),
                      TextField(
                          controller: _msgCtrl,
                          maxLines: 4,
                          decoration: InputDecoration(
                              hintText: 'Describe your issue...',
                              hintStyle: const TextStyle(
                                  color: Palette.outline, fontSize: 13),
                              filled: true,
                              fillColor: Palette.surfaceContainerLow,
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      color: Palette.primary, width: 1.5)))),
                      const SizedBox(height: 14),
                      GestureDetector(
                          onTap: () {},
                          child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(colors: [
                                    Palette.primary,
                                    Color(0xFF2C3E9E)
                                  ]),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Palette.primary.withOpacity(0.26),
                                        blurRadius: 14,
                                        offset: const Offset(0, 5))
                                  ]),
                              child: const Center(
                                  child: Text('Submit Ticket',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14))))),
                    ])),
            const SizedBox(height: 32),
          ])));
}

class _ContactBtn extends StatelessWidget {
  const _ContactBtn({required this.icon, required this.label});
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext ctx) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          borderRadius: BorderRadius.circular(10)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, color: Colors.white, size: 14),
        const SizedBox(width: 4),
        Text(label,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600)),
      ]));
}

Widget _SHead(String t) => Text(t,
    style: TextStyle(
        fontFamily: Palette.fontDisplay,
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: Palette.primary));
