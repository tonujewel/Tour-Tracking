import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:tourtracking/style/style.dart';
import 'package:tourtracking/view/trip/add_location.dart';
import 'package:tourtracking/widget/customLoader.dart';
import 'package:tourtracking/widget/custom_appbar.dart';
import 'package:tourtracking/widget/empty_container.dart';

import '../../main.dart';

class TourListScreen extends StatefulWidget {
  @override
  _TourListScreenState createState() => _TourListScreenState();
}

class _TourListScreenState extends State<TourListScreen> {
  // show expense
  bool loading = false;

  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> snapshot;
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('trip_list${prefs.getString("uid")}');

  @override
  void initState() {
    //  show tour
    loading = true;
    subscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        snapshot = datasnapshot.docs;
        loading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int num = snapshot?.length ?? 0;

    return ModalProgressHUD(
      inAsyncCall: loading,
      progressIndicator: CustomLoader(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Style.floatingBgColor,
          onPressed: () {
            Get.to(AddLocation());
          },
          child: Icon(Icons.add),
        ),
        backgroundColor: Style.backgroundColor,
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: CustomAppbar(title: "Tour List"),
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
                            // onTap: () => Get.to(AddExpense(
                            //   tripID: _controller.snapshot[index]["trip_id"].toString(),
                            // )),
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
                                    "${snapshot[index]['title']}",
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
  }
}
