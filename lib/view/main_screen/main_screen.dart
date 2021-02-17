import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tourtracking/view/bottom_navigation/history_screen.dart';
import 'package:tourtracking/view/bottom_navigation/home_screen.dart';
import 'package:tourtracking/view/bottom_navigation/plan_screen.dart';
import 'package:tourtracking/view/bottom_navigation/profile_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _page = 0;
  final pages = [
    HomeScreen(),
    HistoryScreen(),
    PlanScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          index: 0,
          color: Colors.blue,
          buttonBackgroundColor: Colors.blue,
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          items: [
            Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
            Icon(Icons.history, color: Colors.white),
            Icon(Icons.next_plan_outlined, color: Colors.white),
            Icon(Icons.account_circle_outlined, color: Colors.white),
          ]),
      body: pages[_page],
    );
  }
}
