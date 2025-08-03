import 'package:flutter/material.dart';
import 'package:food_delivery/core/constants/colors.dart' as colors;

class CustomText {
  static Text primaryTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: colors.Colors.textDark,
        fontSize: 25,
        fontFamily: 'Nunito',
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static Container description(String description) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        description,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: colors.Colors.textDark,
          fontSize: 16,
          fontFamily: 'NataSans',
        ),
      ),
    );
  }
}
