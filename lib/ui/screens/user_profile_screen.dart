import 'dart:async' show unawaited;
// FILE: lib/ui/screens/user_profile_screen.dart
// Matches: stitch/adrian_messages_user_profile_settings/code.html
// Two-column desktop layout, single-column on mobile/tablet

import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../../core/navigation/liquid_router.dart';
import '../../core/utils/nav_persistence.dart';
import '../components/app_scaffold.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});
  @override State<UserProfileScreen> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfileScreen> {
  bool _readReceipts  = true;
  bool _lastSeen      = true;
  bool _pushAlerts    = true;
  bool _soundEffects  = false;
  int  _themeIndex    = 0;

  void setReadReceipts(bool v)  => setState(() => _readReceipts = v);
  void setLastSeen(bool v)      => setState(() => _lastSeen = v);
  void setPushAlerts(bool v)    => setState(() => _pushAlerts = v);
  void setSoundEffects(bool v)  => setState(() => _soundEffects = v);
  void setTheme(int i)          => setState(() => _themeIndex = i);

  Future<void> _signOut() async {
    await NavPersistence.clear();
    if (!mounted) return;
    unawaited(LiquidRouter.clearAndGo(context, LiquidRouter.auth));
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final isWide = w >= 900;

    return AppScaffold(
      title: 'Profile & Settings',
      showBack: false,
      child: isWide ? _DesktopLayout(state: this) : _MobileLayout(state: this),
    );
  }
}

