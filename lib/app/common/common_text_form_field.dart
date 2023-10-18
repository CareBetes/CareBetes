// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:care_betes/app/core/extensions/size_extension.dart';

class CommonTextFormField extends StatelessWidget {
  const CommonTextFormField({
    Key? key,
    required this.hintText,
    this.textSize,
    this.width,
    this.validator,
    this.onChanged,
    this.obscureText,
    this.inputFormatters,
    this.textInputType,
    this.maxLength,
    this.icon,
    this.iconColor,
    this.controller,
    this.readOnly,
    this.enabled,
    this.onTap,
    this.onSaved,
    this.onFieldSubmitted,
    this.textInputAction,
    this.onTapOutside,
  }) : super(key: key);

  final String hintText;
  final double? textSize;
  final double? width;
  final Function(String? value)? validator;
  final Function(String? value)? onChanged;
  final bool? obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;
  final int? maxLength;
  final Icon? icon;
  final Color? iconColor;
  final TextEditingController? controller;
  final bool? readOnly;
  final bool? enabled;
  final Function()? onTap;
  final Function(String?)? onSaved;
  final Function(String?)? onFieldSubmitted;
  final Function(PointerDownEvent?)? onTapOutside;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SizedBox(
        width: width ?? context.percentWidth(.8),
        child: TextFormField(
          controller: controller,
          maxLines: 1,
          maxLength: maxLength,
          textAlign: TextAlign.left,
          textAlignVertical: TextAlignVertical.bottom,
          validator: (value) => validator!(value),
          obscureText: obscureText ?? false,
          inputFormatters: inputFormatters,
          keyboardType: textInputType,
          onChanged: onChanged,
          readOnly: readOnly ?? false,
          enabled: enabled,
          onTap: onTap,
          onSaved: onSaved,
          onFieldSubmitted: onFieldSubmitted,
          textInputAction: textInputAction,
          onTapOutside: onTapOutside,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 15,
            ),
            errorStyle: const TextStyle(
              fontSize: 12,
            ),
            prefixIcon: icon,
            prefixIconColor: iconColor ?? Colors.grey,
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            ),
          ),
        ),
      );
    });
  }
}
