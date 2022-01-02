import 'dart:async';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:core';
import 'dart:math';
import 'dart:convert';

Future<bool> postUserSettings(bearer, setting, value) async {
  var headers = {
    'Authorization': 'bearer 1190119435668-t2WYGpfiWWIS54k2PO_zSWaxcG3skA',
    'Content-Type': 'application/json',
  };
  var request = http.Request(
      'PATCH', Uri.parse('https://oauth.reddit.com/api/v1/me/prefs'));
  request.body = json.encode({setting: value});
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  Map<String, dynamic> user = {};
  var status = response.statusCode;
  if (status == 200) {
    print("status code = $status (setting was correctly changed)\n");
    user = jsonDecode(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
    return (false);
  }
  return (true);
}
