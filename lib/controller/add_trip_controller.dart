import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../main.dart';
import '../utils/appConstant.dart';

class AddTripController extends GetxController {
  CollectionReference addTrip = FirebaseFirestore.instance.collection('trip_list${prefs.getString("uid")}');
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
    }
    else {
      sendToFireStore();
    }
  }

  Future<void> sendToFireStore() {
    isLoading.value = true;
    // Call the user's CollectionReference to add a new user
    return addTrip.add({

      'title': title.text, // John Doe
      'desctription': desc.text, // Stokes and Sons
      'location' : location.text,
      'startDate': startDate.text,
      'endDate': endDate.text,
    }).then((value) {
      isLoading.value = false;
      Get.back();
      successSnackbar("Trip added");

    }).catchError((error) {
      isLoading.value = false;
      errorSnackbar("$error");
      print("Failed to add user: $error");
    });
  }
}
