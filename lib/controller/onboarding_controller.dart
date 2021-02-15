import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';
import 'package:tourtracking/model/onboarding_info.dart';
import 'package:tourtracking/view/auth/login.dart';
import 'package:get/get.dart';
import 'package:tourtracking/view/main_screen/main_screen.dart';


class OnboardingController extends GetxController {

  var selectedPageIndex = 0.obs;
  bool get isLastPage => selectedPageIndex.value == onboardingPages.length - 1;
  var pageController = PageController();

  forwardAction() {
    if (isLastPage) {
      Get.offAll(MainScreen());
    } else {
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
    }
  }

  List<OnboardingInfo> onboardingPages = [
    OnboardingInfo('assets/image/order.png', 'Order Your Food',
        'Now you can order food any time  right from your mobile.'),
    OnboardingInfo('assets/image/cook.png', 'Cooking Safe Food',
        'We are maintain safty and We keep clean while making food.'),
    OnboardingInfo('assets/image/deliver.png', 'Quick Delivery',
        'Orders your favorite meals will be  immediately deliver')
  ];
}
