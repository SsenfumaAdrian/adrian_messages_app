// FILE: lib/core/utils/smile_haptics_controller.dart

import 'package:flutter/services.dart';

class SmileHaptics {
  /// A light 'pop' sensation for when a glass sticker is sent or received.
  static void stickerPop() {
    HapticFeedback.lightImpact();
  }

  /// A tactile 'scrolling' feel for the Analytics Dashboard.
  static void dataScroll() {
    HapticFeedback.selectionClick();
  }

  /// The 'Stitch Complete' sequence: a double-pulse confirming data merge.
  static void stitchSuccess() async {
    await HapticFeedback.mediumImpact();
    await Future.delayed(Duration(milliseconds: 80));
    await HapticFeedback.lightImpact();
  }
}
