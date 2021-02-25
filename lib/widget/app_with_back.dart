import 'package:flutter/material.dart';
import 'package:tourtracking/style/style.dart';

// ignore: must_be_immutable
class CustomAppbarBack extends StatelessWidget {
  String title;

  CustomAppbarBack({this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: Style.appbarBackground,
      elevation: 0,
      leading: Icon(Icons.arrow_back_rounded),
      title: Center(
        child: Text(
          '$title',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
