import 'package:flutter/material.dart';

ThemeData gameScanLightThemeData = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromARGB(255, 0, 43, 69),
    onPrimary: Colors.white,
    secondary: Color.fromARGB(255, 255, 217, 1),
    onSecondary: Colors.black,
    error: Colors.red,
    onError: Colors.white,
    background: Colors.white,
    onBackground: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black,
  ),
  canvasColor: const Color.fromARGB(255, 0, 43, 69),
  scaffoldBackgroundColor: Colors.white,
  unselectedWidgetColor: Colors.white,
);

ThemeData gameScanDarkThemeData = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Color.fromARGB(255, 0, 43, 69),
    onPrimary: Colors.white,
    secondary: Color.fromARGB(255, 255, 217, 1),
    onSecondary: Colors.black,
    error: Colors.red,
    onError: Colors.white,
    background: Color.fromARGB(255, 77, 77, 77),
    onBackground: Colors.white,
    surface: Color.fromARGB(255, 77, 77, 77),
    onSurface: Colors.white,
  ),
  canvasColor: const Color.fromARGB(255, 0, 43, 69),
  scaffoldBackgroundColor: const Color.fromARGB(255, 77, 77, 77),
  unselectedWidgetColor: Colors.white,
);
