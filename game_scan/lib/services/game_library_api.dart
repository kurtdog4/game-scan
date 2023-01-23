import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'package:game_scan/models/boardgame.dart';

const String libraryApiBySearch =
    'https://g8qwblww05.execute-api.us-east-2.amazonaws.com/default/librarian-get-game-by-search';
const String libraryApiById =
    'https://bjzbldvwx4.execute-api.us-east-2.amazonaws.com/default/librarian-get-game-by-name-or-id?spudId=';
const String getTopGamesApi =
    'https://6qngjjslywsegcbcluyfxkdxf40pjouh.lambda-url.us-east-2.on.aws/';
const String gameQuery = '?partialtext=';

Future<List<Boardgame>?> getTopGames() async {
  Response res = await http.get(Uri.parse(getTopGamesApi));
  if (res.statusCode != 200) {
    return null;
  }
  return parseBoardgameList(res.body);
}

Future<List<Boardgame>> searchForGame(String text) async {
  if (text == "") {
    return [];
  }
  Response res =
      await http.get(Uri.parse('$libraryApiBySearch$gameQuery$text'));
  if (res.statusCode != 200) {
    return [];
  }
  return parseBoardgameList(res.body);
}

List<Boardgame> parseBoardgameList(String json) {
  List<dynamic> boardgameMap = jsonDecode(json);
  return boardgameMap
      .map((boardgame) => Boardgame.fromJSON(boardgame))
      .toList();
}

Future<Boardgame> getBoardGameRapSheet(int spudId) async {
  Response res =
      await http.get(Uri.parse('$libraryApiById${spudId.toString()}'));
  dynamic boardgameJSON = (jsonDecode(res.body) as List).first;
  return Boardgame.fromJSON(boardgameJSON);
}
