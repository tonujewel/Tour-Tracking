import 'package:flutter/material.dart';
import 'package:tourtracking/style/style.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  TextEditingController controller;
  String hints;
  TextInputType inputType;
  int maxDigit;
  bool obscure = false;

  CustomTextField(
      {@required this.controller,
        @required this.hints,
        this.inputType,
        this.maxDigit,
        this.obscure});

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.next,
      maxLength: maxDigit==null?1000:maxDigit,
      keyboardType: inputType==null?TextInputType.text:inputType,
      controller: controller,
      obscureText: obscure==null?false:obscure,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 15),
        hintText: hints,
        hintStyle: TextStyle(color: Style.secondaryTextColor),
        filled: true,
        counterText: "",
        fillColor: Colors.white70,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Style.primaryColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Style.primaryColor),
        ),
      ),
    );
  }
}
