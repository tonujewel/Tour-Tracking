import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourtracking/main.dart';
import 'package:tourtracking/view/plan/add_plan_screen.dart';

class PlanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upcoming Tour"),),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddPlanScreen());
        },
        child: Icon(Icons.add),
      ),
      body: new StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collectionGroup('plan${prefs.getString("uid")}').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return new Text("There is no expense");
            return new ListView(children: getExpenseItems(snapshot));
          }),
    );
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.docs
        .map((doc) => new ListTile(title: new Text(doc["title"]), subtitle: new Text(doc["locationName"].toString())))
        .toList();
  }
}
