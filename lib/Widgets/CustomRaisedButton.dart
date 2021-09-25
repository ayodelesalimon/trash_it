import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trash_it/Resources/Resources.dart';

// ignore: must_be_immutable
class CustomRaisedButton extends StatefulWidget {
  CustomRaisedButton(
      {this.text,
      this.onPressed,
      this.color,
      this.borderColor,
      this.textColor});
  void Function()? onPressed;
  final String? text;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;

  @override
  _CustomRaisedButtonState createState() => _CustomRaisedButtonState(
      onPressed: onPressed,
      text: text,
      color: color,
      borderColor: borderColor,
      textColor: textColor);
}

class _CustomRaisedButtonState extends State<CustomRaisedButton> {
  _CustomRaisedButtonState(
      {this.text,
      this.onPressed,
      this.color,
      this.borderColor,
      this.textColor});

  final String? text;
  void Function()? onPressed;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return RaisedButton(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
          side: BorderSide(color: (borderColor ?? Colors.transparent))),
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        }
      },
      color: (color ?? R.colors.loginButtonColor),
      textColor: Colors.white,
      child: Text(text ?? "",
          style: TextStyle(
              fontSize: 16,
              fontFamily: R.strings.fontName,
              fontWeight: FontWeight.w400,
              color: (textColor ?? Colors.white))),
    );
  }
}
