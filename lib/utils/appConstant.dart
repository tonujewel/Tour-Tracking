import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppConstant {
  static List<Map<String, dynamic>> list = [
    {"title": "one", "id": "1", "lat": 23.7985053, "lon": 90.3842538},
    {"title": "two", "id": "2", "lat": 23.802236, "lon": 90.3700},
    {"title": "three", "id": "3", "lat": 23.8061939, "lon": 90.3771193},
  ];

  static String uid = "";
}

void errorSnackbar(
  String msg,
) {
  return Get.snackbar('Error', "$msg",
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red[400],
      colorText: Colors.white);
}

void successSnackbar(String msg) {
  return Get.snackbar('Success', "$msg",
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green[400],
      colorText: Colors.white);
}
