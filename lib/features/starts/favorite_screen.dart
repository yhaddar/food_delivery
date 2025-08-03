import 'package:flutter/material.dart';
import 'package:food_delivery/shared/widgets/buttons/custom_button.dart';
import 'package:food_delivery/shared/widgets/custom_text.dart';

import '../../shared/widgets/buttons/custom_skip_button.dart';
import '../../shared/widgets/custom_index_page.dart';
import 'order_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 100, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/icons/restaurant.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                SizedBox(height: 30),
                CustomText.primaryTitle("All your favorites"),
                SizedBox(height: 8),
                CustomText.description(
                  "Get all your loved foods in one once place, you just place the order we the rest",
                ),
              ],
            ),
            Column(
              children: [
                CustomIndexPage(0),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: CustomButton("Next", () => Navigator.push(context, MaterialPageRoute(builder: (context) => OrderScreen())) ),
                ),
                SizedBox(height: 60),
              ],
            )
          ],
        ),
      ),
    );
  }
}
