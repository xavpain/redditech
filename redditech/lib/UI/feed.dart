import 'package:flutter/material.dart';
import 'package:redditech/UI/displayPost.dart';
import '../REQUESTS/GET/subreddits_subed.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'feedPreview.dart';
import 'package:redditech/globals.dart' as globals;
import 'package:loading_indicator/loading_indicator.dart';

const List<Color> _kDefaultRainbowColors = const [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.blue,
  Colors.indigo,
  Colors.purple,
];

class Feed extends StatefulWidget {
  List<Map<String, dynamic>> feedPosts = [];
  List<String> subIcons = [];
  Feed({Key? key}) : super(key: key);

  @override
  _FeedState createState() {
    return new _FeedState();
  }
}

class _FeedState extends State<Feed> {
  _FeedState() {
    getFeedAndIcons(globals.bearerToken!.bodyToken, false)
        .then((value) => setState(() {
              widget.feedPosts = value[0];
              widget.subIcons = value[1];
            }));
  }

  Future<List<String>> getIcons(feedPosts) async {
    List<String> subIcons = [];
    for (var i in feedPosts) {
      subIcons
          .add(await getIcon(i['data']['children'][0]['data']['subreddit']));
    }
    return subIcons;
  }

  Future<String> getIcon(String sub) async {
    var response = await http.get(
        Uri.parse("https://www.reddit.com/r/$sub/about.json"),
        headers: {"Accept": "application/json"});
    Map res = json.decode(response.body);
    print(res);
    return res['data']["icon_img"] != ""
        ? res['data']["icon_img"]
        : "https://i.redd.it/u87eaol1sqi21.png";
  }

  Future<List<dynamic>> getFeedAndIcons(bodyToken, flag) async {
    var feed = await getFeed(bodyToken, flag);
    return [feed, await getIcons(feed)];
  }

  Future<List<Map<String, dynamic>>> getFeed(bodyToken, flag) async {
    List afterValues = [];
    var subInfos = await getuserSubreddits(bodyToken);
    var instance = new userSubreddits(subInfos);
    var limit = 2;
    // instance.getKeysAndValuesUsingForEach(instance.userMap);
    print(instance.getSubredditsList(instance.userMap));
    print("______________________________________");
    afterValues = await instance.aftersLoop(
        instance.getSubredditsList(instance.userMap),
        bodyToken,
        'new',
        flag,
        afterValues);
    print("AFTER LIST = //////////////////////////////////////////");
    for (int i = 0; i < afterValues.length; i++) {
      print(afterValues[i]);
    }
    print("////////////////////////////////////////////////////////");
    return (await instance.feedLoop(
        instance.getSubredditsList(instance.userMap),
        bodyToken,
        'new',
        flag,
        afterValues,
        limit));
  }

  // Future<String> getFeedPosts() async {
  //   var response = await http.get(
  //     Uri.parse("https://jsonplaceholder.typicode.com/posts"),
  //     headers: {
  //       "Accept": "application/json"
  //     }
  //   );
  //   this.setState(() {
  //     widget.feedPosts = json.decode(response.body);
  //   });
  //   return "ok";
  // }
  // void setFeedPosts() async {
  //   widget.feedPosts = await getFeed(widget.bearer, true);
  // }

  // @override
  // void initState() {
  //   setFeedPosts();
  // }
  Future<void> _refreshFeed() async {
    Navigator.pushReplacementNamed(context, "/nav");
  }

  @override
  Widget build(BuildContext context) {
    return widget.feedPosts.length == 0
        ? Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(150),
              child: Center(
                  child: LoadingIndicator(
                      indicatorType: Indicator.ballRotateChase,
                      colors: const [Colors.orange, Colors.deepOrange],
                      strokeWidth: 1,
                      backgroundColor: Colors.transparent,
                      pathBackgroundColor: Colors.black)),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.grey[800],
            body: RefreshIndicator(
              onRefresh: _refreshFeed,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: widget.feedPosts.length,
                itemBuilder: (context, index) {
                  final Map current =
                      widget.feedPosts[index]['data']['children'][0]['data'];
                  current["icon"] = widget.subIcons[index];
                  return InkWell(
                    child: FeedCard(data: current),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DisplayPost(data: current)));
                    },
                  );
                },
              ),
            ),
          );
  }
}
