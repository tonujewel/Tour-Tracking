import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourtracking/controller/sign_up_controller.dart';
import 'package:tourtracking/style/style.dart';
import 'package:tourtracking/widget/customTextField.dart';
import 'package:tourtracking/widget/loadin_button.dart';


class SignUp extends StatelessWidget {
  var controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Style.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: ListView(
          children: [
            SizedBox(height: size.height * .2),
            Text("Sign Up",
                style: TextStyle(
                    color: Style.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30)),
            SizedBox(height: size.height * .04),
            CustomTextField(
                controller: controller.nameController, hints: "Name"),
            SizedBox(height: size.height * .03),
            CustomTextField(
                controller: controller.emailController, hints: "Email"),
            SizedBox(height: size.height * .03),
            CustomTextField(
                controller: controller.passwordController,
                hints: "Password",
                obscure: true),
            SizedBox(height: size.height * .03),
            CustomTextField(
                controller: controller.confirmPasswordController,
                hints: "Confirm Password",
                obscure: true),
            SizedBox(height: size.height * .03),
            Obx(() => LoadingButton(
                  onPressed: () {
                    controller.doSignUp();
                  },
                  text: "Sign Up",
                  isLoading: controller.isLoading.value,
                )),
            SizedBox(height: size.height * .03),
            Center(
                child: Text("Already have account?",
                    style: TextStyle(color: Style.textColor, fontSize: 16))),
          ],
        ),
      ),
    );
  }
}
