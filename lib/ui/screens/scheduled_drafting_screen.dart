// FILE: lib/ui/screens/scheduled_drafting_screen.dart
import 'package:flutter/material.dart';

import '../../core/constants/palette.dart';
import '../../core/navigation/liquid_router.dart';
import '../components/app_shell.dart';
import '../components/shared_widgets.dart';

class ScheduledDraftingScreen extends StatelessWidget {
  const ScheduledDraftingScreen({super.key});

  // Records: (title, time, icon) — Dart 3 record syntax
  static const _items = [
    (title: 'Team Meeting Follow-up', time: 'Today 3:00 PM',    icon: Icons.schedule_rounded),
    (title: 'Weekly Digest',          time: 'Tomorrow 9:00 AM', icon: Icons.calendar_today_rounded),
    (title: 'Project Update',         time: 'Friday 10:00 AM',  icon: Icons.update_rounded),
    (title: 'Client Check-in',        time: 'Mon 11:00 AM',     icon: Icons.handshake_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return AppShell(
      activeRoute: LiquidRouter.scheduledDraft,
      title: 'Scheduled & AI Drafting',
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── AI draft card ─────────────────────────────────
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Palette.primary,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Palette.primary.withValues(alpha: 0.28),
                    blurRadius: 24,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(children: [
                    Icon(Icons.auto_awesome,
                        color: Palette.accentCyan, size: 18),
                    SizedBox(width: 8),
                    Text('AI Draft Ready',
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        )),
                  ]),
                  const SizedBox(height: 10),
                  const Text(
                    '"Team, the Q4 report is attached. Please review by '
                    'Friday and share feedback before our sync."',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      height: 1.5,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 11),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text('Use Draft',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Palette.primary,
                                  fontSize: 13,
                                )),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 11),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text('Edit',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 13,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Scheduled timeline ────────────────────────────
            const SectionTitle('Scheduled Timeline'),
            const SizedBox(height: 12),
            ..._items.map(
              (s) => Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Palette.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Palette.primary.withValues(alpha: 0.04),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(children: [
                  Container(
                    width: 42, height: 42,
                    decoration: BoxDecoration(
                      color: Palette.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Icon(s.icon, color: Palette.primary, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              color: Palette.onSurface,
                            )),
                        Text(s.time,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Palette.accentCyan,
                              fontWeight: FontWeight.w600,
                            )),
                      ],
                    ),
                  ),
                  const Icon(Icons.more_vert_rounded,
                      color: Palette.outline, size: 18),
                ]),
              ),
            ),
            const SizedBox(height: 24),

            GradientButton(
              label: 'Schedule New Message',
              icon: Icons.add_rounded,
              onTap: () {},
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
