import 'package:flutter/material.dart';
import 'package:food_delivery/shared/widgets/buttons/custom_button.dart';
import 'package:food_delivery/shared/widgets/custom_text.dart';

import '../../shared/widgets/buttons/custom_skip_button.dart';
import '../../shared/widgets/custom_index_page.dart';
import 'delivery_screen.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

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
                        "assets/icons/order.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                SizedBox(height: 30),
                CustomText.primaryTitle("Order from choosen chef"),
                SizedBox(height: 8),
                CustomText.description(
                  "Get all your loved foods in one once place, you just place the order we the rest",
                ),
              ],
            ),
            Column(
              children: [
                CustomIndexPage(1),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: CustomButton("Next", () => Navigator.push(context, MaterialPageRoute(builder: (context) => DeliveryScreen()))),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: CustomSkipButton("Skip", () => Navigator.pop(context)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
