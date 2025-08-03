import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/core/constants/colors.dart' as colors;
import 'package:food_delivery/features/starts/favorite_screen.dart';

class CustomAppbar extends StatelessWidget {
  final String title;

  const CustomAppbar(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colors.Colors.gray, width: 2)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title.toString(),
            style: TextStyle(
              color: colors.Colors.textDark,
              fontFamily: 'Sora',
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          Icon(Icons.person_outline, size: 25, color: colors.Colors.textDark),
          ElevatedButton(onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteScreen()));
          },
              child: Icon(Icons.logout)),
        ],
      ),
    );
  }
}
