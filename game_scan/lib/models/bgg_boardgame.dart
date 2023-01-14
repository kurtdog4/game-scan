import 'dart:convert';

import 'package:xml2json/xml2json.dart';

class BGGBoardgame {
  late String name;
  late int yearPublished;
  late int minPlayers;
  late int maxPlayers;
  late String thumbnail;
  late List<String> designers;
  late List<String> artists;
  late List<String> publishers;
  late int? playingTime;
  late int? minPlayTime;
  late int? maxPlayTime;
  late int age;
  late String description;

  BGGBoardgame.fromXml(dynamic xml) {
    final xmlTransformer = Xml2Json();
    xmlTransformer.parse(xml);
    final dynamic boardgameJson =
        json.decode(xmlTransformer.toParkerWithAttrs());
    dynamic boardgame = boardgameJson['boardgames']['boardgame'];

    name = 'Unknown';
    for (dynamic nameMap in boardgame['name']) {
      bool primary = false;
      String nameValue = '';
      nameMap.forEach((String key, dynamic value) {
        if (key == '_primary') {
          primary = true;
        } else if (key == 'value') {
          nameValue = value;
        }
      });
      if (primary) {
        name = nameValue;
        break;
      }
    }
    yearPublished = int.parse(boardgame['yearpublished']);
    minPlayers = int.parse(boardgame['minplayers']);
    maxPlayers = int.parse(boardgame['maxplayers']);
    playingTime = int.parse(boardgame['playingtime']);
    minPlayTime = int.parse(boardgame['minplaytime']);
    maxPlayTime = int.parse(boardgame['maxplaytime']);
    age = int.parse(boardgame['age']);
    description = boardgame['description'];
    thumbnail = boardgame['thumbnail'];
    if (boardgame['boardgamedesigner'] is List) {
      designers = (boardgame['boardgamedesigner'] as List<dynamic>)
          .map((e) => e['value'] as String)
          .toList();
    } else {
      designers = [boardgame['boardgamedesigner']['value']];
    }
    if (boardgame['boardgameartist'] is List) {
      artists = (boardgame['boardgameartist'] as List<dynamic>)
          .map((e) => e['value'] as String)
          .toList();
    } else {
      artists = [boardgame['boardgameartist']['value']];
    }
    if (boardgame['boardgamepublisher'] is List) {
      publishers = (boardgame['boardgamepublisher'] as List<dynamic>)
          .map((e) => e['value'] as String)
          .toList();
    } else {
      publishers = [boardgame['boardgamepublisher']['value']];
    }
  }
}
