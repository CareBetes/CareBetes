// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:care_betes/app/core/extensions/size_extension.dart';

class CommonDropDown<T> extends StatelessWidget {
  CommonDropDown({
    Key? key,
    this.width,
    required this.value,
    required this.onChanged,
    required this.listDropDown,
  }) : super(key: key);
  final double? width;
  T value;
  final List<DropdownMenuItem<T>> listDropDown;
  Function(T? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? context.percentWidth(.8),
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<T>(
        isExpanded: true,
        underline: Container(),
        value: value,
        items: listDropDown,
        onChanged: onChanged,
      ),
    );
  }
}
