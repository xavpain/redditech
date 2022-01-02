import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redditech/UI/custom_appBar.dart';
import 'search.dart';
import 'feed.dart';
import 'profile.dart';
import '../REQUESTS/GET/userInfo.dart';
import 'package:redditech/globals.dart' as globals;
import 'custom_appBar.dart';
import 'settings.dart';

class Nav extends StatefulWidget {
  Map<String, dynamic> userInfo = {};
  Nav({Key? key}) : super(key: key);

  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  PageController _pageController = PageController();

  _NavState() {
    getUserInfos(globals.bearerToken!.bodyToken).then((value) => setState(() {
          widget.userInfo = value;
        }));
  }
  List<Widget> _screens = [
    Feed(),
    Search(),
    Profile(),
    Settings(),
  ];

  int _selected = 0;
  void _itemTapped(int selectedPage) {
    setState(() {
      _selected = selectedPage;
      _pageController.jumpToPage(selectedPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red, Colors.orange],
              stops: [0.5, 1.0],
            ),
          ),
        ),
        title: Text("Redditech"),
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            new Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.deepOrange, Colors.orange])),
              // color: Colors.grey[500],
              child: new DrawerHeader(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipOval(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        widget.userInfo.length > 0
                            ? widget.userInfo['subreddit']['icon_img']
                            : "https://miro.medium.com/max/880/0*H3jZONKqRuAAeHnG.jpg",
                        height: 100.0,
                        width: 100.0,
                      ),
                    )),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      widget.userInfo.length > 0
                          ? widget.userInfo['subreddit']['display_name']
                          : "Loading..",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                // decoration: BoxDecoration(
                //   color: Colors.white,
                // ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              thickness: 1,
              indent: 0,
              endIndent: 0,
              color: Colors.white,
              height: 5,
            ),
            SizedBox(
              height: 520,
            ),
            Divider(
              thickness: 1,
              indent: 0,
              endIndent: 0,
              color: Colors.white,
              height: 5,
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log out'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        // onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _itemTapped,
        currentIndex: _selected,
        // type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.orange[800],
        unselectedItemColor: Colors.white54,
        backgroundColor: Colors.blueGrey[900],
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.feed_outlined),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
