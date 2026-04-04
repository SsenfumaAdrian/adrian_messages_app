// FILE: lib/ui/screens/admin_dashboard_screen.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../../core/navigation/liquid_router.dart';
import '../components/app_shell.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  static const _barFractions = [0.55, 0.72, 0.61, 0.88, 0.95, 0.45, 0.38];
  static const _days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  @override
  Widget build(BuildContext context) {
    return AppShell(
      activeRoute: LiquidRouter.adminDashboard,
      title: 'Admin Dashboard',
      actions: [_LiveChip()],
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // KPI grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.2,
            children: const [
              _KpiCard(
                  label: 'Total Users',
                  value: '48,291',
                  delta: '+8.4%',
                  up: true,
                  icon: Icons.people_outline_rounded),
              _KpiCard(
                  label: 'Active Today',
                  value: '12,847',
                  delta: '+2.1%',
                  up: true,
                  icon: Icons.online_prediction_rounded),
              _KpiCard(
                  label: 'Messages / Day',
                  value: '2.4 M',
                  delta: '+14%',
                  up: true,
                  icon: Icons.chat_bubble_outline_rounded),
              _KpiCard(
                  label: 'Flagged Events',
                  value: '23',
                  delta: '-60%',
                  up: true,
                  icon: Icons.flag_outlined),
            ],
          ),
          const SizedBox(height: 28),

          // Activity bar chart
          _Head('Platform Activity — Last 7 Days'),
          const SizedBox(height: 12),
          Container(
            height: 180,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: _cardBox,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                  7,
                  (i) => _ActivityBar(
                        day: _days[i],
                        fraction: _barFractions[i],
                        highlight: i == 4,
                      )),
            ),
          ),
          const SizedBox(height: 28),

          // User table
          Row(children: [
            Expanded(child: _Head('Recent Users')),
            _TextBtn(label: 'Export CSV', icon: Icons.download_outlined),
          ]),
          const SizedBox(height: 12),
          Container(
            decoration: _cardBox,
            child: Column(children: [
              const _TableHeader(),
              const Divider(
                  height: 1,
                  indent: 20,
                  endIndent: 20,
                  color: Color(0x10000000)),
              ..._kUsers.asMap().entries.map((e) => Column(children: [
                    _UserRow(user: e.value),
                    if (e.key < _kUsers.length - 1)
                      const Divider(
                          height: 1,
                          indent: 72,
                          endIndent: 20,
                          color: Color(0x08000000)),
                  ])),
            ]),
          ),
          const SizedBox(height: 28),

          // Quick actions
          _Head('Quick Actions'),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(
                child: _ActionCard(
                    icon: Icons.person_add_outlined, label: 'Invite\nUsers')),
            const SizedBox(width: 12),
            Expanded(
                child: _ActionCard(
                    icon: Icons.block_outlined, label: 'Manage\nBans')),
            const SizedBox(width: 12),
            Expanded(
                child: _ActionCard(
                    icon: Icons.campaign_outlined, label: 'Broadcast\nAlert')),
            const SizedBox(width: 12),
            Expanded(
                child: _ActionCard(
                    icon: Icons.settings_backup_restore_outlined,
                    label: 'System\nBackup')),
          ]),
          const SizedBox(height: 32),
        ]),
      ),
    );
  }
}

const _cardBox = BoxDecoration(
  color: Palette.surfaceContainerLowest,
  borderRadius: BorderRadius.all(Radius.circular(22)),
  boxShadow: [
    BoxShadow(color: Color(0x0A1A237E), blurRadius: 14, offset: Offset(0, 3))
  ],
);

// ignore: non_constant_identifier_names
Widget _Head(String t) => Text(t,
    style: TextStyle(
        fontFamily: Palette.fontDisplay,
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: Palette.primary));

class _LiveChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
            color: Palette.accentCyan.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(99)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                  color: Palette.accentCyan, shape: BoxShape.circle)),
          const SizedBox(width: 5),
          const Text('Live',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Palette.accentCyan)),
        ]),
      );
}

class _KpiCard extends StatelessWidget {
  const _KpiCard(
      {required this.label,
      required this.value,
      required this.delta,
      required this.up,
      required this.icon});
  final String label, value, delta;
  final bool up;
  final IconData icon;
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(16),
        decoration: _cardBox,
        child: Row(children: [
          Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                  color: Palette.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(14)),
              child: Icon(icon, color: Palette.primary, size: 22)),
          const SizedBox(width: 12),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(value,
                    style: TextStyle(
                        fontFamily: Palette.fontDisplay,
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: Palette.onSurface)),
                Text(label,
                    style: const TextStyle(
                        fontSize: 10,
                        color: Palette.onSurfaceVariant,
                        fontWeight: FontWeight.w600)),
                Row(children: [
                  Icon(
                      up
                          ? Icons.trending_up_rounded
                          : Icons.trending_down_rounded,
                      size: 11,
                      color: up ? Palette.success : Palette.error),
                  const SizedBox(width: 3),
                  Text(delta,
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: up ? Palette.success : Palette.error)),
                ]),
              ])),
        ]),
      );
}

