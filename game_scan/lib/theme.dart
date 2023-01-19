import 'package:flutter/material.dart';

var primary = Colors.blue.shade800;
var secondary = Colors.yellow.shade600;
var greyBackground = const Color.fromARGB(255, 77, 77, 77);

ThemeData gameScanLightThemeData = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: Colors.white,
    secondary: secondary,
    onSecondary: Colors.black,
    error: Colors.red,
    onError: Colors.white,
    background: Colors.white,
    onBackground: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black,
  ),
  canvasColor: primary,
  scaffoldBackgroundColor: Colors.white,
  unselectedWidgetColor: Colors.white,
);

ThemeData gameScanDarkThemeData = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: primary,
    onPrimary: Colors.white,
    secondary: secondary,
    onSecondary: Colors.black,
    error: Colors.red,
    onError: Colors.white,
    background: greyBackground,
    onBackground: Colors.white,
    surface: primary,
    onSurface: Colors.white,
  ),
  canvasColor: primary,
  scaffoldBackgroundColor: greyBackground,
  unselectedWidgetColor: Colors.white,
);
