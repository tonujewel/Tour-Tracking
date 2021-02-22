import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tourtracking/utils/appConstant.dart';

class AddExpenseController extends GetxController{


  var isLoading = false.obs;

  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();


  Future<void> addExpenseData(String tripid) async {
    CollectionReference addExpense = FirebaseFirestore.instance.collection('expense$tripid}');
    Random random = new Random();
    int randomNumber = random.nextInt(10000);
    if(itemNameController.text.isEmpty){
      errorSnackbar('Item name field required');
    }else if(itemPriceController.text.isEmpty){
      errorSnackbar('Item price field required');
    }else{

      isLoading.value = true;
      return addExpense.add({
        'expense_id':'$randomNumber',
        'item_name': itemNameController.text,
        'item_price': itemPriceController.text,
      }).then((value) {
        isLoading.value = false;
        itemPriceController.clear();
        itemNameController.clear();
      }).catchError((error) {
        isLoading.value = false;
        errorSnackbar("$error");
        print("Failed to add user: $error");
      });

    }
  }

}