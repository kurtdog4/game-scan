import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'package:game_scan/widgets/game_scan_scaffold.dart';
import 'package:game_scan/services/bgg_api.dart';
import 'package:xml/xml.dart';

class SearchPage extends StatefulWidget {
  static const String route = 'search-page-route';

  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<Future<Response>> _boardGames = [
    http.get(Uri.parse(getGloomhavenInfo)),
    http.get(Uri.parse(getBrassBirminghamInfo)),
    http.get(Uri.parse(getPandemicLegacyS1Info)),
    http.get(Uri.parse(getArkNovaInfo)),
  ];

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
                    // fillColor: Colors.white,
                    // fillColor: Color.fromARGB(255, 77, 77, 77),
                    labelText: "Search",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () => null,
                    ),
                  ),
                ),
              ),
              _gameListBuilder(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _gameListBuilder(BuildContext context) {
    return FutureBuilder(
        future: Future.wait(_boardGames),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done ||
              snapshot.hasError ||
              !snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Expanded(
              child: ListView.builder(
                itemCount: _boardGames.length,
                itemBuilder: (BuildContext context, int index) {
                  var boardGameXml =
                      XmlDocument.parse(snapshot.data![index].body);
                  // String boardGameName = boardGameXml.findAllElements('name').firstWhere((element) => element.attributes.where((p0) => false))
                  String boardGameName = boardGameXml
                      .findAllElements('name')
                      .firstWhere((element) =>
                          element.getAttribute('primary') == "true")
                      .innerText;
                  String boardGameThumbnail =
                      boardGameXml.findAllElements('thumbnail').first.innerText;
                  String boardGameDescription = boardGameXml
                      .findAllElements('description')
                      .first
                      .innerText;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2),
                    child: Card(
                      child: SizedBox(
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: Image.network(boardGameThumbnail),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      boardGameName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Expanded(
                                      child: Text(
                                        boardGameDescription,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        });
  }
}
