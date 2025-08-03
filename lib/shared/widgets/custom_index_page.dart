import 'package:flutter/material.dart';
import 'package:food_delivery/core/constants/colors.dart' as colors;

class CustomIndexPage extends StatefulWidget {

  final int i;
  const CustomIndexPage(this.i, {super.key});

  @override
  State<CustomIndexPage> createState() => _CustomIndexPageState();
}

class _CustomIndexPageState extends State<CustomIndexPage> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => Container(
          width: 15,
          height: 15,
          margin: EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color: index == widget.i.toInt() ? colors.Colors.buttonColor : colors.Colors.gray,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}
