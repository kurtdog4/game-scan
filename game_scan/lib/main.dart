import 'package:flutter/material.dart';
import 'package:game_scan/local_storage/search_history.dart';
import 'package:game_scan/pages/browse_page.dart';
import 'package:game_scan/pages/game_scan_page.dart';
import 'package:game_scan/pages/history_page.dart';
import 'package:game_scan/pages/rap_sheet_page.dart';
import 'package:game_scan/pages/rulesbot_page.dart';
import 'package:game_scan/pages/search_page.dart';
import 'package:game_scan/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create:(context) => SearchHistory(),
      lazy: false,
      child: MaterialApp(
        title: 'GameScan',
        themeMode: ThemeMode.light,
        theme: gameScanLightThemeData,
        darkTheme: gameScanDarkThemeData,
        initialRoute: SearchPage.route,
        onGenerateRoute: (RouteSettings settings) {
          var routes = {
            SearchPage.route: const SearchPage(),
            HistoryPage.route: const HistoryPage(),
            BrowsePage.route: const BrowsePage(),
            RulesbotPage.route: const RulesbotPage(),
            GameScanPage.route: const GameScanPage(),
          };
          return MaterialPageRoute(
            builder: (context) {
              if (settings.name == RapSheetPage.route) {
                RapSheetPageArgs rapSheetPageArgs =
                    settings.arguments as RapSheetPageArgs;
                return RapSheetPage(rapSheetPageArgs.spudID);
              } else {
                return routes[settings.name]!;
              }
            },
            settings: settings,
          );
        },
      ),
    );
  }
}
