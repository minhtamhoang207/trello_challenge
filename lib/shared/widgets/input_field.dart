import 'package:flutter/material.dart';
import 'package:trello_challenge/shared/constants/colors.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String placeholder;
  final Color color;
  final double fontSize;
  final bool password;
  final Widget? prefix;
  final Widget? suffix;
  final String? Function(String?)? validator;
  final Function()? onTapSuffix;
  final int? maxLine;
  final int? maxLength;
  final EdgeInsets? contentPadding;

  const InputField({
    Key? key,
    required this.controller,
    this.keyboardType,
    this.placeholder = '',
    this.color = Colors.white,
    this.fontSize = 22.0,
    this.password = false,
    this.validator,
    this.prefix,
    this.suffix,
    this.onTapSuffix,
    this.maxLine = 1,
    this.contentPadding = EdgeInsets.zero,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      scrollPadding: const EdgeInsets.only(bottom: 50, right: 20),
      textAlignVertical: TextAlignVertical.center,
      maxLines: maxLine,
      decoration: InputDecoration(
        counterText: '',
        fillColor: Colors.transparent,
        prefixIcon: prefix,
        suffixIcon: suffix,
        border: InputBorder.none,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: contentPadding,
        hintText: placeholder,
        hintStyle: TextStyle(
          fontSize: fontSize,
          color: AppColor.darkGray,
          fontWeight: FontWeight.normal,
        ),
        filled: true,
        isDense: true,
      ),
      controller: controller,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      ),
      keyboardType: keyboardType,
      obscureText: password,
    );
  }
}
