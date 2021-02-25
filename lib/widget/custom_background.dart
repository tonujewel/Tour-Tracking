import 'package:flutter/material.dart';
import 'package:tourtracking/style/style.dart';

class CustomBackground extends StatelessWidget {
  final Widget child;

  const CustomBackground({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            child: Container(
              height: size.height * .45,
              width: size.width,
              color: Style.primaryColor,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: size.height * .55,
              width: size.width,
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                color: Style.backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
