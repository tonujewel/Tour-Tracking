import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourtracking/utils/appConstant.dart';
import 'package:tourtracking/view/auth/sign_up.dart';
import 'package:tourtracking/view/main_screen/main_screen.dart';

import '../main.dart';


class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var isLoading = false.obs;

  @override
  void onInit() {
    emailController.text="tonujewel@gmail.com";
    passwordController.text="123456";
    super.onInit();
  }

  void doLogin() async {
    if (emailController.text.isEmpty) {
      errorSnackbar("Email field is required");
    } else if (passwordController.text.isEmpty) {
      errorSnackbar("Password field is required");
    } else {
      isLoading.value = true;
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
        print("user email ${userCredential.user.email}");

        prefs.setString("uid", userCredential.user.uid);
        prefs.setString("email", userCredential.user.email);
        prefs.setString("name", userCredential.user.displayName);



        //String savedEmail = prefs.getString('email');




        successSnackbar("Login success");
        isLoading.value = false;
        Get.offAll(MainScreen());
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        errorSnackbar("$e");
        print("$e");
        if (e.code == 'user-not-found') {
          errorSnackbar('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          errorSnackbar('Wrong password provided for that user.');
        }
      }
    }
  }

  void goToSignUpPage() {
    Get.to(SignUp());
  }
}
