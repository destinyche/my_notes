import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
    brightness: Brightness.light,
    // textTheme: TextTheme(titleLarge: TextStyle(color: )),
    colorScheme: ColorScheme.light(
      primary: Colors.black,
      secondary: const Color(0xFFFFEB3B),
      background: Colors.grey.shade100,
      primaryContainer: Colors.black12,
    ));

ThemeData darkMode = ThemeData(
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF424242)),
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Colors.white,
      secondary: Color(0xFFFFEB3B),
      background: Color(0xFF303030),
      primaryContainer: Colors.white10,
    ));
