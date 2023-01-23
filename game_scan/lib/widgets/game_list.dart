import 'package:flutter/material.dart';
import 'package:game_scan/models/boardgame.dart';
import 'package:game_scan/pages/rap_sheet_page.dart';
import 'package:game_scan/services/game_library_api.dart';

class GameList extends StatefulWidget {
  final List<Boardgame>? boardgames;
  final Future<List<Boardgame>?>? boardgamesFuture;

  const GameList({super.key, this.boardgames, this.boardgamesFuture})
      : assert((boardgames != null || boardgamesFuture != null) &&
            (boardgames == null || boardgamesFuture == null));

  @override
  State<GameList> createState() => _GameListState();
}

class _GameListState extends State<GameList> {
  @override
  Widget build(BuildContext context) {
    return widget.boardgames != null
        ? _boardgameListBuilder(widget.boardgames!)
        : FutureBuilder(
            future: widget.boardgamesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done ||
                  snapshot.hasError) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError || !snapshot.hasData) {
                return Center(
                  child: Column(
                    children: [
                      const Text('Error getting games'),
                      IconButton(
                          onPressed: () => setState(() {}),
                          icon: const Icon(Icons.replay))
                    ],
                  ),
                );
              } else {
                return _boardgameListBuilder(snapshot.data!);
              }
            },
          );
  }

  ListView _boardgameListBuilder(List<Boardgame> boardgames) {
    return ListView.builder(
      itemCount: boardgames.length,
      itemBuilder: (BuildContext context, int index) {
        Boardgame boardgame = boardgames[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
          child: InkWell(
            child: Card(
              child: SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Image.network(boardgame.thumbnail),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${boardgame.title} (${boardgame.releaseYear})',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
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
            onTap: () async {
              int geekID = boardgame.geekID ??
                  (await getBoardGameRapSheet(boardgame.spudID)).geekID!;
              if (mounted) {
                Navigator.of(context).pushNamed(RapSheetPage.route,
                    arguments: RapSheetPageArgs(boardgame.spudID, geekID));
              }
            },
          ),
        );
      },
    );
  }
}
