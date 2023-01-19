import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_scan/pages/browse_page.dart';
import 'package:game_scan/pages/game_scan_page.dart';
import 'package:game_scan/pages/history_page.dart';
import 'package:game_scan/pages/rulesbot_page.dart';
import 'package:game_scan/pages/search_page.dart';
import 'package:game_scan/widgets/game_scan_app_bar.dart';
import 'package:game_scan/widgets/game_scan_settings_button.dart';

enum ScaffoldPage {
  history,
  search,
  empty,
  browse,
  rulesbot,
}

const String scaffoldHeroTag = "ScaffoldHeroTag";

class GameScanScaffold extends StatefulWidget {
  final ScaffoldPage scaffoldPage;
  final Widget child;

  @override
  State<GameScanScaffold> createState() => _GameScanScaffoldState();

  const GameScanScaffold({
    required this.scaffoldPage,
    required this.child,
    Key? key,
  }) : super(key: key);
}

class _GameScanScaffoldState extends State<GameScanScaffold> {
  @override
  Widget build(BuildContext build) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: gameScanAppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Image.asset("assets/GSLogoWhite.png"),
          ),
        ),
      ),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: widget.scaffoldPage.index,
        onTap: _bottomNavBarTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        child: const Icon(Icons.camera_alt),
        onPressed: () => Navigator.of(context).pushNamed(GameScanPage.route),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
    );
  }

  void _bottomNavBarTap(int index) {
    ScaffoldPage scaffoldPage = ScaffoldPage.values[index];
    if (scaffoldPage == widget.scaffoldPage) {
      return;
    }
    switch (scaffoldPage) {
      case ScaffoldPage.history:
        Navigator.of(context).pushNamed(HistoryPage.route);
        break;
      case ScaffoldPage.search:
        Navigator.of(context).pushNamed(SearchPage.route);
        break;
      case ScaffoldPage.browse:
        Navigator.of(context).pushNamed(BrowsePage.route);
        break;
      case ScaffoldPage.rulesbot:
        Navigator.of(context).pushNamed(RulesbotPage.route);
        break;
      default:
        break;
    }
    return;
  }
}
