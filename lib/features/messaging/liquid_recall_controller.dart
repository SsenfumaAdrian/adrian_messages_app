// FILE: lib/features/messaging/liquid_recall_controller.dart

import 'package:flutter/material.dart';

enum MessageState { visible, dissolving, crystallized }

class LiquidRecallController extends ChangeNotifier {
  // Map of Message ID to its current 'Physical' state
  final Map<String, MessageState> _messageStates = {};

  MessageState getState(String id) =>
      _messageStates[id] ?? MessageState.visible;

  /// Initiates the 'Molecular Dissolution' of a message.
  /// This is the premium version of 'Unsend'.
  void dissolveMessage(String id) async {
    _messageStates[id] = MessageState.dissolving;
    notifyListeners();

    // The 'Melt' duration - 1.5 seconds of refractive fading
    await Future.delayed(const Duration(milliseconds: 1500));

    _messageStates[id] = MessageState.crystallized;
    notifyListeners();
  }
}
