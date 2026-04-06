// FILE: lib/core/utils/nav_persistence.dart
//
// Persists the last selected MainShell tab so that hot-reload
// and app restart return the user to where they left off.

import 'package:shared_preferences/shared_preferences.dart';

class NavPersistence {
  NavPersistence._();
  static const String _kTabIndex = 'nav_tab_index';
  static const String _kIsLoggedIn = 'is_logged_in';

  static Future<void> saveTab(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kTabIndex, index);
  }

  static Future<int> loadTab() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_kTabIndex) ?? 0;
  }

  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kIsLoggedIn, value);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kIsLoggedIn) ?? false;
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
