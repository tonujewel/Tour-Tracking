import 'package:flutter/material.dart';
import 'package:tourtracking/widget/customTextField.dart';

class AddExpense extends StatelessWidget {
  String tripID;

  AddExpense({@required this.tripID});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense details"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Total spend : "),
          Row(
            children: [
              Container(
                width: size.width * .4,
                child: CustomTextField(controller: null, hints: "Item name"),
              ),
              Container(
                width: size.width * .4,
                child: Expanded(child: CustomTextField(controller: null, hints: "price")),
              ),
            ],
          )
        ],
      ),
    );
  }
}
