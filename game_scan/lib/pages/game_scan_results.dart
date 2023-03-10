import 'package:flutter/material.dart';
import 'package:game_scan/models/boardgame.dart';
import 'package:game_scan/widgets/game_list.dart';
import 'package:game_scan/widgets/game_scan_scaffold.dart';

class GameScanResultsPageArgs {
  final Future<List<Boardgame>?>? boardgamesFuture;

  GameScanResultsPageArgs(this.boardgamesFuture);
}

class GameScanResultsPage extends StatefulWidget {
  static const String route = 'game-scan-results';
  final Future<List<Boardgame>?>? boardgamesFuture;

  const GameScanResultsPage(this.boardgamesFuture, {super.key});

  @override
  State<GameScanResultsPage> createState() => _GameScanResults();
}

class _GameScanResults extends State<GameScanResultsPage> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: scaffoldHeroTag,
      child: GameScanScaffold(
        scaffoldPage: ScaffoldPage.search,
        child: GameList(boardgamesFuture: widget.boardgamesFuture),
      ),
    );
  }
}
