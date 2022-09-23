import 'package:flutter/material.dart';
import 'package:game_scan/pages/browse_page.dart';
import 'package:game_scan/pages/game_scan_page.dart';
import 'package:game_scan/pages/history_page.dart';
import 'package:game_scan/pages/rulesbot_page.dart';
import 'package:game_scan/pages/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GameScan',
      themeMode: ThemeMode.light,
      theme: ThemeData(
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
      ),
      darkTheme: ThemeData(
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
      ),
      initialRoute: SearchPage.route,
      onGenerateRoute: (RouteSettings settings) {
        var routes = {
          SearchPage.route: (context) => const SearchPage(),
          HistoryPage.route: (context) => const HistoryPage(),
          BrowsePage.route: (context) => const BrowsePage(),
          RulesbotPage.route: (context) => const RulesbotPage(),
          GameScanPage.route: (context) => const GameScanPage(),
        };
        return MaterialPageRoute(
          builder: routes[settings.name]!,
          settings: settings,
        );
      },
    );
  }
}
