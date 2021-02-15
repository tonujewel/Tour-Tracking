import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourtracking/controller/bottom_navigation_controller.dart';
import 'package:tourtracking/view/bottom_navigation/history_screen.dart';
import 'package:tourtracking/view/bottom_navigation/home_screen.dart';
import 'package:tourtracking/view/bottom_navigation/plan_screen.dart';
import 'package:tourtracking/view/bottom_navigation/profile_screen.dart';
import 'package:tourtracking/style/style.dart';


class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final BottomController boController = Get.put(BottomController());
    return new Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          body: Stack(
            children: [
              PageView(
                children: <Widget>[
                  HomeScreen(),
                  HistoryScreen(),
                  PlanScreen(),
                  ProfileScreen(),
                ],
                controller: boController.controller.value,
                pageSnapping: false,
                physics: NeverScrollableScrollPhysics(),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: bottomNav(width, boController),
              ),
            ],
          ),
        ));
  }

  bottomNav(width, boController) {
    return Container(
        height: 70,
        width: width,
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            boxShadow: [Style.boxShadow],
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
            color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            item(0, Icons.home_outlined, width, boController),
            item(1, Icons.history, width, boController),
            item(2, Icons.next_plan_outlined, width, boController),
            item(3, Icons.account_circle_outlined, width, boController)
          ],
        ));
  }

  navigateToPage(int input, BottomController boController) {
    boController.animateTo(input);
    boController.onPageChanged(input);
  }

  item(index, name, width, boController) {
    return Material(
      color: Colors.white.withOpacity(.5),
      borderRadius: BorderRadius.all(Radius.circular(9)),
      child: InkWell(
        splashColor: Colors.white.withOpacity(.1),
        borderRadius: BorderRadius.all(Radius.circular(500)),
        enableFeedback: true,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            width: width * .18,
            height: 50,
            child: Obx(() => Icon(name,
                color: index == boController.page.value
                    ? Style.primaryColor
                    : Colors.grey,
                size: index == boController.page.value ? 30 : 25))),
        onTap: () {
          navigateToPage(index, boController);
        },
      ),
    );
  }

  animateTo(int page, BottomController drawer) {
    drawer.onPageChanged(page);
    drawer.resetController(page);
  }
}
