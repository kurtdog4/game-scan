import 'package:flutter/material.dart';
import 'package:game_scan/local_storage/search_history.dart';
import 'package:game_scan/models/boardgame.dart';
import 'package:game_scan/widgets/game_list.dart';
import 'package:game_scan/widgets/game_scan_scaffold.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  static const String route = 'history';

  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  @override
  Widget build(BuildContext context) {
    List<Boardgame> boardgames = context.read<SearchHistory>().searchHistory;

    return Hero(
      tag: scaffoldHeroTag,
      child: GameScanScaffold(
        scaffoldPage: ScaffoldPage.history,
        child: boardgames.isEmpty
            ? const Center(child: Text("No Search History Found"))
            : GameList(
                boardgames: boardgames,
              ),
      ),
    );
  }
}
