// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CommonCheckbox extends StatelessWidget {
  const CommonCheckbox({
    Key? key,
    this.width,
    required this.onChanged,
    required this.value,
    required this.dayOfWeek,
    required this.title,
  }) : super(key: key);

  final double? width;
  final Function(Map<String, dynamic>) onChanged;
  final bool value;
  final int dayOfWeek;
  final String title;

  @override
  Widget build(BuildContext context) {
    double width = 40;
    double height = 40;

    return InkWell(
      onTap: () {
        onChanged({
          'value': !value,
          'dayOfWeek': dayOfWeek,
        });
        if (value) {
          width = 50;
          height = 50;
        }
        if (!value) {
          width = 40;
          height = 40;
        }
      },
      child: AnimatedContainer(
        width: width,
        height: height,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
        decoration: BoxDecoration(
          color: value ? Colors.amber : Colors.white,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
