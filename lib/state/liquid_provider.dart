// FILE: lib/core/state/liquid_provider.dart

import 'package:flutter/material.dart';
import '../../data/mock/dummy_data.dart';

class LiquidProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _chats = DummyData.chatList;
  List<String> _selectedForStitch = [];

  List<Map<String, dynamic>> get chats => _chats;
  List<String> get selectedForStitch => _selectedForStitch;

  void toggleMessageSelection(String id) {
    if (_selectedForStitch.contains(id)) {
      _selectedForStitch.remove(id);
    } else {
      _selectedForStitch.add(id);
    }
    notifyListeners(); // Causes the glass UI to 'ripple' and update
  }

  void clearSelection() {
    _selectedForStitch.clear();
    notifyListeners();
  }
}
