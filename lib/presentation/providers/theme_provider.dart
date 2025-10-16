import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeProvider with ChangeNotifier {
  final Box _settingsBox = Hive.box('settings');
  late bool _isDarkMode;

  ThemeProvider() {
    _isDarkMode = _settingsBox.get('isDarkMode', defaultValue: false);
  }

  bool get isDarkMode => _isDarkMode;

  ThemeMode get currentThemeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _settingsBox.put('isDarkMode', _isDarkMode);
    notifyListeners();
  }
}