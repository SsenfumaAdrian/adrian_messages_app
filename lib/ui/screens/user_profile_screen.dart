// FILE: lib/ui/screens/user_profile_screen.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../../core/navigation/liquid_router.dart';
import '../components/app_scaffold.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});
  @override
  State<UserProfileScreen> createState() => _State();
}

class _State extends State<UserProfileScreen> {
  bool _notifications = true;
  bool _biometric = true;
  bool _readReceipts = false;
  bool _onlineStatus = true;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Profile & Settings',
      showBack: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Avatar hero
          Center(
            child: Column(children: [
              Stack(children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Palette.primary, Color(0xFF3949AB)]),
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                          color: Palette.primary.withValues(alpha: 0.28),
                          blurRadius: 24,
                          offset: Offset(0, 8))
                    ],
                  ),
                  child: const Center(
                      child: Text('AM',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w800))),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                          color: Palette.accentCyan,
                          borderRadius: BorderRadius.circular(9),
                          border: Border.all(color: Palette.surface, width: 2)),
                      child: const Icon(Icons.edit_rounded,
                          size: 14, color: Colors.white),
                    )),
              ]),
              const SizedBox(height: 14),
              const Text('Alex Mercer',
                  style: TextStyle(
                      fontFamily: Palette.fontDisplay,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Palette.onSurface)),
              const SizedBox(height: 4),
              const Text('alex@adrian.ai',
                  style: TextStyle(
                      fontSize: 13, color: Palette.onSurfaceVariant)),
              const SizedBox(height: 8),
              Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                  decoration: BoxDecoration(
                      color: Palette.primary,
                      borderRadius: BorderRadius.circular(99)),
                  child: const Text('Pro Plan',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700))),
            ]),
          ),
          const SizedBox(height: 32),

          const _Section(title: 'Account', children: [
            _EditTile(label: 'Display Name', value: 'Alex Mercer'),
            _EditTile(label: 'Username', value: '@alex.mercer'),
            _EditTile(label: 'Status', value: 'Available for deep work 🎯'),
            _EditTile(label: 'Phone', value: '+1 (555) 000-1234'),
          ]),
          const SizedBox(height: 20),

          _Section(title: 'Privacy', children: [
            _ToggleTile(
                label: 'Online Status',
                sub: 'Show when you\'re active',
                value: _onlineStatus,
                onChanged: (v) => setState(() => _onlineStatus = v)),
            _ToggleTile(
                label: 'Read Receipts',
                sub: 'Let others see when you\'ve read',
                value: _readReceipts,
                onChanged: (v) => setState(() => _readReceipts = v)),
          ]),
          const SizedBox(height: 20),

          _Section(title: 'Security', children: [
            _ToggleTile(
                label: 'Biometric Lock',
                sub: 'Face ID / Fingerprint',
                value: _biometric,
                onChanged: (v) => setState(() => _biometric = v)),
            _ToggleTile(
                label: 'Push Notifications',
                sub: 'Receive alerts',
                value: _notifications,
                onChanged: (v) => setState(() => _notifications = v)),
            const _ArrowTile(
                label: 'Change Password', icon: Icons.lock_reset_rounded),
            const _ArrowTile(
                label: 'Two-Factor Authentication',
                icon: Icons.verified_user_outlined),
            const _ArrowTile(label: 'Active Sessions', icon: Icons.devices_rounded),
          ]),
          const SizedBox(height: 20),

          const _Section(title: 'Subscription', children: [
            _ArrowTile(
                label: 'Manage Plan', icon: Icons.workspace_premium_rounded),
            _ArrowTile(
                label: 'Billing & Invoices', icon: Icons.receipt_long_outlined),
          ]),
          const SizedBox(height: 20),

          // Sign out
          GestureDetector(
            onTap: () => LiquidRouter.clearAndGo(context, LiquidRouter.auth),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: const Color(0xFFFFF0F0),
                  borderRadius: BorderRadius.circular(18)),
              child: const Row(children: [
                Icon(Icons.logout_rounded, color: Color(0xFFB3261E), size: 20),
                SizedBox(width: 12),
                Text('Sign Out',
                    style: TextStyle(
                        color: Color(0xFFB3261E),
                        fontWeight: FontWeight.w700,
                        fontSize: 14)),
              ]),
            ),
          ),
          const SizedBox(height: 32),
        ]),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});
  final String title;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: EdgeInsets.only(left: 4, bottom: 10),
            child: Text(title,
                style: const TextStyle(
                    fontFamily: Palette.fontDisplay,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Palette.primary,
                    letterSpacing: 0.4))),
        Container(
            decoration: BoxDecoration(
                color: Palette.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Palette.primary.withValues(alpha: 0.04),
                      blurRadius: 12,
                      offset: Offset(0, 2))
                ]),
            child: Column(
                children: children
                    .asMap()
                    .entries
                    .map((e) => Column(children: [
                          e.value,
                          if (e.key < children.length - 1)
                            Divider(
                                indent: 56,
                                endIndent: 16,
                                height: 1,
                                color:
                                    Palette.outlineVariant.withValues(alpha: 0.15)),
                        ]))
                    .toList())),
      ]);
}

class _EditTile extends StatelessWidget {
  const _EditTile({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        title: Text(label,
            style:
                const TextStyle(fontSize: 12, color: Palette.onSurfaceVariant)),
        subtitle: Text(value,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Palette.onSurface)),
        trailing:
            const Icon(Icons.edit_outlined, size: 16, color: Palette.outline),
      );
}

class _ToggleTile extends StatelessWidget {
  const _ToggleTile(
      {required this.label,
      required this.sub,
      required this.value,
      required this.onChanged});
  final String label, sub;
  final bool value;
  final ValueChanged<bool> onChanged;
  @override
  Widget build(BuildContext context) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        title: Text(label,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Palette.onSurface)),
        subtitle: Text(sub,
            style:
                const TextStyle(fontSize: 12, color: Palette.onSurfaceVariant)),
        trailing: Switch.adaptive(
            value: value, onChanged: onChanged, activeColor: Palette.primary),
      );
}

class _ArrowTile extends StatelessWidget {
  const _ArrowTile({required this.label, required this.icon});
  final String label;
  final IconData icon;
  @override
  Widget build(BuildContext context) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        leading: Icon(icon, size: 20, color: Palette.primary),
        title: Text(label,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Palette.onSurface)),
        trailing: const Icon(Icons.arrow_forward_ios_rounded,
            size: 14, color: Palette.outline),
        onTap: () {},
      );
}
