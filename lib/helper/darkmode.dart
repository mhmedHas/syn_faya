import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkMode = false;
  Locale _locale = Locale('ar');

  Locale get locale => _locale;

  void toggleLocale() {
    if (_locale.languageCode == 'ar') {
      _locale = Locale('en');
    } else {
      _locale = Locale('ar');
    }
    notifyListeners();
  }

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}
