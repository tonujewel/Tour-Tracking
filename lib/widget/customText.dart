import 'package:flutter/material.dart';
import 'package:tourtracking/style/style.dart';

// ignore: must_be_immutable
class CustomText extends StatelessWidget {
  String text;

  Function ontab;

  CustomText({@required this.text,this.ontab});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontab,
      child: Container(
        height: MediaQuery.of(context).size.height * .1,
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 20, top: 15, bottom: 15),
                decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Style.primaryColor),
                ),
                child: Text(
                  "$text",
                  style: TextStyle(fontSize: 15, color: Style.secondaryTextColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
