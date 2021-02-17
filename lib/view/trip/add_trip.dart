import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourtracking/controller/add_trip_controller.dart';

import '../../style/style.dart';
import '../../widget/customTextField.dart';
import '../../widget/loadin_button.dart';

class AddTrip extends StatelessWidget {

  var controller = Get.put(AddTripController());
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
              Text("Add Trip", style: TextStyle(color: Style.textColor, fontWeight: FontWeight.bold, fontSize: 30)),
              SizedBox(height: size.height * .04),
              CustomTextField(controller: controller.title, hints: "Title"),
              SizedBox(height: size.height * .03),
              CustomTextField(controller: controller.desc, hints: "description"),
              SizedBox(height: size.height * .04),
              Obx(
                () => LoadingButton(
                  isLoading: controller.isLoading.value,
                  defaultStyle: true,
                  onPressed: () {
                    controller.saveData();
                  },
                  backgroundColor: Style.buttonColor,
                  text: "Save",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
