import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:tourtracking/controller/login_controller.dart';
import 'package:tourtracking/style/style.dart';
import 'package:tourtracking/view/auth/sign_up.dart';
import 'package:tourtracking/widget/customLoader.dart';
import 'package:tourtracking/widget/customTextField.dart';
import 'package:tourtracking/widget/loadin_button.dart';

class LoginScreen extends StatelessWidget {
  var loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(() => ModalProgressHUD(
          inAsyncCall: loginController.isLoading.value,
          progressIndicator: CustomLoader(),
          child: Scaffold(
            backgroundColor: Style.primaryColor,
            body: ListView(
              children: [
                topContainer(size),
                bottomContainer(size, context),
              ],
            ),
          ),
        ));
  }

  Container bottomContainer(Size size, BuildContext context) {
    return Container(
      height: size.height * .7,
      padding: EdgeInsets.only(left: size.width * .08, right: size.width * .08),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomTextField(
            controller: loginController.emailController,
            hints: "Email",
            inputType: TextInputType.emailAddress,
          ),
          SizedBox(height: size.height * 0.03),
          CustomTextField(
            controller: loginController.passwordController,
            hints: "Password",
            obscure: true,
          ),
          SizedBox(height: size.height * 0.09),
          LoadingButton(
            isLoading: false,
            defaultStyle: true,
            onPressed: () {
              loginController.doLogin();
            },
            backgroundColor: Style.primaryColor,
            text: "Login",
          ),
          SizedBox(height: size.height * .05),
          GestureDetector(
              onTap: () {
                //  loginController.goToForgotScreen();
              },
              child: Text(
                "Forgot password?",
                style: TextStyle(fontSize: 16),
              )),
          SizedBox(height: size.height * .02),
          GestureDetector(
              onTap: () {
                Get.to(SignUp());
              },
              child: Text(
                "Don't have account? Sign up",
                style: TextStyle(fontSize: 16),
              )),
          SizedBox(height: size.height * .1),
        ],
      ),
    );
  }

  Container topContainer(Size size) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      height: size.height * .3,
      child: Column(
        children: [
          SizedBox(height: size.height * .025),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "My Account",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: size.height * .18),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "SIGN IN",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
