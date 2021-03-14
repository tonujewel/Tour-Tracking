import 'package:flutter/material.dart';
import 'package:tourtracking/style/style.dart';

// ignore: must_be_immutable
class CustomAppbar extends StatelessWidget {
  String title;

  CustomAppbar({this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Style.appbarBackground,
      elevation: 0,
      centerTitle: true,
      title: Text(
        '$title',
        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }
}
