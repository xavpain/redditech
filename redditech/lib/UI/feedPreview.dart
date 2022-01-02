import 'stylePresets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class FeedCard extends StatelessWidget {
  final Map data;
  const FeedCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 6 / 3,
      child: Card(
        margin: EdgeInsets.all(7.0),
        color: Colors.grey[700],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 2,
        child: Container(
          margin: const EdgeInsets.all(4.0),
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: <Widget>[
              _Post(
                  media: data['thumbnail'],
                  title: data['title'],
                  body: data['selftext']),
              Divider(color: Colors.grey),
              _PostDetails(
                  subIcon: data['icon'],
                  subName: data['subreddit_name_prefixed'],
                  author: data['author'],
                  creationTime: "10:24"),
            ],
          ),
        ),
      ),
    );
  }
}

class _Post extends StatelessWidget {
  final String media;
  final String title;
  final String body;
  const _Post({required this.media, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    bool isMedia = true;
    if (media == "default" || media == "nsfw" || media == "self")
      isMedia = false;
    else if (media == "") isMedia = false;
    return Expanded(
      flex: 3,
      child: Row(children: <Widget>[
        _PostImage(media: isMedia == true ? media : ""),
        _PostText(title: title, isMedia: isMedia ? true : false, body: body)
      ]),
    );
  }
}

class _PostText extends StatelessWidget {
  final String title;
  final String body;
  final bool isMedia;
  const _PostText(
      {required this.title, required this.isMedia, required this.body});

  String truncate(String text, {length: 7, omission: '...'}) {
    if (length >= text.length) {
      return text;
    }
    return text.replaceRange(length, text.length, omission);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(truncate(title, length: 30), style: StylePresets.title),
            SizedBox(height: 2.0),
            Text(isMedia ? "Tap to see media." : truncate(body, length: 35),
                style: StylePresets.body1),
          ],
        ),
      ),
    );
  }
}

class _PostImage extends StatelessWidget {
  final String media;
  const _PostImage({required this.media});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child:
            media == "" ? Image.asset('assets/msg.png') : Image.network(media));
  }
}

class _PostDetails extends StatelessWidget {
  final String subIcon;
  final String subName;
  final String author;
  final String creationTime;
  const _PostDetails(
      {required this.subIcon,
      required this.subName,
      required this.author,
      required this.creationTime});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _SubIcon(subIcon: subIcon),
        _SubAndAuthor(sub: subName, author: author),
        _PostTimeStamp(creationTime: creationTime),
      ],
    );
  }
}

class _SubAndAuthor extends StatelessWidget {
  final String sub;
  final String author;
  const _SubAndAuthor({required this.sub, required this.author});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(sub, style: StylePresets.subtitle),
            SizedBox(height: 2.0),
            Text("u/" + author, style: StylePresets.body1),
          ],
        ),
      ),
    );
  }
}

class _SubIcon extends StatelessWidget {
  final String subIcon;
  const _SubIcon({required this.subIcon});

  @override
  Widget build(BuildContext context) {
    print(subIcon);
    return Expanded(
      flex: 1,
      child: CircleAvatar(
        backgroundImage: NetworkImage(subIcon),
      ),
    );
  }
}

class _PostTimeStamp extends StatelessWidget {
  final String creationTime;
  const _PostTimeStamp({required this.creationTime});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Text(creationTime, style: StylePresets.dateStyle),
    );
  }
}
