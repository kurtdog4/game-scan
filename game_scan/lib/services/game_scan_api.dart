import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:game_scan/models/boardgame.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

String gameScanAPI =
    'https://03awtv3qp5.execute-api.us-east-2.amazonaws.com/default/spudnick-ai-endpoint-lambda?&detect=1&imageType=[%22jpeg%22]&screen=%7Bwidth:3024,height:4032%7D';

Future<List<Boardgame>?> getListFromImage() async {
  Response res = await http.get(Uri.parse(gameScanAPI));
  if (res.statusCode != 200) {
    return null;
  } else {
    Map<String, dynamic> body = jsonDecode(res.body);
    String imageName = body['resp']['imageName'];
    String uploadURL = body['resp']['uploadURL'];
    String textasset = "assets/IMG_2851.JPG";
    var bytes = await rootBundle.load(textasset);
    print(bytes);
    // var file = await Image.asset('assets/IMG_2851.JPG');
    // print(file);
    // Response res2 = await http.put(Uri.parse(uploadURL), body: file);
  }
}
