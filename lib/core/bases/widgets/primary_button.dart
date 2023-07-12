import 'package:flutter/material.dart';
import 'package:km_test/core/theme/base_colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({Key? key, required this.text, required this.onPressed}) : super(key: key);
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
      return ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: BaseColors.darkGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            color: BaseColors.white,
          ),
        ),
      );
  }
}
