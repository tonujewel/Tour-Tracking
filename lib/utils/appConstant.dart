
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppConstant{



}

void errorSnackbar(
    String msg,
    ) {
  return Get.snackbar('Error', "$msg",
      snackPosition: SnackPosition.TOP, backgroundColor: Colors.red[400], colorText: Colors.white);
}

void successSnackbar(String msg) {
  return Get.snackbar('Success', "$msg",
      snackPosition: SnackPosition.TOP, backgroundColor: Colors.green[400], colorText: Colors.white);
}