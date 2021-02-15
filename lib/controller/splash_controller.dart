import 'dart:async';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourtracking/main.dart';
import 'package:tourtracking/view/on_boarding/onboarding_page.dart';


class SplashController extends GetxController {
  @override
  void onInit() {
    SharedPreferences.getInstance().then((pr) {
      prefs = pr;
    });
    Timer(Duration(seconds: 3), () => Get.off(OnboardingPage()));
    super.onInit();
  }
}
