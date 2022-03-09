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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      scrollPadding: const EdgeInsets.only(bottom: 50, right: 20),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        prefixIcon: prefix,
        suffixIcon: suffix,
        border: InputBorder.none,
        floatingLabelBehavior: FloatingLabelBehavior.always,
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
