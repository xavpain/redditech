import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:core';
import 'dart:math';
import 'dart:convert' show jsonDecode;
import 'dart:io';

// https://oauth.reddit.com/r/subreddit/new

class userSubreddits {
  userSubreddits(this.userMap);

  final Map<String, dynamic> userMap;
  List after_values = [];

  List getSubredditsList(Map map) {
    List subedReddits = [];
    var index = 0;
    while (map['data']["dist"] != index) {
      try {
        subedReddits
            .add(map['data']['children'][index]['data']['display_name']);
      } catch (e) {}
      index++;
    }
    return (subedReddits);
  }

  void getKeysAndValuesUsingForEach(Map map) {
    print(map['data']['children'][2]['data']['display_name']);
    var index = 0;
    map.forEach((key, value) {
      print('[$index]$key --------------------------> $value');
      index++;
    });
  }

  // get the post from a list of subreddits, filter and list taken in parameter
  Future<Map<String, dynamic>> getSubedSubredditsPosts(
      argument, bodyToken, filter, after, flag, limit) async {
    Map<String, dynamic> postsubedreddits = {};
    var headers = {
      'Authorization': 'bearer $bodyToken',
    };
    var request;
    if (flag == false) {
      request = http.Request(
          'GET',
          Uri.parse(
              'https://oauth.reddit.com/r/$argument/$filter?limit=$limit'));
    } else {
      request = http.Request(
          'GET',
          Uri.parse(
              'https://oauth.reddit.com/r/$argument/$filter?limit=$limit&after=$after&count=1'));
    }
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      postsubedreddits = jsonDecode(await response.stream.bytesToString());
      after_values.add(postsubedreddits['data']['after']);
    } else {
      print(response.reasonPhrase);
    }
    return (postsubedreddits);
  }

  Future<List<Map<String, dynamic>>> feedLoop(
      List subbed, bearer, filter, flag, tAfterValues, limit) async {
    List<Map<String, dynamic>> postsubedreddits = [];
    for (int i = 0; i < subbed.length; i++) {
      postsubedreddits.insert(
          i,
          await getSubedSubredditsPosts(subbed[i], bearer, 'new',
              flag == true ? tAfterValues[i] : [], flag, limit));
    }
    return (postsubedreddits);
  }

  Future<List> aftersLoop(
      List subbed, bearer, filter, flag, afterValues) async {
      int a = subbed.length;
      print("SIZE OF SUBBED LIST: $a");
    for (int i = 0; i < subbed.length; i++) {
      print(afterValues);
      print("VALUE OF I: $i");
      await getSubedSubredditsPosts(subbed[i], bearer, 'new',
          flag == true ? afterValues[i] : [], flag, 2);
    }
    return (after_values);
  }

  void decodePosts(List<Map<String, dynamic>> results, limit, listLenght) {
    print('vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv');
    print(results[0]['data']['children'][0]['data']['title']);
    print(results[0]['data']['children'][1]['data']['title']);
    print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n');
    print('vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv');
    print(results[1]['data']['children'][0]['data']['title']);
    print(results[1]['data']['children'][1]['data']['title']);
    print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n');
    print('vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv');
    print(results[2]['data']['children'][0]['data']['title']);
    print(results[2]['data']['children'][1]['data']['title']);
    print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n');
    print('vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv');
    print(results[3]['data']['children'][0]['data']['title']);
    print(results[3]['data']['children'][1]['data']['title']);
    print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n');
    print('vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv');
    print(results[4]['data']['children'][0]['data']['title']);
    print(results[4]['data']['children'][1]['data']['title']);
    print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n');
  }
}

// returns a list of the subreddits the user is subed to
Future<Map<String, dynamic>> getuserSubreddits(bearer) async {
  var headers = {
    'Authorization': 'bearer $bearer',
  };
  var request = http.Request(
      'GET', Uri.parse('https://oauth.reddit.com/subreddits/mine/subscriber'));

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
