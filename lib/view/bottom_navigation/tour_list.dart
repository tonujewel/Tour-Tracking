import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourtracking/style/style.dart';
import 'package:tourtracking/view/trip/add_location.dart';
import 'package:tourtracking/view/trip/add_trip.dart';
import 'package:tourtracking/widget/custom_appbar.dart';

import '../../main.dart';

class TourListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight),
        child: CustomAppbar(title:"Tour List"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Style.floatingBgColor,
        onPressed: () {
          Get.to(AddLocation());
        },
        child: Icon(Icons.add),
      ),
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
        .map((doc) => Container(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 15,right: 15,top: 15),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [Style.boxShadow],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${doc["title"]}",
                              style: TextStyle(fontSize: 18,  color: Style.textColor),
                            ),
                            Text(
                              "${doc["locationName"]}",
                              style: TextStyle( color: Style.textColor),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ))
        // .map((doc) => new ListTile(title:  Text(doc["title"]), subtitle: new Text(doc["trip_id"].toString())))
        .toList();
  }
}