// ═════════════════════════════════════════════════════════════
// DESKTOP — two-column
// ═════════════════════════════════════════════════════════════
class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({required this.state});
  final _UserProfileState state;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Left column: avatar + info + actions ─────────────
        SizedBox(
          width: 320,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 24, 12, 40),
            child: _LeftCard(state: state),
          ),
        ),

        // ── Right column: settings panels ────────────────────
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(12, 24, 24, 40),
            child: Column(
              children: [
                // Privacy + Notifications row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _PrivacyCard(readReceipts: state._readReceipts, lastSeen: state._lastSeen, onReadReceiptsChanged: state.setReadReceipts, onLastSeenChanged: state.setLastSeen)),

                    const SizedBox(width: 16),
                    Expanded(child: _NotificationsCard(pushAlerts: state._pushAlerts, soundEffects: state._soundEffects, onPushChanged: state.setPushAlerts, onSoundChanged: state.setSoundEffects)),

                  ],
                ),
                const SizedBox(height: 16),

                // Appearance
                _AppearanceCard(themeIndex: state._themeIndex, onThemeChanged: state.setTheme),
                const SizedBox(height: 16),

                // Devices + Support row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _DevicesCard()),
                    const SizedBox(width: 16),
                    Expanded(child: _SupportCard()),
                  ],
                ),
                const SizedBox(height: 24),

                // Footer
                const Text(
                  'ADRIAN MESSAGES • VERSION 4.12.0\n© 2024 Adrian Digital Architecture. All rights reserved.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10, color: Palette.outline, height: 1.7),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ═════════════════════════════════════════════════════════════
// MOBILE — single column
// ═════════════════════════════════════════════════════════════
class _MobileLayout extends StatelessWidget {
  const _MobileLayout({required this.state});
  final _UserProfileState state;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
      child: Column(children: [
        _LeftCard(state: state),
        const SizedBox(height: 16),
        _PrivacyCard(readReceipts: state._readReceipts, lastSeen: state._lastSeen, onReadReceiptsChanged: state.setReadReceipts, onLastSeenChanged: state.setLastSeen),
        const SizedBox(height: 16),
        _NotificationsCard(pushAlerts: state._pushAlerts, soundEffects: state._soundEffects, onPushChanged: state.setPushAlerts, onSoundChanged: state.setSoundEffects),
        const SizedBox(height: 16),
        _AppearanceCard(themeIndex: state._themeIndex, onThemeChanged: state.setTheme),
        const SizedBox(height: 16),
        _DevicesCard(),
        const SizedBox(height: 16),
        _SupportCard(),
        const SizedBox(height: 24),
        const Text(
          'ADRIAN MESSAGES • VERSION 4.12.0',
          style: TextStyle(fontSize: 10, color: Palette.outline, letterSpacing: 1),
        ),
        const SizedBox(height: 8),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// LEFT CARD — avatar + account info + action buttons
// ─────────────────────────────────────────────────────────────
class _LeftCard extends StatelessWidget {
  const _LeftCard({required this.state});
  final _UserProfileState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Palette.primary.withValues(alpha: 0.06), blurRadius: 20, offset: const Offset(0, 4))],
      ),
      child: Column(children: [
        // ── Avatar section ──────────────────────────────────
        Padding(
          padding: const EdgeInsets.all(28),
          child: Column(children: [
            Stack(children: [
              Container(
                width: 96, height: 96,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(colors: [Palette.primary, Color(0xFF3949AB)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  boxShadow: [BoxShadow(color: Palette.primary.withValues(alpha: 0.30), blurRadius: 20, offset: const Offset(0, 6))],
                ),
                child: const Center(child: Text('JT', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800))),
              ),
              Positioned(
                bottom: 2, right: 2,
                child: Container(
                  width: 28, height: 28,
                  decoration: BoxDecoration(color: Palette.primary, shape: BoxShape.circle, border: Border.all(color: Palette.surfaceContainerLowest, width: 2)),
                  child: const Icon(Icons.edit_rounded, size: 14, color: Colors.white),
                ),
              ),
            ]),
            const SizedBox(height: 16),
            Text('Julian Thorne', style: TextStyle(fontFamily: Palette.fontDisplay, fontSize: 22, fontWeight: FontWeight.w800, color: Palette.primary)),
            const SizedBox(height: 4),
            const Text('Digital Architect & Curator', style: TextStyle(fontSize: 13, color: Palette.onSurfaceVariant)),
            const SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(width: 8, height: 8, decoration: const BoxDecoration(color: Palette.accentCyan, shape: BoxShape.circle)),
              const SizedBox(width: 6),
              const Text('ONLINE', style: TextStyle(fontSize: 11, color: Palette.accentCyan, fontWeight: FontWeight.w800, letterSpacing: 1)),
            ]),
          ]),
        ),

        // ── Divider ──────────────────────────────────────────
        Divider(height: 1, color: Palette.outlineVariant.withValues(alpha: 0.15)),

        // ── Account info fields ───────────────────────────────
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _InfoField(label: 'EMAIL ADDRESS', value: 'j.thorne@adrian.io'),
            const SizedBox(height: 16),
            _InfoField(label: 'PHONE', value: '+1 (555) 000-4567'),
            const SizedBox(height: 16),
            _InfoField(label: 'LOCATION', value: 'San Francisco, CA'),
          ]),
        ),

        // ── Action buttons ────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(children: [
            // Update Profile — primary gradient
            GestureDetector(
              onTap: () {},
              child: Container(
                width: double.infinity, height: 54,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Palette.primary, Color(0xFF3949AB)]),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Palette.primary.withValues(alpha: 0.28), blurRadius: 16, offset: const Offset(0, 4))],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(padding: EdgeInsets.only(left: 20), child: Text('Update Profile', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15))),
                    Padding(padding: EdgeInsets.only(right: 20), child: Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Change Password — outlined
            GestureDetector(
              onTap: () {},
              child: Container(
                width: double.infinity, height: 50,
                decoration: BoxDecoration(
                  color: Palette.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Palette.outlineVariant.withValues(alpha: 0.25)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(padding: EdgeInsets.only(left: 20), child: Text('Change Password', style: TextStyle(color: Palette.primary, fontWeight: FontWeight.w600, fontSize: 14))),
                    Padding(padding: EdgeInsets.only(right: 20), child: Icon(Icons.lock_outline_rounded, color: Palette.primary, size: 18)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Log out — error red
            GestureDetector(
              onTap: state._signOut,
              child: Container(
                width: double.infinity, height: 50,
                decoration: BoxDecoration(
                  color: Palette.error.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(padding: EdgeInsets.only(left: 20), child: Text('Log out', style: TextStyle(color: Palette.error, fontWeight: FontWeight.w600, fontSize: 14))),
                    Padding(padding: EdgeInsets.only(right: 20), child: Icon(Icons.logout_rounded, color: Palette.error, size: 18)),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}

class _InfoField extends StatelessWidget {
  const _InfoField({required this.label, required this.value});
  final String label, value;
  @override Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Palette.outline, letterSpacing: 1.2)),
    const SizedBox(height: 4),
    Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Palette.primary, fontFamily: Palette.fontDisplay)),
  ]);
}

// ─────────────────────────────────────────────────────────────
// SETTINGS PANEL BASE
// ─────────────────────────────────────────────────────────────
class _Panel extends StatelessWidget {
  const _Panel({required this.icon, required this.title, required this.children});
  final IconData icon;
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Palette.primary.withValues(alpha: 0.04), blurRadius: 16, offset: const Offset(0, 3))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
          child: Row(children: [
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(color: Palette.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, size: 18, color: Palette.primary),
            ),
            const SizedBox(width: 10),
            Text(title, style: TextStyle(fontFamily: Palette.fontDisplay, fontSize: 17, fontWeight: FontWeight.w700, color: Palette.onSurface)),
          ]),
        ),
        Divider(height: 1, color: Palette.outlineVariant.withValues(alpha: 0.15)),
        ...children,
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// PRIVACY CARD
// ─────────────────────────────────────────────────────────────
class _PrivacyCard extends StatelessWidget {
  const _PrivacyCard({required this.readReceipts, required this.lastSeen, required this.onReadReceiptsChanged, required this.onLastSeenChanged});
  final bool readReceipts, lastSeen;
  final ValueChanged<bool> onReadReceiptsChanged, onLastSeenChanged;
  @override
  Widget build(BuildContext context) {
    return _Panel(
      icon: Icons.shield_outlined,
      title: 'Privacy',
      children: [
        _ToggleRow(label: 'Read Receipts', sub: 'Let others know when you\'ve seen messages', value: readReceipts, onChanged: onReadReceiptsChanged),
        Divider(height: 1, indent: 20, endIndent: 20, color: Palette.outlineVariant.withValues(alpha: 0.12)),
        _ToggleRow(label: 'Last Seen', sub: 'Show your active status to contacts', value: lastSeen, onChanged: onLastSeenChanged),
        const SizedBox(height: 8),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// NOTIFICATIONS CARD
// ─────────────────────────────────────────────────────────────
class _NotificationsCard extends StatelessWidget {
  const _NotificationsCard({required this.pushAlerts, required this.soundEffects, required this.onPushChanged, required this.onSoundChanged});
  final bool pushAlerts, soundEffects;
  final ValueChanged<bool> onPushChanged, onSoundChanged;
  @override
  Widget build(BuildContext context) {
    return _Panel(
      icon: Icons.notifications_outlined,
      title: 'Notifications',
      children: [
        _ToggleRow(label: 'Push Alerts', sub: 'Instant alerts for new activity', value: pushAlerts, onChanged: onPushChanged),
        Divider(height: 1, indent: 20, endIndent: 20, color: Palette.outlineVariant.withValues(alpha: 0.12)),
        _ToggleRow(label: 'Sound Effects', sub: 'Play sounds for incoming messages', value: soundEffects, onChanged: onSoundChanged),
        const SizedBox(height: 8),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// APPEARANCE CARD
// ─────────────────────────────────────────────────────────────
class _AppearanceCard extends StatelessWidget {
  const _AppearanceCard({required this.themeIndex, required this.onThemeChanged});
  final int themeIndex;
  final ValueChanged<int> onThemeChanged;

  static const _themes = [
    (name: 'LIGHT SILK',    bg: Color(0xFFF8F9FA), fg: Color(0xFFE8EAF6)),
    (name: 'OBSIDIAN BLUE', bg: Color(0xFF0D1A4A), fg: Color(0xFF1A237E)),
    (name: 'MIDNIGHT',      bg: Color(0xFF080F30), fg: Color(0xFF0D1433)),
  ];

  @override
  Widget build(BuildContext context) {
    return _Panel(
      icon: Icons.palette_outlined,
      title: 'Appearance',
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: Row(
            children: List.generate(_themes.length, (i) {
              final t = _themes[i];
              final active = i == themeIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onThemeChanged(i),
                  child: Container(
                    margin: EdgeInsets.only(right: i < _themes.length - 1 ? 10 : 0),
                    height: 90,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [t.bg, t.fg], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: active ? Palette.primary : Palette.outlineVariant.withValues(alpha: 0.20), width: active ? 2 : 1),
                    ),
                    child: Stack(children: [
                      if (active)
                        Positioned(top: 8, right: 8,
                          child: Container(width: 22, height: 22,
                            decoration: const BoxDecoration(color: Palette.primary, shape: BoxShape.circle),
                            child: const Icon(Icons.check_rounded, color: Colors.white, size: 14)),
                        ),
                      // Mock message lines
                      Positioned(bottom: 24, left: 10, right: 10, child: Container(height: 6, decoration: BoxDecoration(color: (i == 0 ? Colors.black : Colors.white).withValues(alpha: 0.15), borderRadius: BorderRadius.circular(3)))),
                      Positioned(bottom: 14, left: 10, right: 24, child: Container(height: 6, decoration: BoxDecoration(color: (i == 0 ? Colors.black : Colors.white).withValues(alpha: 0.10), borderRadius: BorderRadius.circular(3)))),
                      Positioned(
                        bottom: 0, left: 0, right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            color: (i == 0 ? Colors.white : Colors.black).withValues(alpha: 0.12),
                            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(14), bottomRight: Radius.circular(14)),
                          ),
                          child: Text(t.name, textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: i == 0 ? Palette.primary : Colors.white.withValues(alpha: 0.80), letterSpacing: 0.8)),
                        ),
                      ),
                    ]),
                  ),
                ),
              );
            }),
          ),
        ),
        Divider(height: 1, indent: 20, endIndent: 20, color: Palette.outlineVariant.withValues(alpha: 0.12)),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          leading: const Icon(Icons.text_fields_rounded, size: 20, color: Palette.primary),
          title: const Text('Text Interface Scale', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Palette.onSurface)),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            const Text('Default (14px)', style: TextStyle(fontSize: 12, color: Palette.onSurfaceVariant)),
            const SizedBox(width: 4),
            const Icon(Icons.expand_more_rounded, size: 18, color: Palette.outline),
          ]),
          onTap: () {},
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// DEVICES CARD
// ─────────────────────────────────────────────────────────────
class _DevicesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Panel(
      icon: Icons.devices_rounded,
      title: 'Devices',
      children: [
        _DeviceRow(name: 'MacBook Pro 16"', sub: 'ACTIVE NOW • LONDON, UK', icon: Icons.laptop_mac_rounded),
        Divider(height: 1, indent: 64, endIndent: 20, color: Palette.outlineVariant.withValues(alpha: 0.12)),
        _DeviceRow(name: 'iPhone 15 Pro', sub: 'LAST USED 2H AGO', icon: Icons.phone_iphone_rounded),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _DeviceRow extends StatelessWidget {
  const _DeviceRow({required this.name, required this.sub, required this.icon});
  final String name, sub;
  final IconData icon;
  @override Widget build(BuildContext context) => ListTile(
    contentPadding: const EdgeInsets.fromLTRB(20, 6, 20, 6),
    leading: Container(width: 38, height: 38, decoration: BoxDecoration(color: Palette.surfaceContainerHigh, borderRadius: BorderRadius.circular(10)), child: Icon(icon, size: 20, color: Palette.onSurface)),
    title: Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Palette.onSurface)),
    subtitle: Text(sub, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Palette.outline, letterSpacing: 0.5)),
  );
}

