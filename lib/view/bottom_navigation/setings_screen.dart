import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourtracking/style/style.dart';
import 'package:tourtracking/widget/custom_background.dart';

class SettingsScreen extends StatelessWidget {


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
          pendingContainer(size),
          changePassword(size),
        ],
      )
    );
  }

  GestureDetector changePassword(Size size) {
    return GestureDetector(
      onTap: (){
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
                    "Total Order",
                    style: TextStyle(color: Style.secondaryTextColor),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "BDT 50",
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
                "Total Payment",
                "BDT 500",
              ),

              tripColumn(
                "Success Order",
                "10",
              ),
            ],
          )
        ],
      ),
    );
  }

  Container pendingContainer(Size size) {
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
                    "Total Pending",
                    style: TextStyle(color: Style.secondaryTextColor),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "BDT 10",
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
                "Pending Order",
                "10",
              ),

              tripColumn(
                "Today's Order",
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
                child: ClipOval(child: Image.asset("assets/images/placeholder.jpg")),
              ),
            ),
            SizedBox(width: size.width * .06),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "{userDm.data.name}",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  "{userDm.data.mobile}",
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
