// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:care_betes/app/common/common_text_form_field.dart';
import 'package:intl/intl.dart';

class CommonDateField extends StatefulWidget {
  const CommonDateField({
    Key? key,
    this.dateController,
    this.onChanged,
    required this.hintText,
    required this.isOnlyTimer,
  }) : super(key: key);
  final String hintText;
  final TextEditingController? dateController;
  final bool isOnlyTimer;
  final Function(String?)? onChanged;

  @override
  State<CommonDateField> createState() => _CommonDateFieldState();
}

class _CommonDateFieldState extends State<CommonDateField> {
  @override
  Widget build(BuildContext context) {
    return CommonTextFormField(
      controller: widget.dateController,
      hintText: widget.hintText,
      readOnly: true,
      onTap: () {
        datePicker(
          context: context,
          dateController: widget.dateController!,
          isOnlyTimer: widget.isOnlyTimer,
          onChanged: widget.onChanged,
        );
      },
      onChanged: widget.onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor preencher';
        }
        return null;
      },
    );
  }
}

datePicker({
  required BuildContext context,
  required TextEditingController dateController,
  required bool isOnlyTimer,
  Function(String?)? onChanged,
}) async {
  String dateFormat = isOnlyTimer ? 'HH:mm' : 'yyyy-MM-dd HH:mm';
  String returnFormat = isOnlyTimer ? 'HH:mm' : 'yyyy-MM-dd HH:mm';
  DatePicker.showDatePicker(
    context,
    dateFormat: dateFormat,
    initialDateTime: DateTime.now(),
    minDateTime: isOnlyTimer ? DateTime(2023) : DateTime.now(),
    maxDateTime: DateTime(3000),
    onMonthChangeStartWithFirstDate: true,
    onConfirm: (dateTime, List<int> index) {
      DateTime selectdate = dateTime;
      final selIOS = DateFormat(returnFormat).format(selectdate);
      onChanged!(selIOS);
    },
  );
}
