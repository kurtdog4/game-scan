import 'dart:io';

import 'package:flutter/material.dart';
import 'package:game_scan/local_storage/search_history.dart';
import 'package:game_scan/models/boardgame.dart';
import 'package:game_scan/services/game_library_api.dart';
import 'package:game_scan/widgets/game_scan_back_button.dart';
import 'package:game_scan/widgets/game_scan_settings_button.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RapSheetPageArgs {
  final int spudID;

  RapSheetPageArgs(this.spudID);
}

class RapSheetPage extends StatefulWidget {
  static const String route = 'rap-sheet';
  final int spudID;
  // final int geekID;

  const RapSheetPage(this.spudID, {Key? key}) : super(key: key);

  @override
  State<RapSheetPage> createState() => _RapSheetPageState();
}

class _RapSheetPageState extends State<RapSheetPage> {
  late Future<Boardgame> _boardgame;

  @override
  void initState() {
    _boardgame = getBoardGameRapSheet(widget.spudID);
    _boardgame.then((Boardgame boardgame) =>
        context.read<SearchHistory>().addToSearchHistory(boardgame));
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const GameScanBackButton(),
        actions: const [
          GameScanSettingsButton(),
        ],
      ),
      body: FutureBuilder(
        future: _boardgame,
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            Boardgame boardgame = snapshot.data!;
            return WebView(
              initialUrl:
                  'https://boardgamegeek.com/boardgame/${boardgame.geekID}/',
              onProgress: (int progress) => print('Webpage loading, $progress% finished'),
              // initialUrl: 'https://flutter.dev',
            );
          }
        }),
      ),
      // body: FutureBuilder(
      //   future: _boardgame,
      //   builder: (context, snapshot) {
      //     if (!snapshot.hasData) {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     } else {
      //       Boardgame boardgame = snapshot.data!;
      //       return Column(
      //         children: [
      //           Text(boardgame.title),
      //           const SizedBox(height: 10),
      //           Image.network(boardgame.thumbnail),
      //           const SizedBox(height: 10),
      //           Text(boardgame.releaseYear.toString()),
      //         ],
      //       );
      //     }
      //   },
      // ),
    );
  }
}
