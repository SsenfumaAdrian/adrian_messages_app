import 'package:adrian_messages/core/constants/palette.dart';
import 'package:flutter/material.dart';

class FooterStats extends StatelessWidget {
  const FooterStats({super.key, this.center = false});
  final bool center;

  @override
  Widget build(BuildContext context) {
    final stats = [
      const _Stat(title: "256-bit", subtitle: "Encryption"),
      const _Stat(title: "Zero-Knowledge", subtitle: "Architecture"),
    ];

    return Wrap(
      spacing: 28,
      runSpacing: 12,
      alignment: center ? WrapAlignment.center : WrapAlignment.start,
      children: stats
          .map(
            (s) => Column(
              crossAxisAlignment: center
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  s.title,
                  style: const TextStyle(
                    color: Palette.textPrimary,
                    fontFamily: 'Inter-Bold',
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  s.subtitle,
                  style: const TextStyle(
                    color: Palette.textMuted,
                    fontFamily: 'Inter-Medium',
                    fontSize: 11.5,
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}

class _Stat {
  final String title;
  final String subtitle;

  const _Stat({required this.title, required this.subtitle});
}
