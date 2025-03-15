import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadTheme(); // ✅ استدعاء التحميل عند الإنشاء
  }

  /// تبديل الوضع الليلي وحفظه
  Future<void> toggleTheme(bool value) async {
    _isDarkMode = value;
    notifyListeners();
    await _saveTheme(value); // ✅ حفظ التغيير
  }

  /// تعيين الوضع الليلي من `main.dart`
  void setDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  /// تحميل الثيم المحفوظ من `SharedPreferences`
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  /// حفظ الثيم في `SharedPreferences`
  Future<void> _saveTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
  }
}
