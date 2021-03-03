import 'package:flutter/material.dart';

class CustomLoader extends StatefulWidget {
  @override
  _CustomLoaderState createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent.withOpacity(0),
        body: Center(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(150),
              child: Image.asset(
                "assets/image/loader.gif",
                scale: 6,
                fit: BoxFit.fill,
                height: 80,
                width: 80,
              )),
        ));
  }
}


