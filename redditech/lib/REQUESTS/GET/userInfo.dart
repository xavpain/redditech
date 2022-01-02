import 'dart:async';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:core';
import 'dart:math';
import 'dart:convert' show jsonDecode;

class userInfo {
  userInfo(this.userMap);

  final Map<String, dynamic> userMap;

  void getKeysAndValuesUsingForEach(Map map) {
    var index = 0;
    map.forEach((key, value) {
      print('[$index]$key --------------------------> $value');
      index++;
    });
  }
}

Future<Map<String, dynamic>> getUserInfos(bearer) async {
  var headers = {
    'Authorization': 'bearer $bearer',
  };
  var request =
      http.Request('GET', Uri.parse('https://oauth.reddit.com/api/v1/me'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  Map<String, dynamic> user = {};
  if (response.statusCode == 200) {
    user = jsonDecode(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
  return user;
}
