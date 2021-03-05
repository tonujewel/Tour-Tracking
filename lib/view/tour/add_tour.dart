import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:tourtracking/controller/tour_controller.dart';
import 'package:tourtracking/widget/customLoader.dart';
import 'package:tourtracking/widget/customText.dart';
import 'package:tourtracking/widget/custom_appbar.dart';
import '../../style/style.dart';
import '../../widget/customTextField.dart';
import '../../widget/loadin_button.dart';

class AddTour extends StatefulWidget {
  String name, lat, long;

  AddTour({@required this.name, @required this.lat, @required this.long});

  @override
  _AddTourState createState() => _AddTourState();
}

class _AddTourState extends State<AddTour> {
  var controller = Get.put(TourController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(() => ModalProgressHUD(
          inAsyncCall: controller.isLoading.value,
          progressIndicator: CustomLoader(),
          child: Scaffold(
            backgroundColor: Style.backgroundColor,
            appBar: PreferredSize(
              preferredSize: Size(double.infinity, kToolbarHeight),
              child: CustomAppbar(title: "Add Tour"),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: size.height * .04),
                    Obx(
                      () => GestureDetector(
                        onTap: () {
                          controller.uploadImage();
                        },
                        child: CircleAvatar(
                          radius: size.height * .083,
                          backgroundColor: Style.primaryColor,
                          child: CircleAvatar(
                            radius: size.height * .08,
                            backgroundImage: NetworkImage(
                              controller.imageUrl.value,
                            ),
                          ),
                        ),
                      ),
                    ),
                    CustomText(text: "${widget.name}"),
                    CustomTextField(controller: controller.title, hints: "Trip title"),
                    SizedBox(height: size.height * .02),
                    CustomTextField(controller: controller.desc, hints: "Trip summary"),
                    SizedBox(height: size.height * .02),
                    GestureDetector(
                      onTap: () {
                        controller.selectStartDate(context);
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 20, top: 15, bottom: 15, right: 20),
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Style.primaryColor)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Start Date",
                              style: TextStyle(fontSize: 15, color: Style.secondaryTextColor),
                            ),
                            Obx(
                              () => Text(
                                controller.selectedStartDate.toString(),
                                style: TextStyle(fontSize: 15, color: Style.secondaryTextColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * .02),
                    GestureDetector(
                      onTap: () {
                        controller.selectEndDate(context);
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 20, top: 15, bottom: 15, right: 20),
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Style.primaryColor)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "End Date",
                              style: TextStyle(fontSize: 15, color: Style.secondaryTextColor),
                            ),
                            Obx(
                              () => Text(
                                controller.selectedEndDate.value.toString(),
                                style: TextStyle(fontSize: 15, color: Style.secondaryTextColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * .02),
                    LoadingButton(
                      isLoading: false,
                      defaultStyle: true,
                      onPressed: () {
                        controller.saveData(name: widget.name, lat: widget.lat, long: widget.long);
                        //  controller.saveData();
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
