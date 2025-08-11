import 'package:flutter/material.dart';
import 'package:food_delivery/core/constants/colors.dart' as colors;

class CustomTextarea extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final String label;
  // final String error = null;

  const CustomTextarea(
    this.controller,
    this.hint,
    this.label, {
    // this.error,
    super.key,
  });

  @override
  State<CustomTextarea> createState() => _CustomTextareaState();
}

class _CustomTextareaState extends State<CustomTextarea> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            color: colors.Colors.textDark,
            fontSize: 16,
            fontFamily: "NataSans",
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        // Text(widget.error.toString()),
        SizedBox(height: 15),
        TextField(
          minLines: 5,
          maxLines: null,
          controller: widget.controller,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            prefixIconColor: colors.Colors.textDark,
            hintText: widget.hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(),
            filled: true,
            fillColor: colors.Colors.inputColor,
          ),
        ),
      ],
    );
  }
}
