import 'package:flutter/material.dart';
import 'package:chat_app/themes/light_mode.dart';
import 'package:chat_app/themes/dark_mode.dart';

class ThemeProvider extends ChangeNotifier {
  // Initially set to light mode
  int _themeMode = 0; // 0 for light, 1 for dark

  int get themeMode => _themeMode;

  ThemeData get currentTheme {
    return _themeMode == 0 ? lightMode : darkMode;
  }

  bool get isDarkMode => _themeMode == 1;

  // Toggle theme
  void toggleTheme() {
    _themeMode = _themeMode == 0 ? 1 : 0;
    notifyListeners();
  }

  // Set specific theme
  void setTheme(int themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }
}
