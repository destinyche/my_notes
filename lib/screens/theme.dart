import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    appBarTheme: AppBarTheme(backgroundColor: Color(0xFF6200EA)),
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF6200EA),
      secondary: Color(0xFF03DAC5),
      background: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFBB86FC),
    ));

ThemeData darkMode = ThemeData(
    appBarTheme: AppBarTheme(backgroundColor: Color(0xFF1F1B24)),
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFBB86FC),
      secondary: Color(0xFF03DAC5),
      background: Color(0xFF121212),
      primaryContainer: Color(0xFF3700B3),
    ));
