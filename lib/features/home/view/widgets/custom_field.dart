import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  const CustomField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.isObscuredText = false,
      this.isNumberInputType = false});
  final String hintText;
  final TextEditingController controller;
  final bool isObscuredText;
  final bool isNumberInputType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType:
          isNumberInputType ? TextInputType.number : TextInputType.text,
      controller: controller,
      obscureText: isObscuredText,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
