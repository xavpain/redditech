import 'dart:async';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:core';
import 'dart:math';
import 'userInfo.dart';
import 'dart:convert' show jsonDecode;
import 'subreddits_subed.dart';

class Token {
  Token(this.bodyToken);

  final String bodyToken;

  String get getBodyToken {
    return (bodyToken);
  }

  void printBody() {
    print('access_token : $bodyToken');
  }
}

String generateRandomString(int len) {
  var r = Random();
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}

Future<Token> authenticate() async {
  final url = Uri.https('www.reddit.com', '/api/v1/authorize.compact', {
    'client_id': 'vgidLYOptCvj-wyDHCTomA',
    'response_type': 'code',
    'state': generateRandomString(10),
    'redirect_uri':
        'fr.epitech.noe://http://127.0.0.1:65010/authorize_callback',
    'duration': 'permanent',
    'scope': '*',
  });
  final result = await FlutterWebAuth.authenticate(
    url: url.toString(),
    callbackUrlScheme: "fr.epitech.noe",
  );
  String code = Uri.parse(result).queryParameters['code'].toString();
  var headers = {
    'Authorization':
        'Basic dmdpZExZT3B0Q3ZqLXd5REhDVG9tQTpVLXNoTGdtYWVqdF9rX01zMHRkeW81TENuckJIWXc='
  };
  var request = http.MultipartRequest(
      'POST', Uri.parse('https://www.reddit.com/api/v1/access_token'));
  request.fields.addAll({
    'grant_type': 'authorization_code',
    'code': code,
    'redirect_uri': 'fr.epitech.noe://http://127.0.0.1:65010/authorize_callback'
  });
  request.headers.addAll(headers);
  http.StreamedResponse httpResponse = await request.send();
  if (httpResponse.statusCode == 200) {
    print("[✔] Everything went well, here is your response:");
  } else {
    print("[✘] Issue found:");
    print(httpResponse.reasonPhrase);
  }

  var bodyToken = await http.Response.fromStream(httpResponse);
  print("response= ${bodyToken.body}");
  var bearer = jsonDecode(bodyToken.body)['access_token'] as String;
  return Token(bearer);
}
