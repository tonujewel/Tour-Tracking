import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tourtracking/model/user_model.dart';
import 'package:tourtracking/utils/appConstant.dart';
import 'package:tourtracking/view/bottom_navigation/home_screen.dart';


class SignUpController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;


  var isLoading = false.obs;

  void doSignUp() async {

    if(nameController.text.isEmpty){
      errorSnackbar("Name field is required");
    }else if (emailController.text.isEmpty) {
      errorSnackbar("Email field is required");
    } else if (passwordController.text.isEmpty) {
      errorSnackbar("Password field is required");
    } else if (confirmPasswordController.text.isEmpty) {
      errorSnackbar("Confirm Email field is required");
    } else if (passwordController.text != confirmPasswordController.text) {
      errorSnackbar("Password and confirm password must be same");
    } else {
      isLoading.value = true;
      registerWithEmailAndPassword(nameController.text, emailController.text, passwordController.text);
    }
  }



  // User registration using email and password
  Future<bool> registerWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((result) async {
        print('uID: ' + result.user.uid);
        print('email: ' + result.user.email);
        UserModel _newUser = UserModel(
            uid: result.user.uid,
            email: result.user.email,
            name: name,
          //  photoUrl: gravatarUrl
        );
        //update the user in firestore
        _updateUserFirestore(_newUser, result.user);
      });
      return true;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      print("${e.message}");
      errorSnackbar("${e.message}");
      return false;
    }
  }


  //updates the firestore users collection
  void _updateUserFirestore(UserModel user, User firebaseUser) {
    isLoading.value = false;
    successSnackbar("Sign up success");
    _db
        .doc('/users/${firebaseUser.uid}')
        .set(user.toJson());

    isLoading.value = false;
    Get.offAll(HomeScreen());
  }
}
