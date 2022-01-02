import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:core';
import 'dart:convert' show jsonDecode;

Future<bool> getUserInfos(bodyToken, action, subredditName) async {
  var bearer = jsonDecode(bodyToken.body)['access_token'] as String;

  var headers = {
    'Authorization': 'bearer $bearer',
    'Content-Type': 'application/x-www-form-urlencoded',
  };
  var request =
      http.Request('POST', Uri.parse('https://oauth.reddit.com/api/subscribe'));
  request.bodyFields = {'action': action, 'sr_name': subredditName};
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
    return (true);
  } else {
    print(response.reasonPhrase);
    return (false);
  }
}
