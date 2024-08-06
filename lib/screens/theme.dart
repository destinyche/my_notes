import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    appBarTheme: AppBarTheme(backgroundColor: Color(0xFFFFC107)),
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFFFFC107),
      secondary: Color(0xFFFFEB3B),
      background: Color(0xFFFFF9C4),
      primaryContainer: Color(0xFFFFE082),
    ));

ThemeData darkMode = ThemeData(
    appBarTheme: AppBarTheme(backgroundColor: Color(0xFF424242)),
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFFFC107),
      secondary: Color(0xFFFFEB3B),
      background: Color(0xFF303030),
      primaryContainer: Color(0x10FFF9C4),
    ));
