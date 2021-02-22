import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourtracking/style/style.dart';
import 'package:tourtracking/view/trip/add_location.dart';
import 'package:tourtracking/view/trip/add_trip.dart';

import '../../main.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tour List"),
      ),
      floatingActionButton: FloatingActionButton(
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
                        padding: EdgeInsets.only(left: 15, top: 6, bottom: 6),
                        margin: EdgeInsets.only(left: 20, top: 15, right: 20),
                        decoration: BoxDecoration(
                          color: Color(0xFFE3E8F0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${doc["title"]}",
                              style: TextStyle(fontSize: 18, letterSpacing: 2, color: Style.textColor),
                            ),
                            Text(
                              "${doc["locationName"]}",
                              style: TextStyle(letterSpacing: 1, color: Style.textColor),
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
