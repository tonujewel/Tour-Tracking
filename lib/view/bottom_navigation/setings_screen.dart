import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourtracking/controller/settings_controller.dart';
import 'package:tourtracking/main.dart';
import 'package:tourtracking/style/style.dart';
import 'package:tourtracking/widget/custom_background.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {


  SettingsController controller = Get.put(SettingsController());


  String name = "", email = "";

  int successTour = 0, upcomingTour = 0;

  Stream list;

  @override
  void initState() {
    // user data
    FirebaseFirestore.instance
        .collection('users')
        .doc(prefs.getString("uid"))
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          name = documentSnapshot.data()['name'];
          email = documentSnapshot.data()['email'];
        });

        print('Document data: ${documentSnapshot.data()}');
        print('Document data: ${documentSnapshot.data()['name']}');
      } else {
        print('Document does not exist on the database');
      }
    });

    queryValues();

    //  print("user data ${documentStream.length}");

    super.initState();
  }

  void queryValues() {
    FirebaseFirestore.instance.collectionGroup('trip_list${prefs.getString("uid")}').snapshots().listen((snapshot) {
      int tempTotal = snapshot.docs.length;

      print("length  $tempTotal");
      setState(() {
        successTour = tempTotal;
      });
    });

    FirebaseFirestore.instance.collectionGroup('plan${prefs.getString("uid")}').snapshots().listen((snapshot) {
      int tempTotal = snapshot.docs.length;

      print("length  $tempTotal");
      setState(() {
        upcomingTour = tempTotal;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CustomBackground(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: size.height * .04, width: size.height * .02),
          profileSection(size, context),
          earningContainer(size),
          changePassword(size,"Update password"),
          changePassword(size,"About us"),
        ],
      ),
    );
  }

  GestureDetector changePassword(Size size, String text) {
    return GestureDetector(
      onTap: () {
       // Get.to(ChangePassword());
      },
      child: Container(
        margin: EdgeInsets.only(left: 15,right: 15,top: 15),
        padding: EdgeInsets.all(15),
        width: size.width,
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
                  "$text",
                  style: TextStyle(color: Style.primaryTextColor, fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container earningContainer(Size size) {
    return Container(
      margin: EdgeInsets.only(top: 15, left: 15, right: 15),
      padding: EdgeInsets.all(20),
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [Style.boxShadow],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total tour",
                    style: TextStyle(color: Style.secondaryTextColor),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "${successTour + upcomingTour}",
                    style: TextStyle(color: Style.primaryTextColor, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 5),
          Divider(
            thickness: 1,
            color: Color(0xffd1d8e0).withOpacity(0.5),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              tripColumn(
                "Upcoming tour",
                "$upcomingTour",
              ),
              tripColumn(
                "Success tour",
                "$successTour",
              ),
            ],
          )
        ],
      ),
    );
  }

  Row profileSection(Size size, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: size.width * .06),
            CircleAvatar(
              radius: 36,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 35,
                backgroundColor: Style.primaryColor,
                child: ClipOval(child: Image.asset("assets/image/placeholder.jpg")),
              ),
            ),
            SizedBox(width: size.width * .06),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$name",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  "$email",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        IconButton(
          icon: Icon(
            Icons.logout,
            color: Colors.white,
          ),
          onPressed: () {

            controller.doLogout();
          },
        ),
      ],
    );
  }

  Column tripColumn(String title, String data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$title", style: TextStyle(fontSize: 14, color: Style.secondaryTextColor)),
        Text(
          "$data",
          style: TextStyle(color: Style.primaryTextColor, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
