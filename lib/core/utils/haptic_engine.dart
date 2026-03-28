// FILE: lib/core/utils/haptic_engine.dart

import 'package:flutter/services.dart';

class LiquidHaptics {
  /// Simulates the light 'click' of glass.
  static void lightTap() {
    HapticFeedback.lightImpact();
  }

  /// Simulates a liquid ripple sensation.
  static void rippleFeedback() {
    HapticFeedback.mediumImpact();
  }

  /// Triggered when a 'Stitch' is completed.
  static void successPulse() {
    HapticFeedback.vibrate();
  }
}
