import 'package:adrian_messages/core/constants/palette.dart';
import 'package:flutter/material.dart';


class FooterStats extends StatelessWidget {
  const FooterStats({super.key, this.center = false});
  final bool center;

  @override
  Widget build(BuildContext context) {
    final stats = [
      _Stat(icon: Icons.lock_outline, label: "Zero-knowledge", value: "E2E"),
      _Stat(icon: Icons.auto_awesome, label: "AI Assist", value: "On-device"),
      _Stat(icon: Icons.flash_on, label: "Latency", value: "<20ms"),
    ];

    return Wrap(
      spacing: 28,
      runSpacing: 12,
      alignment: center ? WrapAlignment.center : WrapAlignment.start,
      children: stats
          .map((s) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(s.icon, size: 16, color: Palette.accentCyan),
                  const SizedBox(width: 8),
                  Text(
                    "${s.label} — ${s.value}",
                    style: const TextStyle(
                      color: Palette.textMuted,
                      fontFamily: 'Inter-Medium',
                      fontSize: 12,
                    ),
                  ),
                ],
              ))
          .toList(),
    );
  }
}

class _Stat {
  final IconData icon;
  final String label;
  final String value;

  const _Stat({required this.icon, required this.label, required this.value});
}
