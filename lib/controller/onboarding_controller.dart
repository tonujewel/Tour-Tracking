import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';
import 'package:tourtracking/model/onboarding_info.dart';
import 'package:get/get.dart';
import '../view/auth/login.dart';

class OnboardingController extends GetxController {

  var selectedPageIndex = 0.obs;
  bool get isLastPage => selectedPageIndex.value == onboardingPages.length - 1;
  var pageController = PageController();

  forwardAction() {
    if (isLastPage) {
      Get.offAll(LoginScreen());
    } else {
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
    }
  }

  List<OnboardingInfo> onboardingPages = [
    OnboardingInfo('assets/image/one.png', 'Track your tour',
        'Store your tour history'),
    OnboardingInfo('assets/image/two.png', 'Tour in map',
        'map data'),
    OnboardingInfo('assets/image/three.png', 'Expense',
        'Calculate your tour expense')
  ];
}
