import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:game_scan/models/boardgame.dart';
import 'package:game_scan/services/game_library_api.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

String gameScanEndpoint =
    'https://03awtv3qp5.execute-api.us-east-2.amazonaws.com/default/spudnick-ai-endpoint-lambda';

String getUploadURL1 = '?&detect=1&imageType=[%22';
String getUploadURL2 = '%22]&screen=%7Bwidth:';
String getUploadURL3 = ',height:';
String getUploadURL4 = '%7D';

String getResults = '?&detect=2&imageName=';

Future<Boardgame?> getBoardgameListFromImageFile(File file) async {
  String fileType = file.path.substring(file.path.lastIndexOf('.') + 1);
  Uint8List imageBytes = await file.readAsBytes();
  Image decodedImage = await decodeImageFromList(imageBytes);
  int imageWidth = decodedImage.width;
  int imageHeight = decodedImage.height;

  Response res;
  try {
    res = await http.get(Uri.parse(
        '$gameScanEndpoint$getUploadURL1$fileType$getUploadURL2$imageWidth$getUploadURL3$imageHeight$getUploadURL4'));
    if (res.statusCode != 200) {
      return null;
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return null;
  }

  Map<String, dynamic> body = jsonDecode(res.body);
  String imageNameTmp = body['resp']['imageName'];
  String imageName = imageNameTmp.substring(imageNameTmp.lastIndexOf('/') + 1);
  String uploadURL = body['resp']['uploadURL'];

  try {
    res = await http.put(Uri.parse(uploadURL), body: imageBytes);
    if (res.statusCode != 200) {
      return null;
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return null;
  }

  try {
    res = await http.get(Uri.parse('$gameScanEndpoint$getResults$imageName'));
    String results = jsonDecode(res.body)['resp']['detectionRes'];
    if (results == '') {
      return null;
    }
    int spudID = int.parse(results.split(' ').first);
    return getBoardGameRapSheet(spudID);
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return null;
  }
}
