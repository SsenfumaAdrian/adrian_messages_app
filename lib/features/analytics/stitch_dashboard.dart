// FILE: lib/features/analytics/stitch_dashboard.dart

import 'package:flutter/material.dart';
import '../../ui/components/liquid_glass_container.dart';
import 'stitch_insights.dart';

class StitchAnalyticsDashboard extends StatelessWidget {
  const StitchAnalyticsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final insights = StitchInsights.getTopTopics();

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0E),
      appBar: AppBar(
        title: const Text("STITCH INSIGHTS",
            style: TextStyle(
                fontFamily: 'Inter-Bold', letterSpacing: 1.5, fontSize: 18)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("TOPIC DENSITY",
                style: TextStyle(
                    color: Colors.white38, fontSize: 12, letterSpacing: 2)),
            const SizedBox(height: 24),
            // Glass Bar Chart mapping topics to frequency
            ...insights.entries
                .map((entry) => _buildAnalyticsBar(entry.key, entry.value))
                ,

            const SizedBox(height: 48),
            const LiquidGlassContainer(
              borderRadius: 24,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(Icons.psychology_outlined,
                      color: Colors.blueAccent, size: 32),
                  SizedBox(height: 16),
                  Text("Predictive Insight",
                      style: TextStyle(fontFamily: 'Inter-Bold', fontSize: 16)),
                  SizedBox(height: 8),
                  Text(
                    "You've discussed 'Project Alpha' across 3 different threads. Stitch them into a single briefing?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 13, color: Colors.white70, height: 1.5),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsBar(String label, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: const TextStyle(fontSize: 14, color: Colors.white)),
              Text("$count",
                  style:
                      const TextStyle(fontSize: 14, color: Colors.blueAccent)),
            ],
          ),
          const SizedBox(height: 8),
          Stack(
            children: [
              Container(
                  height: 6,
                  decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(3))),
              AnimatedContainer(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
                height: 6,
                width: count * 15.0, // Dynamic scaling for visualization
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Colors.blueAccent, Colors.cyanAccent]),
                  borderRadius: BorderRadius.circular(3),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.4),
                        blurRadius: 10)
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
