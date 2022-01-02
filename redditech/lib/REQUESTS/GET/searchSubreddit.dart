import 'dart:async';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:core';
import 'dart:math';
import 'dart:convert' show jsonDecode;

// https://oauth.reddit.com/r/subreddit/new

class searchSubreddit {
  searchSubreddit(this.userMap);

  final Map<String, dynamic> userMap;

  void getKeysAndValuesUsingForEach(Map map) {
    var index = 0;
    map.forEach((key, value) {
      print('[$index]$key --------------------------> $value');
      index++;
    });
  }
}

// get the posts from a subreddit taken into parameter
Future<Map<String, dynamic>> getSubredditsPost(
    bearer, subreddit, filter) async {
  var headers = {
    'Authorization': 'bearer $bearer',
  };
  var request = http.Request(
      'GET', Uri.parse('https://oauth.reddit.com/r/$subreddit/$filter'));

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

// get the information related to a subreddit taken into parameter
Future<Map<String, dynamic>> getSubredditsInfo(subreddit, bearer) async {
  Map<String, dynamic> postsubedreddits = {};
  var headers = {
    'Authorization': 'bearer $bearer',
  };
  var request = http.Request(
      'GET', Uri.parse('https://oauth.reddit.com/r/$subreddit/about'));
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    postsubedreddits = jsonDecode(await response.stream.bytesToString());
    print(postsubedreddits);
  } else {
    print(response.reasonPhrase);
  }
  return (postsubedreddits);
}
