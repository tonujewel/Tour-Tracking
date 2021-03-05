import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:tourtracking/controller/expense_controller.dart';
import 'package:tourtracking/style/style.dart';
import 'package:tourtracking/view/expense/add_expense.dart';
import 'package:tourtracking/widget/customLoader.dart';
import 'package:tourtracking/widget/custom_appbar.dart';
import 'package:tourtracking/widget/empty_container.dart';

class ExpenseScreen extends StatefulWidget {
  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExpenseController>(
      init: ExpenseController(),
      builder: (_controller) {
        int num = _controller.snapshot?.length ?? 0;
        return ModalProgressHUD(
          inAsyncCall: _controller.loading,
          progressIndicator: CustomLoader(),
          child: Scaffold(
            backgroundColor: Style.backgroundColor,
            appBar: PreferredSize(
              preferredSize: Size(double.infinity, kToolbarHeight),
              child: CustomAppbar(title: "Expense"),
            ),
            body: num != 0
                ? ListView.builder(
                    itemCount: num,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => Get.to(AddExpense(
                                  tripID: _controller.snapshot[index]["trip_id"].toString(),
                                )),
                                child: Container(
                                  margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [Style.boxShadow],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      //snapshot[index].data['Views']
                                      Text(
                                        "${_controller.snapshot[index]['title']}",
                                        style: TextStyle(color: Style.primaryTextColor, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : EmptyContainer(),
          ),
        );
      },
    );
  }
}
