import 'package:flutter/material.dart';
import 'package:my_notes/screens/theme_dark.dart';
import 'package:my_notes/screens/theme_light.dart';

class ThemeProvider extends ChangeNotifier {
  

  ThemeData _themeData = darkMode;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == darkMode) {
      themeData = lightMode;
    } else {
      themeData = darkMode;
    }
  }
}



