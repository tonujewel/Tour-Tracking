import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourtracking/controller/login_controller.dart';
import 'package:tourtracking/style/style.dart';
import 'package:tourtracking/widget/customTextField.dart';
import 'package:tourtracking/widget/loadin_button.dart';


class LoginScreen extends StatelessWidget {
  var controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Style.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: size.height * .2),
              Text("Sign In", style: TextStyle(color: Style.textColor, fontWeight: FontWeight.bold, fontSize: 30)),
              SizedBox(height: size.height * .04),
              CustomTextField(controller: controller.emailController, hints: "Email"),
              SizedBox(height: size.height * .03),
              CustomTextField(controller: controller.passwordController, hints: "Password", obscure: true),
              SizedBox(height: size.height * .04),
              Obx(() => LoadingButton(
                  isLoading: controller.isLoading.value,
                  defaultStyle: true,
                  onPressed: () {
                    controller.doLogin();
                  },
                  backgroundColor: Style.buttonColor,
                  text: "Login",
                ),
              ),
              SizedBox(height: size.height * .03),
              Center(child: Text("Forgot password?", style: TextStyle(color: Style.textColor, fontSize: 16))),
              SizedBox(height: size.height * .03),
              GestureDetector(
                  onTap: () {
                    controller.goToSignUpPage();
                  },
                  child:
                      Center(child: Text("Don't have account?", style: TextStyle(color: Style.textColor, fontSize: 16)))),
            ],
          ),
        ),
      ),
    );
  }
}
