import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../main.dart';
import '../utils/appConstant.dart';
import 'package:path/path.dart' as p;

class AddTripController extends GetxController {
  CollectionReference addTrip = FirebaseFirestore.instance.collection('trip_list${prefs.getString("uid")}');
  var isLoading = false.obs;

  var imageUrl = "https://i.imgur.com/sUFH1Aq.png".obs;

  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();


  String randNumber;

  var selectedStartDate = "".obs;
  var selectedEndDate = "".obs;

  @override
  void onInit() {
    DateTime today = new DateTime.now();
    String dateSlug ="${today.day.toString()}-${today.month.toString().padLeft(2,'0')}-${today.year.toString().padLeft(2,'0')}";

    selectedStartDate.value = dateSlug;
    selectedEndDate.value = dateSlug;
    print(dateSlug);
    super.onInit();
  }

  Future<void> selectStartDate(BuildContext context) async {
    print("clicke");

    final DateTime picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      initialDate: DateTime.now(),
    );

    if (picked != null) {
      selectedStartDate.value ="${picked.day.toString()}-${picked.month.toString().padLeft(2,'0')}-${picked.year.toString().padLeft(2,'0')}";
      update();
      //   selectedStartDate = picked;

    }
  }

  Future<void> selectEndDate(BuildContext context) async {

    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      selectedEndDate.value ="${picked.day.toString()}-${picked.month.toString().padLeft(2,'0')}-${picked.year.toString().padLeft(2,'0')}";
      update();
    }
  }

  uploadImage() async {
    Random random = new Random();
    int randomNumber = random.nextInt(10000);

    final _imagePicker = ImagePicker();
    PickedFile image;

    //Select Image
    image = await _imagePicker.getImage(source: ImageSource.gallery);
    var file = File(image.path);

    if (image != null) {
      //Upload to Firebase

      final extension = p.extension(file.toString()); // '.dart'

      print("path $file");

      UploadTask task = FirebaseStorage.instance.ref().child('tour').child("$randomNumber$extension").putFile(file);

      task.then((TaskSnapshot snapshot) async {
        print('Upload complete! $snapshot.');

        String downloadURL = await FirebaseStorage.instance.ref("tour/$randomNumber$extension").getDownloadURL();

        imageUrl.value = downloadURL;

        randNumber = randomNumber.toString();
        print('image url $downloadURL');
      }).catchError((Object e) {
        print(e); // FirebaseException
      });
    } else {
      print('No Image Path Received');
    }
  }

  saveData({@required name, @required lat, @required long}) {
    if (title.text.isEmpty) {
      errorSnackbar("Title field required");
    } else if (desc.text.isEmpty) {
      errorSnackbar("Description field required");
    } else if (name.isEmpty) {
      errorSnackbar("Location field required");
    }
      else {
      sendToFireStore(name: name, lat: lat, long: long);
    }
  }

  Future<void> sendToFireStore({@required name, @required lat, @required long}) {
    isLoading.value = true;
    // Call the user's CollectionReference to add a new user
    return addTrip.add({
      'title': title.text, // John Doe
      'description': desc.text, // Stokes and Sons
      'startDate':selectedStartDate,
      'endDate': selectedEndDate,
      'locationName': name,
      'lat': lat,
      'long': long,
      'image': "${imageUrl.value}",
      'trip_id': '$randNumber'
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
