import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourtracking/controller/add_expense_controller.dart';
import 'package:tourtracking/style/style.dart';
import 'package:tourtracking/widget/customTextField.dart';
import 'package:tourtracking/widget/loadin_button.dart';

class AddExpense extends StatefulWidget {
  String tripID;

  AddExpense({@required this.tripID});

  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  AddExpenseController addExpenseController = Get.put(AddExpenseController());

  double totalAmount;

  @override
  initState() {
    super.initState();
    queryValues();
  }

  void queryValues() {
    FirebaseFirestore.instance.collectionGroup('expense${widget.tripID}}').snapshots().listen((snapshot) {
      double tempTotal = snapshot.docs.fold(0, (tot, doc) => tot + double.parse(doc['item_price']));
      setState(() {
        totalAmount = tempTotal;
      });
      debugPrint(totalAmount.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense details"),
      ),
      body: Column(
        children: [
          Text("Total spend : $totalAmount"),
          Row(
            children: [
              Container(
                width: size.width * .4,
                child: CustomTextField(controller: addExpenseController.itemNameController, hints: "Item name"),
              ),
              Container(
                width: size.width * .2,
                child: CustomTextField(
                  controller: addExpenseController.itemPriceController,
                  hints: "price",
                  inputType: TextInputType.number,
                ),
              ),
              Container(
                  width: size.width * .2,
                  child: LoadingButton(
                    isLoading: false,
                    defaultStyle: true,
                    onPressed: () {
                      addExpenseController.addExpenseData(widget.tripID);
                    },
                    backgroundColor: Style.buttonColor,
                    text: "Add",
                  )),
            ],
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collectionGroup('expense${widget.tripID}}').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return new Text("There is no expense");
                // return  ListView(children: getExpenseItems(snapshot));
                return new ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    print("${snapshot.data.docs[index]["item_price"]}");
                    return ListTile(
                      title: Text("${snapshot.data.docs[index]['item_name']}"),
                      trailing: Text("${snapshot.data.docs[index]['item_price']}"),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.docs.map((doc) {
      ListTile(
        title: Text(doc["item_name"]),
        subtitle: Text(
          doc["item_price"].toString(),
        ),
      );
    }).toList();
  }
}
