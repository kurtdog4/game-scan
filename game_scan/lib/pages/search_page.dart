import 'package:flutter/material.dart';
import 'package:game_scan/models/boardgame.dart';
import 'package:game_scan/services/game_library_api.dart';
import 'package:game_scan/widgets/game_list.dart';

import 'package:game_scan/widgets/game_scan_scaffold.dart';

class SearchPage extends StatefulWidget {
  static const String route = 'search';

  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchbarTextController =
      TextEditingController();
  Future<List<Boardgame>?> _boardgames = getTopGames();

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: scaffoldHeroTag,
      child: GameScanScaffold(
        scaffoldPage: ScaffoldPage.search,
        child: Center(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextField(
                  controller: _searchbarTextController,
                  cursorColor: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    labelText: 'Search',
                    labelStyle: TextStyle(color: Colors.grey.shade400),
                    fillColor: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey.shade200
                        : Colors.grey.shade800,
                    filled: true,
                    focusColor: Colors.red,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    isCollapsed: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  ),
                  onChanged: (value) => setState(() {
                    _boardgames =
                        value == "" ? getTopGames() : searchForGame(value);
                  }),
                ),
              ),
              Expanded(
                child: GameList(boardgamesFuture: _boardgames),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
