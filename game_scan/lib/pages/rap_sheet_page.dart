import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:game_scan/local_storage/search_history.dart';
import 'package:game_scan/models/bgg_boardgame.dart';
import 'package:game_scan/models/boardgame.dart';
import 'package:game_scan/services/bgg_api.dart';
import 'package:game_scan/services/game_library_api.dart';
import 'package:game_scan/widgets/game_scan_app_bar.dart';
import 'package:provider/provider.dart';

class RapSheetPageArgs {
  final int spudID;
  final int geekID;

  RapSheetPageArgs(this.spudID, this.geekID);
}

class RapSheetPage extends StatefulWidget {
  static const String route = 'rap-sheet';
  final int spudID;
  final int geekID;

  const RapSheetPage(this.spudID, this.geekID, {Key? key}) : super(key: key);

  @override
  State<RapSheetPage> createState() => _RapSheetPageState();
}

class _RapSheetPageState extends State<RapSheetPage> {
  late Future<Boardgame> _boardgame;
  late Future<BGGBoardgame> _bggBoardgame;

  @override
  void initState() {
    _boardgame = getBoardGameRapSheet(widget.spudID);
    _boardgame.then((Boardgame boardgame) {
      context.read<SearchHistory>().addToSearchHistory(boardgame);
    });
    _bggBoardgame = getBGGBoardGameData(widget.geekID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gameScanAppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: FutureBuilder(
        future: _bggBoardgame,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            BGGBoardgame boardgame = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      SizedBox.expand(
                        child: Image.network(
                          fit: BoxFit.cover,
                          boardgame.thumbnail,
                          color: Colors.black.withOpacity(.8),
                          colorBlendMode: BlendMode.darken,
                        ),
                      ),
                      SizedBox.expand(
                        child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        '${boardgame.name} (${boardgame.yearPublished})',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 26.0,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Expanded(
                                      child: Image.network(boardgame.thumbnail),
                                    ),
                                    const SizedBox(height: 8),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text.rich(
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.grey),
                                            TextSpan(
                                              children: [
                                                const TextSpan(
                                                  text: 'Designer: ',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                for (int i = 0;
                                                    i <
                                                        boardgame.designers
                                                                .length -
                                                            1;
                                                    ++i)
                                                  TextSpan(
                                                      text:
                                                          '${boardgame.designers.elementAt(i)}, '),
                                                TextSpan(
                                                    text: boardgame
                                                        .designers.last),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text.rich(
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.grey),
                                            TextSpan(
                                              children: [
                                                const TextSpan(
                                                  text: 'Artist: ',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                for (int i = 0;
                                                    i <
                                                        boardgame.artists
                                                                .length -
                                                            1;
                                                    ++i)
                                                  TextSpan(
                                                      text:
                                                          '${boardgame.artists.elementAt(i)}, '),
                                                TextSpan(
                                                    text:
                                                        boardgame.artists.last),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text.rich(
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.grey),
                                            TextSpan(
                                              children: [
                                                const TextSpan(
                                                  text: 'Publisher: ',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                for (int i = 0;
                                                    i <
                                                        boardgame.publishers
                                                                .length -
                                                            1;
                                                    ++i)
                                                  TextSpan(
                                                      text:
                                                          '${boardgame.publishers.elementAt(i)}, '),
                                                TextSpan(
                                                    text: boardgame
                                                        .publishers.last),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 120,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                    color: Colors.white,
                                                    width: 1),
                                                right: BorderSide(
                                                    color: Colors.white,
                                                    width: .5),
                                                bottom: BorderSide(
                                                    color: Colors.white,
                                                    width: .5),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    Icon(
                                                      Icons.groups,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      'Players',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  '${boardgame.minPlayers} - ${boardgame.maxPlayers}',
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                    color: Colors.white,
                                                    width: .5),
                                                right: BorderSide(
                                                    color: Colors.white,
                                                    width: .5),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    Icon(
                                                      Icons.supervisor_account,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(width: 4),
                                                    Text(
                                                      'Age',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  '${boardgame.age}+',
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                    color: Colors.white,
                                                    width: 1),
                                                left: BorderSide(
                                                    color: Colors.white,
                                                    width: .5),
                                                bottom: BorderSide(
                                                    color: Colors.white,
                                                    width: .5),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    SizedBox(
                                                      width: 24,
                                                      height: 24,
                                                      child: Icon(
                                                        Icons.hourglass_bottom,
                                                        size: 20,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    SizedBox(width: 4),
                                                    Text(
                                                      'Playing Time',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  boardgame.maxPlayTime !=
                                                          boardgame.minPlayTime
                                                      ? '${boardgame.minPlayTime} - ${boardgame.maxPlayTime}'
                                                      : '${boardgame.playingTime}',
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                    color: Colors.white,
                                                    width: .5),
                                                left: BorderSide(
                                                    color: Colors.white,
                                                    width: 1),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    SizedBox(
                                                      width: 24,
                                                      height: 24,
                                                      child: Icon(
                                                        Icons.scale,
                                                        size: 18,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    SizedBox(width: 4),
                                                    Text(
                                                      'Weight',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                                FutureBuilder(
                                                  future: _boardgame,
                                                  builder:
                                                      ((context, snapshot) {
                                                    if (!snapshot.hasData) {
                                                      return const SizedBox(
                                                        height: 14,
                                                        width: 14,
                                                        child:
                                                            CircularProgressIndicator(
                                                                strokeWidth: 2,
                                                                color: Colors
                                                                    .white),
                                                      );
                                                    } else if (snapshot
                                                        .hasError) {
                                                      return const Text(
                                                          'Error');
                                                    } else {
                                                      return Text(
                                                        '${snapshot.data!.geekWeight}',
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      );
                                                    }
                                                  }),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    child: Html(data: boardgame.description),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
