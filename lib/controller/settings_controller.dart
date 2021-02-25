import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tourtracking/main.dart';

class SettingsController extends GetxController{

  void doLogout(){
    SystemNavigator.pop();
  }



}