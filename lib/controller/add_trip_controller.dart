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
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();


  saveData({@required name, @required lat, @required long}) {
    if (title.text.isEmpty) {
      errorSnackbar("Title field required");
    } else if (desc.text.isEmpty) {
      errorSnackbar("Description field required");
    }else if (name.isEmpty) {
      errorSnackbar("Location field required");
    }else if (startDate.text.isEmpty) {
      errorSnackbar("Start Date field required");
    } else if (endDate.text.isEmpty) {
      errorSnackbar("End Date field required");
    } else {
      sendToFireStore(name: name, lat: lat, long: long);
    }
  }

  Future<void> sendToFireStore({@required name, @required lat, @required long}) {
    isLoading.value = true;
    // Call the user's CollectionReference to add a new user
    return addTrip.add({
      'title': title.text, // John Doe
      'desctription': desc.text, // Stokes and Sons
      'startDate': startDate.text,
      'endDate': endDate.text,
      'locationName':name,
      'lat':lat,
      'long':long,
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
