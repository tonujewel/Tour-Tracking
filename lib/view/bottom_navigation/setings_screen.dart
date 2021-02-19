import 'package:flutter/material.dart';
import 'package:tourtracking/style/style.dart';

class SettingsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            settingItemContainer(icon: Icon(Icons.person_outline), text: "Profile"),
            settingItemContainer(icon: Icon(Icons.account_balance_outlined), text: "Account"),
            settingItemContainer(icon: Icon(Icons.notifications_outlined), text: "Notification"),
            settingItemContainer(icon: Icon(Icons.login_outlined), text: "Logout"),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Container settingItemContainer({@required Icon icon, @required String text,Icon forward}) {
    return Container(
            margin: EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFFE3E8F0),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 15),
                             icon,
                              SizedBox(width: 15),
                              Text(text,style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right:15),
                            child: Icon(Icons.arrow_forward_ios,size: 18,),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          );
  }
}
