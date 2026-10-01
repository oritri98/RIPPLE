import 'package:flutter/material.dart';

enum AppThemeMode {
  light,
  dark,
}

class ThemeManager extends ChangeNotifier {
  static final ThemeManager instance = ThemeManager._internal();
  ThemeManager._internal();

  // Default to Apple Silicon Liquid Glass light mode as requested
  AppThemeMode _currentMode = AppThemeMode.light;

  AppThemeMode get currentMode => _currentMode;
  bool get isLight => _currentMode == AppThemeMode.light;
  bool get isDark => _currentMode == AppThemeMode.dark;

  void toggleTheme() {
    _currentMode = isLight ? AppThemeMode.dark : AppThemeMode.light;
    notifyListeners();
  }

  void setTheme(AppThemeMode mode) {
    if (_currentMode != mode) {
      _currentMode = mode;
      notifyListeners();
    }
  }
}
