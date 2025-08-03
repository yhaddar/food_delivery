import 'package:flutter/material.dart';
import 'package:food_delivery/core/constants/colors.dart' as colors;

class CustomSkipButton extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;

  const CustomSkipButton(this.title, this.onPressed, {super.key});

  @override
  State<CustomSkipButton> createState() => _CustomSkipButtonState();
}

class _CustomSkipButtonState extends State<CustomSkipButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        ),
        child: Text(
          widget.title,
          style: TextStyle(
            color: colors.Colors.textDark,
            fontSize: 17,
            fontFamily: 'Sora',
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
