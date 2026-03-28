// FILE: lib/core/events/liquid_event_dispatcher.dart

import 'dart:async';

enum LiquidEventType {
  stitchCreated,
  messageRecalled,
  vaultLocked,
  themeShifted
}

class LiquidEvent {
  final LiquidEventType type;
  final dynamic data;
  final DateTime timestamp;

  LiquidEvent(this.type, this.data) : timestamp = DateTime.now();
}

class LiquidEventDispatcher {
  // Broadcaster for app-wide 'Liquid' events
  static final StreamController<LiquidEvent> _controller =
      StreamController<LiquidEvent>.broadcast();

  static Stream<LiquidEvent> get eventStream => _controller.stream;

  /// Dispatches a new event to all 'Stitched' listeners.
  static void dispatch(LiquidEventType type, dynamic data) {
    _controller.add(LiquidEvent(type, data));
  }

  static void dispose() {
    _controller.close();
  }
}
