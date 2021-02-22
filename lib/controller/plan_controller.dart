import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourtracking/main.dart';
import 'package:tourtracking/utils/appConstant.dart';

class AddPlanController extends GetxController{



  CollectionReference addPlanningTrip = FirebaseFirestore.instance.collection('plan${prefs.getString("uid")}');
  var isLoading = false.obs;

  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();

  saveData() {
    if (title.text.isEmpty) {
      errorSnackbar("Title field required");
    } else if (desc.text.isEmpty) {
      errorSnackbar("Description field required");
    }else if (location.text.isEmpty) {
      errorSnackbar("Location field required");
    }else if (startDate.text.isEmpty) {
      errorSnackbar("Start Date field required");
    } else if (endDate.text.isEmpty) {
      errorSnackbar("End Date field required");
    } else {
      sendToFireStore();
    }
  }

  Future<void> sendToFireStore() {
    isLoading.value = true;
    Random random = new Random();
    int randomNumber = random.nextInt(10000);
    // Call the user's CollectionReference to add a new user
    return addPlanningTrip.add({
      'title': title.text, // John Doe
      'description': desc.text, // Stokes and Sons
      'startDate': startDate.text,
      'endDate': endDate.text,
      'locationName':location.text,
      'trip_id':'$randomNumber'
    }).then((value) {
      isLoading.value = false;
      Get.back();
      successSnackbar("Upcoming trip added");
    }).catchError((error) {
      isLoading.value = false;
      errorSnackbar("$error");
      print("Failed to add user: $error");
    });
  }
}
