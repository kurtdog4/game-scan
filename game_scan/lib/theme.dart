import 'package:flutter/material.dart';

ThemeData gameScanLightThemeData = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: Colors.white,
    secondary: Colors.blue,
  ),
  scaffoldBackgroundColor: Colors.grey[175],
);

ThemeData gameScanDarkThemeData = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: Colors.white,
    surface: Colors.grey[850]!,
    secondary: Colors.blue,
  ),
);
