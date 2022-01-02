import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../REQUESTS/GET/userInfo.dart';
import 'package:redditech/globals.dart' as globals;
import '../REQUESTS/POST/postUserSettings.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool noProfanity = false;
  bool Nightmode = false;
  bool labelNfsw = false;
  bool showPresence = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Text('Settings',
              style: GoogleFonts.nunito(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w500)),
          SizedBox(
            height: 40,
          ),
          Divider(
            thickness: 1,
            indent: 0,
            endIndent: 0,
            color: Colors.white,
            height: 5,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('No profanity',
                  style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
              Text(
                '                                           ',
              ),
              Switch(
                activeColor: Colors.orange[900],
                value: noProfanity,
                onChanged: (bool value) {
                  setState(() {
                    noProfanity = value;
                  });
                },
              ),
            ],
          ),
          Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Autocollapse',
                    style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
                Text(
                  '                                   ',
                ),
                DropdownButton<String>(
                  items: <String>['medium', 'off', 'low', 'high']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 1,
              indent: 0,
              endIndent: 0,
              color: Colors.white,
              height: 5,
            ),
            SizedBox(
              height: 60,
            ),
            Divider(
              thickness: 1,
              indent: 0,
              endIndent: 0,
              color: Colors.white,
              height: 5,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Nighmode',
                    style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
                Text(
                  '                                           ',
                ),
                Switch(
                  activeColor: Colors.orange[900],
                  value: Nightmode,
                  onChanged: (bool value) {
                    setState(() {
                      Nightmode = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Accept pms',
                    style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
                Text(
                  '                           ',
                ),
                DropdownButton<String>(
                  items:
                      <String>['everyone', 'whitelisted'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (_value) {},
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 1,
              indent: 0,
              endIndent: 0,
              color: Colors.white,
              height: 5,
            ),
            SizedBox(
              height: 60,
            ),
            Divider(
              thickness: 1,
              indent: 0,
              endIndent: 0,
              color: Colors.white,
              height: 5,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Label Nsfw',
                    style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
                Text(
                  '                                           ',
                ),
                Switch(
                  activeColor: Colors.orange[900],
                  value: labelNfsw,
                  onChanged: (bool value) {
                    setState(() {
                      labelNfsw = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Show presence',
                    style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
                Text(
                  '                                ',
                ),
                Switch(
                  activeColor: Colors.orange[900],
                  value: showPresence,
                  onChanged: (bool value) {
                    setState(() {
                      showPresence = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 1,
              indent: 0,
              endIndent: 0,
              color: Colors.white,
              height: 5,
            ),
            SizedBox(
              height: 20,
            ),
          ])
        ],
      ),
    );
  }
}
