import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  var isLoading = false.obs;

  String email = 'tonujewel@gmail.com';
  String password = 'Bangladesh1@';

  FirebaseAuth auth = FirebaseAuth.instance;

  checkUser() {
    if (auth.currentUser != null) {
      print(auth.currentUser.email);
      changePass();
    } else {
      print("user not found");
    }
  }

  void changePass() async {
    EmailAuthCredential credential =
        EmailAuthProvider.credential(email: auth.currentUser.email, password: "Password@3221");

    await auth.currentUser.reauthenticateWithCredential(credential);
  }
}
