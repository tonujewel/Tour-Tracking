import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourtracking/main.dart';
import 'package:tourtracking/style/style.dart';
import 'package:tourtracking/widget/custom_background.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String name = "", email = "";

  @override
  void initState() {
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

    //  print("user data ${documentStream.length}");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CustomBackground(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: size.height * .04, width: size.height * .02),
          prifileSection(size, context),
          earningContainer(size),
          changePassword(size),
        ],
      ),
    );
  }

  GestureDetector changePassword(Size size) {
    return GestureDetector(
      onTap: () {
        // Get.to(UpdatePassword());
      },
      child: Container(
        margin: EdgeInsets.all(15),
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
                  "Update password",
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
                    "11",
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
                "1",
              ),
              tripColumn(
                "Success tour",
                "10",
              ),
            ],
          )
        ],
      ),
    );
  }

  Row prifileSection(Size size, BuildContext context) {
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
            //  profileController.logoutAction(context);

            // prefs.setBool(AppConstant.isLogin, false);
            // Get.offAll(LoginScreen());
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
