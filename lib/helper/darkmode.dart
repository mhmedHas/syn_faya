import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkMode = false;
  Locale _locale = const Locale('ar');

  Locale get locale => _locale;

  void toggleLocale() {
    if (_locale.languageCode == 'ar') {
      _locale = const Locale('en');
    } else {
      _locale = const Locale('ar');
    }
    notifyListeners();
  }

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}
