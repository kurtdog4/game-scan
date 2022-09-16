import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:game_scan/landing_page.dart';

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
      initialRoute: LandingPage.route,
      onGenerateRoute: (RouteSettings settings) {
        var routes = {
          LandingPage.route: (context) => const LandingPage(),
        };
        return MaterialPageRoute(
          builder: routes[settings.name]!,
          settings: settings,
        );
      },
    );
  }
}
