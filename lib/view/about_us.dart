import 'package:flutter/material.dart';
import 'package:tourtracking/widget/custom_container.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEF5FF),
      appBar: AppBar(
        title: Center(child: Text('About us')),
      ),
      body: ListView(
        children: [
          CustomContainer(
            name: 'Jewel Rana',
            description: 'Description',
            imagePath: 'assets/image/jewel.jpg',
          ),
          CustomContainer(
            name: 'Rasel Re',
            description: 'Description',
            imagePath: 'assets/image/rasel.jpg',
          ),
          CustomContainer(
            name: 'Mehedi',
            description: 'Description',
            imagePath: 'images/8f.jpg',
          ),
          CustomContainer(
            name: 'Sumiya ',
            description: 'Description',
            imagePath: 'assets/image/sumaiya.jpg',
          ),
        ],
      ),
    );
  }
}
