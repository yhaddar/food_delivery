import 'package:flutter/material.dart';
import 'package:food_delivery/core/constants/colors.dart' as colors;

class CustomAuthHero extends StatelessWidget {
  final String title;
  final String description;

  const CustomAuthHero(this.title, this.description, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: colors.Colors.textWhite,
              fontFamily: 'Sora',
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              color: colors.Colors.textWhite,
              fontFamily: 'NataSans',
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
