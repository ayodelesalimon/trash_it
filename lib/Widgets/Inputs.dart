import 'package:flutter/material.dart';
import 'package:trash_it/Resources/Resources.dart';

// ignore: must_be_immutable
class InputWidget extends StatelessWidget {
  String? hintText;
  bool obscureText = false;
  InputWidget({this.hintText, required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        shape: BoxShape.rectangle,
        color: R.colors.whiteMainColor,
      ),
      child: TextField(
        obscureText: obscureText,
        decoration: new InputDecoration(
          fillColor: R.colors.whiteMainColor,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: R.colors.whiteMainColor, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: R.colors.whiteMainColor, width: 1.0),
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
