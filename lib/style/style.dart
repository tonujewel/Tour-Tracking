import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Style {
  static final Color primaryColor = Color(0xff000000);
  static final Color backgroundColor = Color(0xffEEF5FF);
  static final Color textColor = Colors.grey;
  static final Color bottomContainerColor = Color(0xFFF8F9FB);
  static final Color primaryTextColor = Color(0xff4b6584);
  static final Color secondaryTextColor = Color(0xff778ca3);
  static final Color appbarBackground = Color(0xff000000);
  static final Color buttonColor = Color(0xff000000);
  static final Color cursorColor = Color(0xff000000);
  static final Color floatingBgColor = Color(0xff000000);



  static final BoxShadow boxShadow = BoxShadow(
    color: Color(0xff193B68).withOpacity(0.05),
    offset: Offset(0, 0), //(x,y)
    blurRadius: 10.0,
  );

}
