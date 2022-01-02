import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
// import 'videoPlayer.dart';

class DisplayPost extends StatefulWidget {
  const DisplayPost({Key? key, required this.data}) : super(key: key);
  final Map data;

  @override
  _DisplayPostState createState() => _DisplayPostState();
}

class _DisplayPostState extends State<DisplayPost> {
  @override
  Widget build(BuildContext context) {
    print("med : ");
    // print(widget.data['media'] != Null ? widget.data['media'] : "");
    return Scaffold(
      appBar: AppBar(
        title: Text("Redditech Post"),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          _subAndIcon(
              widget.data['subreddit_name_prefixed'], widget.data['icon']),
          _subName(widget.data['author']),
          _score(widget.data['score'].toString()),
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.grey[850],
            title: Container(
              child: Text(widget.data['title'],
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                  child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        widget.data['selftext'],
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ],
                ),
              )),
            ]),
          ),
        ],
      ),
    );
  }
}

void _upvote() {}
void _downvote() {}

SliverAppBar _score(String score) {
  return SliverAppBar(
    automaticallyImplyLeading: false,
    expandedHeight: 30,
    backgroundColor: Colors.grey[720],
    title: Row(children: [
      Text("Score : " + score,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
      Row(children: [
        IconButton(onPressed: _upvote, icon: Icon(Icons.arrow_upward_outlined)),
        IconButton(
            onPressed: _downvote, icon: Icon(Icons.arrow_downward_outlined)),
      ]),
    ]),
  );
}

SliverAppBar _subAndIcon(String sub, String iconUrl) {
  return SliverAppBar(
    automaticallyImplyLeading: false,
    floating: true,
    expandedHeight: 30,
    backgroundColor: Colors.grey[720],
    title: InkWell(
      child: Row(
        children: [
          Text(sub,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: 20.0,
                height: 20.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.fill, image: NetworkImage(iconUrl)))),
          ),
        ],
      ),
    ),
    // collapsedHeight: 150,
  );
}

Future<String> getUserIcon(String user) async {
  var response = await http.get(
      Uri.parse("https://www.reddit.com/user/$user/about.json"),
      headers: {"Accept": "application/json"});
  Map res = json.decode(response.body);
  print(res);
  return res['data']["icon_img"] != ""
      ? res['data']["icon_img"]
      : "https://i.redd.it/u87eaol1sqi21.png";
}

SliverAppBar _subName(String author) {
  // var img = await getUserIcon(author);
  return SliverAppBar(
    backgroundColor: Colors.grey[750],
    automaticallyImplyLeading: false,
    title: Text("Posted by : u/" + author,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
    expandedHeight: 30,
  );
}
