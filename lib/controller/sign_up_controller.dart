import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tourtracking/model/user_model.dart';
import 'package:tourtracking/utils/appConstant.dart';


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
        //get photo url from gravatar if user has one
        // Gravatar gravatar = Gravatar(email);
        // String gravatarUrl = gravatar.imageUrl(
        //   size: 200,
        //   defaultImage: GravatarImage.retro,
        //   rating: GravatarRating.pg,
        //   fileExtension: true,
        // );
        //create the new user object
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
    } catch (e) {
      return false;
    }
  }


  //updates the firestore users collection
  void _updateUserFirestore(UserModel user, User firebaseUser) {
    _db
        .doc('/users/${firebaseUser.uid}')
        .set(user.toJson());

    isLoading.value = false;

  }
}
