import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourtracking/controller/sign_up_controller.dart';
import 'package:tourtracking/style/style.dart';
import 'package:tourtracking/view/auth/login.dart';
import 'package:tourtracking/widget/customTextField.dart';
import 'package:tourtracking/widget/loadin_button.dart';

class SignUp extends StatelessWidget {
  var controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Style.primaryColor,
      body: ListView(
        children: [
          topContainer(size),
          bottomContainer(size, context),
        ],
      ),
    );
  }

  Container bottomContainer(Size size, BuildContext context) {
    return Container(
      height: size.height * .7,
      padding: EdgeInsets.only(left: size.width * .08, right: size.width * .08),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.03),

            CustomTextField(
              controller: controller.nameController,
              hints: "Name",
              inputType: TextInputType.name,
            ),
            SizedBox(height: size.height * 0.03),
            CustomTextField(
              controller: controller.emailController,
              hints: "Email",
              inputType: TextInputType.emailAddress,
            ),
            SizedBox(height: size.height * 0.03),
            CustomTextField(
              controller: controller.passwordController,
              hints: "Password",
              obscure: true,
            ),
            SizedBox(height: size.height * 0.03),
            CustomTextField(
              controller: controller.confirmPasswordController,
              hints: "Confirm Password",
              obscure: true,
            ),
            SizedBox(height: size.height * 0.03),
            Obx(
              () => LoadingButton(
                isLoading: controller.isLoading.value,
                defaultStyle: true,
                onPressed: () {
                  controller.doSignUp();
                },
                backgroundColor: Style.primaryColor,
                text: "Sign Up",
              ),
            ),
            SizedBox(height: size.height * .05),
            GestureDetector(
                onTap: () {
                  Get.off(LoginScreen());
                },
                child: Text(
                  "Already have an account? Sign In",
                  style: TextStyle(fontSize: 16),
                )),
            SizedBox(height: size.height * .1),
          ],
        ),
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
                "SIGN UP",
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
