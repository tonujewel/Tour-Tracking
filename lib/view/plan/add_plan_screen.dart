import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:tourtracking/controller/plan_controller.dart';
import 'package:tourtracking/style/style.dart';
import 'package:tourtracking/widget/customLoader.dart';
import 'package:tourtracking/widget/customTextField.dart';
import 'package:tourtracking/widget/custom_appbar.dart';
import 'package:tourtracking/widget/loadin_button.dart';

class AddPlanScreen extends StatelessWidget {


  AddPlanController controller = Get.put(AddPlanController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(()=>ModalProgressHUD(
      inAsyncCall:controller.isLoading.value ,
      progressIndicator: CustomLoader(),
      child: Scaffold(
        backgroundColor: Style.backgroundColor,
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: CustomAppbar(title:"Add upcoming tour"),
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
                LoadingButton(
                  isLoading: false,
                  defaultStyle: true,
                  onPressed: () {
                    controller.saveData();
                    Get.reset();
                  },
                  backgroundColor: Style.buttonColor,
                  text: "Save",
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}