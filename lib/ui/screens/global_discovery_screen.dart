// FILE: lib/ui/screens/global_discovery_screen.dart
import 'package:flutter/material.dart';

import '../../core/constants/palette.dart';
import '../components/app_scaffold.dart';

class GlobalDiscoveryScreen extends StatelessWidget {
  const GlobalDiscoveryScreen({super.key});

  static const _trending = [
    'Q4 Strategy',
    'New Design System',
    'Platform Launch',
    'Team Offsite',
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Global Discovery',
      showBack: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── AI search bar ─────────────────────────────────
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Palette.primary, Color(0xFF163A72)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(children: [
                Icon(Icons.auto_awesome, color: Palette.accentCyan, size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Search across your digital estate...',
                    style: TextStyle(color: Colors.white54, fontSize: 14),
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 24),

            // ── AI context ────────────────────────────────────
            Text(
              'AI Context',
              style: TextStyle(
                fontFamily: Palette.fontDisplay,
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Palette.primary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'It looks like you\'re preparing for the Q4 Strategy Sync.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Palette.onSurface,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 20),

            // ── Discovery cards grid ──────────────────────────
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.4,
              children: const [
                _DiscoverCard(
                  title: 'Related Messages',
                  count: '24',
                  icon: Icons.chat_bubble_outline_rounded,
                ),
                _DiscoverCard(
                  title: 'Shared Files',
                  count: '8',
                  icon: Icons.attach_file_rounded,
                ),
                _DiscoverCard(
                  title: 'People Mentioned',
                  count: '5',
                  icon: Icons.people_outline_rounded,
                ),
                _DiscoverCard(
                  title: 'Action Items',
                  count: '12',
                  icon: Icons.task_alt_rounded,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ── Trending topics ───────────────────────────────
            Text(
              'Trending in Your Circles',
              style: TextStyle(
                fontFamily: Palette.fontDisplay,
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Palette.primary,
              ),
            ),
            const SizedBox(height: 12),
            ..._trending.map(
              (t) => Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Palette.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x0A1A237E),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(children: [
                  Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(
                      color: Palette.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.trending_up_rounded,
                      color: Palette.primary,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      t,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Palette.onSurface,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12,
                    color: Palette.outline,
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// DISCOVERY CARD
// ─────────────────────────────────────────────────────────────
class _DiscoverCard extends StatelessWidget {
  const _DiscoverCard({
    required this.title,
    required this.count,
    required this.icon,
  });

  final String title;
  final String count;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Palette.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Color(0x0A1A237E),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: Palette.primary, size: 22),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                count,
                style: TextStyle(
                  fontFamily: Palette.fontDisplay,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Palette.onSurface,
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  color: Palette.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
