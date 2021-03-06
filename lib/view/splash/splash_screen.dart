import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourtracking/controller/splash_controller.dart';
import 'package:tourtracking/main.dart';
import 'package:tourtracking/style/style.dart';


// ignore: must_be_immutable
class SplashScreen extends StatelessWidget {
  var splashController = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {

    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;
    paddingTop = MediaQuery.of(context).padding.top;
    paddingBottom = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/image/logo.png'),
      ),
    );
  }
}
