// FILE: lib/features/analytics/stitch_insights.dart

import 'package:flutter/material.dart';

class StitchInsights {
  /// Analyzes dummy data to find the most 'Stitched' topics.
  static Map<String, int> getTopTopics() {
    // In a real scenario, this would use NLP on the 'content' field
    return {
      "Project Alpha": 12,
      "Design Feedback": 8,
      "Vacation Planning": 5,
    };
  }

  /// Visualizes the 'Emotional Tone' of a Stitch (Liquid Sentiment).
  static Color getStitchMood(String text) {
    if (text.contains("incredible") || text.contains("smile")) {
      return Colors.amberAccent; // Happy/Warm
    }
    return Colors.blueAccent; // Calm/Professional
  }
}
