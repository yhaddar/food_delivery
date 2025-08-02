import 'package:flutter/material.dart';
import 'package:food_delivery/core/constants/colors.dart' as colors;

class CustomInput extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final String label;
  final IconData icon;
  final bool isPassword;

  const CustomInput(
    this.controller,
    this.hint,
    this.label,
    this.icon,
    this.isPassword, {
    super.key,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {

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
        SizedBox(height: 15),
        TextField(
          obscureText: widget.isPassword,
          controller: widget.controller,
          decoration: InputDecoration(
            prefixIcon: Icon(widget.icon),
            prefixIconColor: colors.Colors.textDark,
            hintText: widget.hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(),
            filled: true,
            fillColor: colors.Colors.inputColor,
            suffixIcon: widget.isPassword
                ? FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                    ),
                    child: Icon(
                      Icons.remove_red_eye_sharp,
                      size: 24,
                      color: colors.Colors.textDark,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
