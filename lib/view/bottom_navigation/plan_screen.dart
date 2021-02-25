import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourtracking/main.dart';
import 'package:tourtracking/style/style.dart';
import 'package:tourtracking/view/plan/add_plan_screen.dart';
import 'package:tourtracking/widget/custom_appbar.dart';

class PlanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight),
        child: CustomAppbar(title: "Up coming tour"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Style.floatingBgColor,
        onPressed: () {
          Get.to(AddPlanScreen());
        },
        child: Icon(Icons.add),
      ),
      body: new StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collectionGroup('plan${prefs.getString("uid")}').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return new Text("There is no expense");
            return new ListView(children: getExpenseItemss(snapshot));
          }),
    );
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.docs
        .map((doc) => new ListTile(title: new Text(doc["title"]), subtitle: new Text(doc["locationName"].toString())))
        .toList();
  }

  getExpenseItemss(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.docs
        .map(
          (doc) => Container(
            margin: EdgeInsets.only(left: 15,right: 15,top: 15),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [Style.boxShadow],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      doc["title"],
                      style: TextStyle(color: Style.primaryTextColor, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      doc["locationName"],
                      style: TextStyle(color: Style.primaryTextColor, fontSize: 14),
                    ),

                    Text(
                      doc["startDate"],
                      style: TextStyle(color: Style.primaryTextColor, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
        .toList();
  }
}
