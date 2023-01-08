import 'dart:convert';
import 'dart:io';

import 'package:game_scan/models/boardgame.dart';
import 'package:path_provider/path_provider.dart';

class SearchHistory {
  late List<Boardgame> searchHistory = [];
  late Future<Directory> _dir;
  late File _file;

  SearchHistory() {
    _dir = getApplicationDocumentsDirectory();
    _dir.then((dir) {
      _file = File('${dir.path}/searchHistory.json');
      _loadSearchHistory();
    });
  }

  void _loadSearchHistory() {
    if (_file.existsSync()) {
      var searchHistoryJSON = _file.readAsStringSync();
      searchHistory = (jsonDecode(searchHistoryJSON) as List<dynamic>)
          .map((dynamic boardgameJSON) => Boardgame.fromJSON(boardgameJSON))
          .toList();
    }
  }

  void _saveSearchHistory() {
    var searchHisotryJSON = jsonEncode(searchHistory);
    _file.writeAsStringSync(searchHisotryJSON);
  }

  Future<void> addToSearchHistory(Boardgame boardgame) async {
    searchHistory.remove(boardgame);
    searchHistory.insert(0, boardgame);
    if (searchHistory.length > 20) {
      searchHistory = searchHistory.sublist(0, 20);
    }
    _saveSearchHistory();
  }
}