// ─────────────────────────────────────────────────────────────
// SUPPORT CARD
// ─────────────────────────────────────────────────────────────
class _SupportCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Panel(
      icon: Icons.help_outline_rounded,
      title: 'Support',
      children: [
        _SupportRow(label: 'Help Center', icon: Icons.open_in_new_rounded),
        Divider(height: 1, indent: 20, endIndent: 20, color: Palette.outlineVariant.withValues(alpha: 0.12)),
        _SupportRow(label: 'Report a Bug', icon: Icons.bug_report_outlined),
        Divider(height: 1, indent: 20, endIndent: 20, color: Palette.outlineVariant.withValues(alpha: 0.12)),
        _SupportRow(label: 'Terms & Privacy', icon: Icons.article_outlined),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _SupportRow extends StatelessWidget {
  const _SupportRow({required this.label, required this.icon});
  final String label;
  final IconData icon;
  @override Widget build(BuildContext context) => ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
    title: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Palette.onSurface)),
    trailing: Icon(icon, size: 16, color: Palette.outline),
    onTap: () {},
  );
}

// ─────────────────────────────────────────────────────────────
// REUSABLE TOGGLE ROW
// ─────────────────────────────────────────────────────────────
class _ToggleRow extends StatelessWidget {
  const _ToggleRow({required this.label, required this.sub, required this.value, required this.onChanged});
  final String label, sub;
  final bool value;
  final ValueChanged<bool> onChanged;
  @override Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 14, 16, 14),
    child: Row(children: [
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Palette.onSurface)),
        const SizedBox(height: 2),
        Text(sub, style: const TextStyle(fontSize: 12, color: Palette.onSurfaceVariant)),
      ])),
      Switch.adaptive(value: value, onChanged: onChanged, activeThumbColor: Palette.primary),
    ]),
  );
}
