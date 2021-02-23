import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourtracking/main.dart';
import 'package:tourtracking/style/style.dart';
import 'package:tourtracking/view/expense/add_expense.dart';

class ExpenseScreen extends StatefulWidget {


  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {

  double totalAmount;
  @override
  void initState() {
   queryValues();
    super.initState();
  }

  double  queryValues(String id) {
    FirebaseFirestore.instance.collectionGroup('expense$id').snapshots().listen((snapshot) {
      double tempTotal = snapshot.docs.fold(0, (tot, doc) => tot + double.parse(doc['item_price']));

      print("$tempTotal");
      return  tempTotal;

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense"),
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
        .map(
          (doc) => Container(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Get.to(AddExpense(
                      tripID: doc["trip_id"].toString(),
                    )),
                    child: Container(
                      padding: EdgeInsets.only(left: 15, top: 6, bottom: 6),
                      margin: EdgeInsets.only(left: 15, top: 10, right: 15),
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
                            "${queryValues(doc["trip_id"])}",
                            style: TextStyle(fontSize: 18, letterSpacing: 2, color: Style.textColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();
  }
}

// onTap: () => Get.to(AddExpense(tripID: doc["trip_id"].toString(),)),
