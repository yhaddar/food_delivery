import 'package:flutter/material.dart';
import 'package:food_delivery/core/constants/colors.dart' as colors;
import 'package:geolocator/geolocator.dart';

import '../../../shared/widgets/buttons/custom_button.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  void activateLocation() async {
    // LocationPermission locationPermission = await Geolocator.checkPermission();
    // print(LocationPermission.denied);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/icons/location.png"),
                ),
              ),
            ),
            Text(
              "For using this service your need to activate your location",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontFamily: "NataSans",
                fontWeight: FontWeight.bold,
                color: colors.Colors.dark,
              ),
            ),
            SizedBox(height: 30,),
            CustomButton("Access location", activateLocation),
          ],
        ),
      ),
    );
  }
}
