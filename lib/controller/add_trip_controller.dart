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

  saveData() {
    if (title.text.isEmpty) {
      errorSnackbar("Title field required");
    } else if (desc.text.isEmpty) {
      errorSnackbar("Desctription field required");
    } else {
      sendToFireStore();
    }
  }

  Future<void> sendToFireStore() {
    isLoading.value = true;
    // Call the user's CollectionReference to add a new user
    return addTrip.add({

      'title': title.text, // John Doe
      'desctription': desc.text, // Stokes and Sons
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
