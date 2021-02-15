import 'package:flutter/material.dart';
import 'package:tourtracking/style/style.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  TextEditingController controller;
  String hints;
  TextInputType inputType;
  bool obscure = false;

  CustomTextField({@required this.controller, @required this.hints, this.inputType, this.obscure});

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Container(
      height: 61,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                color: Color(0xFFE3E8F0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                controller: controller,
                obscureText: obscure == null ? false : obscure,
                keyboardType: inputType == null ? TextInputType.text : inputType,
                style: TextStyle(fontSize: 22,letterSpacing: 2, color: Style.textColor, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: "$hints",
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontSize: 22, color: Style.hintsColor, fontWeight: FontWeight.bold),
                ),
                textInputAction: TextInputAction.next,
                onEditingComplete: () => node.nextFocus(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
