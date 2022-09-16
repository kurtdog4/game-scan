import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:game_scan/pages/browse_page.dart';
import 'package:game_scan/pages/history_page.dart';
import 'package:game_scan/pages/rulesbot_page.dart';
import 'package:game_scan/pages/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GameScan',
      theme: ThemeData(
        // colorScheme: ColorScheme(
        //   primary: const Color.fromRGBO(19, 121, 187, 1),
        //   secondary: const Color.fromARGB(255, 255, 217, 1),
        // ),
        // primaryColor: const Color.fromRGBO(19, 121, 187, 1),
        primaryColor: Color.fromARGB(255, 41, 41, 41),
        accentColor: const Color.fromARGB(255, 255, 217, 1),
      ),
      initialRoute: SearchPage.route,
      onGenerateRoute: (RouteSettings settings) {
        var routes = {
          SearchPage.route: (context) => const SearchPage(),
          HistoryPage.route: (context) => const HistoryPage(),
          BrowsePage.route: (context) => const BrowsePage(),
          RulesbotPage.route: (context) => const RulesbotPage(),
        };
        return MaterialPageRoute(
          builder: routes[settings.name]!,
          settings: settings,
        );
      },
    );
  }
}
