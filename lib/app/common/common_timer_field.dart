// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:care_betes/app/common/common_text_form_field.dart';

class CommonTimerField extends StatefulWidget {
  const CommonTimerField({
    Key? key,
    this.controller,
    required this.hintText,
  }) : super(key: key);
  final String hintText;
  final TextEditingController? controller;

  @override
  State<CommonTimerField> createState() => _CommonTimerFieldState();
}

class _CommonTimerFieldState extends State<CommonTimerField> {
  @override
  Widget build(BuildContext context) {
    return CommonTextFormField(
      controller: widget.controller,
      hintText: widget.hintText,
      readOnly: true,
      onTap: () => datePicker(context, widget.controller!),
    );
  }
}

datePicker(BuildContext context, TextEditingController controller) async {
  DateTime? picker = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(const Duration(days: 900)),
  );
  if (picker != null) {
    controller.text = picker.toString();
  }
}
