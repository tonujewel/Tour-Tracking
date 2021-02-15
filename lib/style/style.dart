import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Style {
  static final Color primaryColor = Color(0xFF00a5ff);
  static final Color buttonColor = Color(0xFFFFB161);
  static final Color backgroundColor = Color(0xffCFDBE5);
  static final Color textColor = Color(0xFF001F6E);
  static final Color hintsColor = Color(0xFF7080ab);
  static final Color demoColor = Color(0xFF7080ab);





  static BoxShadow boxShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 5,
    blurRadius: 7,
    offset: Offset(0, 3), // changes position of shadow
  );

}
