import 'package:equatable/equatable.dart';

class Boardgame extends Equatable {
  late int spudID;
  late String title;
  late String thumbnail;
  late int releaseYear;
  late int geekID;
  String? description;
  int? minPlayers;
  int? maxPlayers;
  String? designer;
  int? minTime;
  int? maxTime;
  int? age;
  String? amazonASIN;
  String? image;
  double? geekRating;
  double? geekWeight;
  String? atlasID;
  double? atlasRating;
  double? learningComplexity;
  double? strategyComplexity;

  Boardgame({
    required this.spudID,
    required this.title,
    required this.thumbnail,
    required this.releaseYear,
    required this.geekID,
    this.description,
    this.minPlayers,
    this.maxPlayers,
    this.designer,
    this.minTime,
    this.maxTime,
    this.age,
    this.amazonASIN,
    this.image,
    this.geekRating,
    this.geekWeight,
    this.atlasID,
    this.atlasRating,
    this.learningComplexity,
    this.strategyComplexity,
  });

  @override
  get props => [spudID];

  Boardgame.fromJSON(dynamic json) {
    spudID = json['SpudID'];
    title = json['Title'];
    thumbnail = json['Thumbnail'];
    releaseYear = json['ReleaseYear'];
    geekID = int.parse(json['GeekId']);
    description = json['Description'];
    minPlayers = json['MinNumberOfPlayers'];
    maxPlayers = json['MaxNumberOfPlayers'];
    designer = json['Designer'];
    minTime = json['MinTime'];
    maxTime = json['MaxTime'];
    age = json['Age'];
    amazonASIN = json['AmazonASIN'];
    image = json['Image'];
    geekRating = json['GeekRating'];
    geekWeight = json['Weight'];
    atlasID = json['AtlasId'];
    atlasRating = json['AtlasRating'];
    learningComplexity = json['LearningComplexity'] is int ? json['LearningComplexity'].toDouble() : json['LearningComplexity'];
    strategyComplexity = json['StrategyComplexity'] is int ? json['StrategyComplexity'].toDouble(): json['StrategyComplexity'];
  }

  Map<String, dynamic> toJson() => {
        'SpudID': spudID,
        'Title': title,
        'Thumbnail': thumbnail,
        'ReleaseYear': releaseYear,
        'GeekId': geekID,
        'Description': description,
        'MinNumberOfPlayers': minPlayers,
        'MaxNumberOfPlayers': maxPlayers,
        'Designer': designer,
        'MinTime': minTime,
        'MaxTime': maxTime,
        'Age': age,
        'AmazonASIN': amazonASIN,
        'Image': image,
        'GeekRating': geekRating,
        'Weight': geekWeight,
        'AtlasId': atlasID,
        'AtlasRating': atlasRating,
        'LearningComplexity': learningComplexity,
        'StrategyComplexity': strategyComplexity,
      };
}
