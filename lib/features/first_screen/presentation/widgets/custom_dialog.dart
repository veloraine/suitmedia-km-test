import 'package:flutter/material.dart';
import 'package:km_test/core/theme/base_colors.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({Key? key, required this.content}) : super(key: key);
  final String content;

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text("Info", style: TextStyle(
        fontSize: 20,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w700,
      ),)),
      content: Text(widget.content, style: const TextStyle(
        fontSize: 16,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w500,
      ),),
      actions: [
        TextButton(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: BaseColors.darkGreen,
              ),
              child: const Text('Close', style: TextStyle(
                fontSize: 14,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                color: BaseColors.white,
              ),),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            })
      ],
    );
  }
}
