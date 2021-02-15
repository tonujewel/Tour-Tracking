import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourtracking/utils/appConstant.dart';
import 'package:tourtracking/view/auth/sign_up.dart';


class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var isLoading = false.obs;

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
        successSnackbar("Login success");
        isLoading.value = false;
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
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
