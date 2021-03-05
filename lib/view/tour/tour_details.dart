import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:tourtracking/style/style.dart';
import 'package:tourtracking/widget/custom_appbar.dart';

class TourDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight),
        child: CustomAppbar(title: "Tour Details"),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: Get.height * .04),
          CircleAvatar(
            radius: Get.height * .083,
            backgroundColor: Style.primaryColor,
            child: CircleAvatar(
              radius: Get.height * .08,
              backgroundImage: NetworkImage(
                "image",
              ),
            ),
          ),


          Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 15),
            padding: EdgeInsets.all(15),
            width: Get.width,
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
                      "",
                      style: TextStyle(color: Style.primaryTextColor, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          )


        ],
      ),
    );
  }
}