class _ActivityBar extends StatelessWidget {
  const _ActivityBar(
      {required this.day, required this.fraction, required this.highlight});
  final String day;
  final double fraction;
  final bool highlight;
  @override
  Widget build(BuildContext context) =>
      Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Container(
            width: 28,
            height: 130 * fraction,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: highlight
                        ? [Palette.accentCyan, Palette.primary]
                        : [
                            Palette.primary.withValues(alpha: 0.5),
                            Palette.primary.withValues(alpha: 0.2)
                          ]),
                borderRadius: BorderRadius.circular(8))),
        const SizedBox(height: 6),
        Text(day,
            style: const TextStyle(
                fontSize: 10,
                color: Palette.outline,
                fontWeight: FontWeight.w600)),
      ]);
}

class _TableHeader extends StatelessWidget {
  const _TableHeader();
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(children: [
          const SizedBox(width: 46),
          Expanded(flex: 3, child: _TH('USER')),
          Expanded(flex: 2, child: _TH('PLAN')),
          Expanded(flex: 1, child: _TH('STATUS')),
          const SizedBox(width: 40),
        ]),
      );
}

class _TH extends StatelessWidget {
  const _TH(this.t);
  final String t;
  @override
  Widget build(BuildContext context) => Text(t,
      style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: Palette.outline,
          letterSpacing: 1.2));
}

class _UserRow extends StatelessWidget {
  const _UserRow({required this.user});
  final _UserData user;
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 11),
        child: Row(children: [
          Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Palette.primary, Color(0xFF3949AB)]),
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                  child: Text(user.name[0],
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 14)))),
          SizedBox(width: 10),
          Expanded(
              flex: 3,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.name,
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Palette.onSurface)),
                    Text(user.email,
                        style: const TextStyle(
                            fontSize: 11, color: Palette.onSurfaceVariant)),
                  ])),
          Expanded(flex: 2, child: _PlanChip(plan: user.plan)),
          Expanded(
              flex: 1,
              child: Center(
                  child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                          color: user.active
                              ? Palette.accentCyan
                              : Palette.outline,
                          shape: BoxShape.circle)))),
          IconButton(
              icon: const Icon(Icons.more_vert_rounded,
                  size: 17, color: Palette.outline),
              onPressed: () {}),
        ]),
      );
}

class _PlanChip extends StatelessWidget {
  const _PlanChip({required this.plan});
  final String plan;
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
            color: plan == 'Enterprise'
                ? Palette.primary.withValues(alpha: 0.1)
                : Palette.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(99)),
        child: Text(plan,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: plan == 'Enterprise'
                    ? Palette.primary
                    : Palette.onSurfaceVariant)),
      );
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({required this.icon, required this.label});
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {},
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 18),
            decoration: _cardBox,
            child: Column(children: [
              Icon(icon, color: Palette.primary, size: 24),
              const SizedBox(height: 8),
              Text(label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Palette.onSurface)),
            ])),
      );
}

class _TextBtn extends StatelessWidget {
  const _TextBtn({required this.label, required this.icon});
  final String label;
  final IconData icon;
  @override
  Widget build(BuildContext context) => TextButton.icon(
        onPressed: () {},
        icon: Icon(icon, size: 15),
        label: Text(label),
        style: TextButton.styleFrom(
            foregroundColor: Palette.onSurfaceVariant,
            textStyle:
                const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
      );
}

class _UserData {
  const _UserData(this.name, this.email, this.plan, this.active);
  final String name, email, plan;
  final bool active;
}

const _kUsers = [
  _UserData('Elena Vance', 'elena@corp.ai', 'Pro', true),
  _UserData('Marcus Reid', 'marcus@corp.ai', 'Enterprise', true),
  _UserData('Sarah Miller', 'sarah@corp.ai', 'Pro', false),
  _UserData('James Okonkwo', 'james@corp.ai', 'Free', true),
  _UserData('Priya Sharma', 'priya@corp.ai', 'Enterprise', true),
  _UserData('Leo Fontaine', 'leo@corp.ai', 'Free', false),
];
