import 'package:flutter/material.dart';

import '../../../../core/theme/base_colors.dart';

class CustomInputField extends StatefulWidget {
  const CustomInputField({Key? key, required this.controller, required this.hintText}) : super(key: key);
  final String hintText;
  final TextEditingController controller;


  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      style: const TextStyle(
        fontSize: 16,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontSize: 16,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w500,
          color: BaseColors.lightGrey.withOpacity(0.36),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            style: BorderStyle.none,
            width: 0,
          ),
        ),
        filled: true,
        fillColor: BaseColors.white,
      ),
    );
  }
}
