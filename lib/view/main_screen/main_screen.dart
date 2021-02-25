import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tourtracking/style/style.dart';
import 'package:tourtracking/view/bottom_navigation/expense_screen.dart';
import 'package:tourtracking/view/bottom_navigation/tour_list.dart';
import 'package:tourtracking/view/bottom_navigation/home_screen.dart';
import 'package:tourtracking/view/bottom_navigation/plan_screen.dart';
import 'package:tourtracking/view/bottom_navigation/setings_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _page = 2;
  final pages = [
    ExpenseScreen(),
    TourListScreen(),
    HomeScreen(),
    PlanScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          index: 2,
          color: Style.primaryColor,
          buttonBackgroundColor: Style.primaryColor,
          backgroundColor: Style.backgroundColor,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          items: [
            Icon(Icons.monetization_on_outlined, color: Colors.white),
            Icon(Icons.flight, color: Colors.white),
            Icon(Icons.home_outlined, color: Colors.white),
            Icon(Icons.next_plan_outlined, color: Colors.white),
            Icon(Icons.account_circle_outlined, color: Colors.white),
          ]),
      body: pages[_page],
    );
  }
}
