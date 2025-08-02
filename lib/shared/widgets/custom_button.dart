import 'package:flutter/material.dart';
import 'package:food_delivery/core/constants/colors.dart' as colors;

class CustomButton extends StatefulWidget {
  final String title;
  final void onPressed;

  const CustomButton(this.title, this.onPressed, {super.key});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: ElevatedButton(
        onPressed: () => widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.Colors.buttonColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        ),
        child: Text(
          widget.title,
          style: TextStyle(
            color: colors.Colors.textWhite,
            fontSize: 17,
            fontFamily: 'Sora',
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
