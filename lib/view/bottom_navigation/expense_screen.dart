import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourtracking/main.dart';
import 'package:tourtracking/view/expense/add_expense.dart';

class ExpenseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collectionGroup('trip_list${prefs.getString("uid")}').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return new Text("There is no expense");
            return new ListView(children: getExpenseItems(snapshot));
          }),
    );
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.docs
        .map((doc) => new ListTile(
            onTap: () => Get.to(AddExpense(tripID: doc["trip_id"].toString(),)),
            title: new Text(doc["trip_id"].toString())))
        .toList();
  }
}
