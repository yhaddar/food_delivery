import 'package:flutter/material.dart';
import 'package:food_delivery/core/constants/colors.dart' as colors;

class Custom2oauth extends StatelessWidget {

  final Color color;
  final String icon;

  const Custom2oauth(this.color, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(50)
        ),
        child: Image.asset("assets/icons/$icon", width: 20, height: 20,),
      ),
    );
  }
}
