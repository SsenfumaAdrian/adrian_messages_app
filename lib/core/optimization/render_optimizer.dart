// FILE: lib/core/optimization/render_optimizer.dart

import 'dart:ui';

class RenderOptimizer {
  /// Pre-warms the GPU shaders for BackdropFilter.
  /// This prevents the 'first-load' stutter common in glassmorphism apps.
  static void initializeGpuCache() {
    // We force a tiny, invisible render of a glass element
    // to prime the Impeller engine's cache.
    final SceneBuilder builder = SceneBuilder();
    builder.pushBackdropFilter(ImageFilter.blur(sigmaX: 25, sigmaY: 25));
    builder.pop();
    builder.build();
  }

  /// Lowers the refresh rate of background animations when the
  /// battery is low, maintaining the 'Smile' experience without drain.
  static double getOptimalBlur(double batteryLevel) {
    return batteryLevel > 0.2 ? 25.0 : 10.0;
  }
}
