import 'package:game_scan/models/bgg_boardgame.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

const String _baseApi = "https://www.boardgamegeek.com/xmlapi/";
const String _boardgameApi = "${_baseApi}boardgame/";
const String getGloomhavenInfo = "${_boardgameApi}174430/";
const String getBrassBirminghamInfo = "${_boardgameApi}224517/";
const String getArkNovaInfo = "${_boardgameApi}342942";
const String getPandemicLegacyS1Info = "${_boardgameApi}161936";

Future<BGGBoardgame> getBGGBoardGameData(int geekId) async {
  Response response = await http.get(Uri.parse('$_boardgameApi$geekId'));
  return BGGBoardgame.fromXml(response.body);
}
