import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collectionGroup('trip_list${prefs.getString("uid")}').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return new Text("There is no expense");
          return new ListView(children: getExpenseItems(snapshot));
        });
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.docs
        .map((doc) => new ListTile(title: new Text(doc["title"]), subtitle: new Text(doc["desctription"].toString())))
        .toList();
  }
}