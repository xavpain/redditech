import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../REQUESTS/GET/userInfo.dart';
import 'package:redditech/globals.dart' as globals;

class Profile extends StatefulWidget {
  Map<String, dynamic> userInfo = {};
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  _ProfileState() {
    getUserInfos(globals.bearerToken!.bodyToken).then((value) => setState(() {
          widget.userInfo = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    String description = widget.userInfo.length > 0
        ? widget.userInfo['subreddit']['description']
        : "Loading";
    return Scaffold(
      body: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [Colors.red, Colors.orange])),
              child: Container(
                width: double.infinity,
                height: 620.0,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50.0,
                      ),
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          widget.userInfo.length > 0
                              ? widget.userInfo['subreddit']['icon_img']
                              : "https://miro.medium.com/max/880/0*H3jZONKqRuAAeHnG.jpg",
                        ),
                        radius: 50.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        widget.userInfo.length > 0
                            ? widget.userInfo['subreddit']['display_name']
                            : "Loading..",
                        style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 5.0),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 22.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Subs",
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      widget.userInfo.length > 0
                                          ? widget.userInfo['subreddit']
                                                  ['subscribers']
                                              .toString()
                                          : "Loading",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.pinkAccent,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Coins",
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      widget.userInfo.length > 0
                                          ? widget.userInfo['subreddit']
                                                  ['coins']
                                              .toString()
                                          : "Loading",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.pinkAccent,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Friends",
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      widget.userInfo.length > 0
                                          ? widget.userInfo['num_friends']
                                              .toString()
                                          : "Loading",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.pinkAccent,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Description",
                            style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                              description.length > 0
                                  ? "'" + description + "'"
                                  : "'The user haven't set any description yet'",
                              style: GoogleFonts.nunito(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      // SizedBox(
                      //   height: 150.0,
                      // ),
                      // SizedBox(
                      //   height: 100.0,
                      // ),
                      // Container(
                      //   color: Colors.white,
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(
                      //         vertical: 0.0, horizontal: 100.0),
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Text(
                      //           "   Description",
                      //           style: GoogleFonts.nunito(
                      //               color: Colors.orange[900],
                      //               fontSize: 25,
                      //               fontWeight: FontWeight.w800),
                      //         ),
                      //         SizedBox(
                      //           height: 10.0,
                      //         ),
                      //         Text(
                      //             description.length > 0
                      //                 ? "'" + description + "'"
                      //                 : "'The user haven't set any description yet'",
                      //             style: GoogleFonts.nunito(
                      //                 color: Colors.orange[900],
                      //                 fontSize: 10,
                      //                 fontWeight: FontWeight.w500)),
                      //         // SizedBox(
                      //         //   height: 240.0,
                      //         // ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              )),
          // Container(
          //   color: Colors.white,
          //   child: Padding(
          //     padding:
          //         const EdgeInsets.symmetric(vertical: 0.0, horizontal: 100.0),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //           "   Description",
          //           style: GoogleFonts.nunito(
          //               color: Colors.orange[900],
          //               fontSize: 25,
          //               fontWeight: FontWeight.w800),
          //         ),
          //         SizedBox(
          //           height: 10.0,
          //         ),
          //         Text(
          //             description.length > 0
          //                 ? "'" + description + "'"
          //                 : "'The user haven't set any description yet'",
          //             style: GoogleFonts.nunito(
          //                 color: Colors.orange[900],
          //                 fontSize: 20,
          //                 fontWeight: FontWeight.w500)),
          //         SizedBox(
          //           height: 240.0,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
