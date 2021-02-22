import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourtracking/controller/add_trip_controller.dart';
import 'package:tourtracking/controller/plan_controller.dart';
import 'package:tourtracking/style/style.dart';
import 'package:tourtracking/widget/customText.dart';
import 'package:tourtracking/widget/customTextField.dart';
import 'package:tourtracking/widget/loadin_button.dart';

class AddPlanScreen extends StatelessWidget {


  AddPlanController controller = Get.put(AddPlanController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Style.backgroundColor,
      appBar: AppBar(
        title: Text("Add Trip", style: TextStyle(color: Style.textColor, fontWeight: FontWeight.bold, fontSize: 15)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: size.height * .04),

              CustomTextField(controller: controller.title, hints: "Title"),
              SizedBox(height: size.height * .02),
              CustomTextField(controller: controller.desc, hints: "Description"),
              SizedBox(height: size.height * .02),
              CustomTextField(controller: controller.location, hints: "Location"),
              SizedBox(height: size.height * .02),
              CustomTextField(controller: controller.startDate, hints: "Start date"),
              SizedBox(height: size.height * .02),
              CustomTextField(controller: controller.endDate, hints: "End date"),
              SizedBox(height: size.height * .04),
              Obx(() => LoadingButton(
                isLoading: controller.isLoading.value,
                defaultStyle: true,
                onPressed: () {
                  controller.saveData();
                  Get.reset();
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