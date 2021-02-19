import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourtracking/controller/add_trip_controller.dart';
import 'package:tourtracking/widget/customText.dart';

import '../../style/style.dart';
import '../../widget/customTextField.dart';
import '../../widget/loadin_button.dart';

class AddTrip extends StatelessWidget {
  var controller = Get.put(AddTripController());

  String name, lat, long;

  AddTrip({@required this.name, @required this.lat, @required this.long});

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
              CustomText(text: "$name"),
              SizedBox(height: size.height * .02),
              CustomTextField(controller: controller.title, hints: "Trip title"),
              SizedBox(height: size.height * .02),
              CustomTextField(controller: controller.desc, hints: "Trip summary"),
              SizedBox(height: size.height * .02),
              CustomTextField(controller: controller.title, hints: "Upload Image"),
              SizedBox(height: size.height * .02),
              CustomTextField(controller: controller.startDate, hints: "Start date"),
              SizedBox(height: size.height * .02),
              CustomTextField(controller: controller.endDate, hints: "End date"),
              SizedBox(height: size.height * .04),
              Obx(() => LoadingButton(
                  isLoading: controller.isLoading.value,
                  defaultStyle: true,
                  onPressed: () {
                    controller.saveData(name: name, lat: lat, long: long);
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
