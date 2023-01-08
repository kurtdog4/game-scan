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
  final TextEditingController _searchController = TextEditingController();
  Future<List<Boardgame>?> Function() _getBoardgamesFunc = () => getTopGames();

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
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Search",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        _getBoardgamesFunc = _searchController.text == ""
                            ? () => getTopGames()
                            : () => searchForGame(_searchController.text);
                        setState(() {});
                      },
                    ),
                  ),
                  onSubmitted: (value) {
                    _getBoardgamesFunc = _searchController.text == ""
                        ? () => getTopGames()
                        : () => searchForGame(_searchController.text);
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: GameList(getBoardgamesFunc: _getBoardgamesFunc),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
