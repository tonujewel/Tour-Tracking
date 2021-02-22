import 'package:flutter/material.dart';
import 'package:tourtracking/style/style.dart';

// ignore: must_be_immutable
class CustomText extends StatelessWidget {
  String text;


  CustomText({ @required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .06,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 20,top: 12,bottom: 12),
              decoration: BoxDecoration(
                color: Color(0xFFE3E8F0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                "$text",
                style: TextStyle(fontSize: 18, letterSpacing: 2, color: Style.textColor, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
