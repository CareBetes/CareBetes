// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CommonOutlinedButton extends StatelessWidget {
  const CommonOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.fontSize,
    this.padding,
    this.elevation,
  }) : super(key: key);

  final Function() onPressed;
  final String text;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        elevation: elevation ?? 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: padding,
        backgroundColor: Colors.white,
        alignment: Alignment.center,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: fontSize ?? 15,
        ),
      ),
    );
  }
}
