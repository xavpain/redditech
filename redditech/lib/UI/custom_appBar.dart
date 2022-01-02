import 'package:flutter/material.dart';

class GradientAppBar extends StatelessWidget implements PreferredSize {
  final double _prefferedHeight = 100.0;

  String title;
  Color gradientBegin, gradientEnd;

  GradientAppBar(
      {required this.title,
      required this.gradientBegin,
      required this.gradientEnd})
      : assert(title != null),
        assert(gradientBegin != null),
        assert(gradientEnd != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _prefferedHeight,
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 20.0),
      decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: <Color>[gradientBegin, gradientEnd])),
      child: Text(
        title,
        style: TextStyle(
            color: Colors.white,
            letterSpacing: 3.0,
            fontSize: 25.0,
            fontWeight: FontWeight.w700),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_prefferedHeight);

  @override
  Widget get child => throw UnimplementedError();
}
