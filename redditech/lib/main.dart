import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redditech/UI/settings.dart';
import 'dart:core';
import 'UI/feed.dart';
import 'UI/profile.dart';
import 'UI/nav.dart';
import 'UI/search.dart';
import 'REQUESTS/GET/authenticate.dart';
import 'package:redditech/globals.dart' as globals;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    late Map data;

    return MaterialApp(
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      // debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomePage(),
        '/feed': (context) => Feed(),
        '/profile': (context) => Profile(),
        '/search': (context) => Search(),
        '/nav': (context) => Nav(),
        '/settings': (context) => Settings(),
        // '/feed/display': (context) => DisplayPost(data:data)
      },
      // title: 'Flutter Demo',
      // home: HomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/logo.png',
              width: 260.0,
              height: 140.0,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Text('Redditech',
              style: GoogleFonts.nunito(
                  color: Colors.orange[900],
                  fontSize: 50,
                  fontWeight: FontWeight.w800)
              // style: TextStyle(
              //     fontFamily: 'tech', color: Colors.orange[900], fontSize: 50),
              ),
          SizedBox(height: 260),
          ElevatedButton(
            child: Text('Login',
                style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800)),
            style: ElevatedButton.styleFrom(
              primary: Colors.orange[900],
              minimumSize: Size(150, 50),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
            ),
            onPressed: () async {
              globals.bearerToken = await authenticate();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Nav(),
                ),
              );
            },
          ),
        ],
      )),
    );
  }
}
