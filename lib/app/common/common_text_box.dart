// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:care_betes/app/core/extensions/size_extension.dart';

class CommonTextBox extends StatelessWidget {
  const CommonTextBox({
    Key? key,
    this.subTitle,
    this.width,
    this.paddingH,
    this.paddingV,
    this.fontSize,
    this.onTap,
    this.color,
    this.textAlign,
    required this.title,
  }) : super(key: key);

  final String title;
  final String? subTitle;
  final double? width;
  final double? paddingH;
  final double? paddingV;
  final double? fontSize;
  final Function()? onTap;
  final Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width == 0 ? null : context.percentWidth(width ?? .9),
        padding: EdgeInsets.symmetric(
            horizontal: paddingH ?? 20, vertical: paddingV ?? 10),
        decoration: BoxDecoration(
          color: color ?? const Color(0XFFE3EAF0),
          borderRadius: BorderRadius.circular(50),
        ),
        child: subTitle == null
            ? Center(
                child: Text(
                  title,
                  textAlign: textAlign,
                  style: TextStyle(
                    fontSize: fontSize ?? 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: fontSize ?? 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subTitle ?? '',
                    style: TextStyle(
                      fontSize: fontSize ?? 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
