import 'package:flutter/material.dart';
import 'package:food_delivery/core/constants/colors.dart' as colors;
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../features/favorite/favorite_controller.dart';

class CustomRecipeCart2 extends StatelessWidget {
  final String image;
  final String title;
  final String category;
  final int prep_time;
  final int id;
  final String category_image;
  final String description;

  const CustomRecipeCart2(
    this.image,
    this.title,
    this.category,
    this.prep_time,
    this.id,
    this.category_image,
    this.description, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final VerifierIfExist verifierIfExist = Get.put(VerifierIfExist(id));
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 180,
        decoration: BoxDecoration(
          color: colors.Colors.whiteColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 2, color: colors.Colors.gray),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage("assets/images/recipes/$image"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 180,
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    color: colors.Colors.blackOpacity,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: colors.Colors.whiteColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: !verifierIfExist.exist.value
                          ? Icon(Iconsax.heart5, color: colors.Colors.red)
                          : Icon(Iconsax.heart),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          title.length > 20
                              ? "${title.substring(0, 20)}..."
                              : title,
                          style: TextStyle(
                            color: colors.Colors.textDark,
                            fontSize: 16,
                            fontFamily: 'NataSans',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          description.length > 95
                              ? "${description.substring(0, 95)}..."
                              : description,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: colors.Colors.textDark,
                            fontSize: 12,
                            fontFamily: 'NataSans',
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/categories/$category_image",
                        width: 32,
                        height: 32,
                      ),
                      SizedBox(width: 8),
                      Text(
                        category,
                        style: TextStyle(
                          color: colors.Colors.textDark,
                          fontSize: 15,
                          fontFamily: 'NataSans',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VerifierIfExist extends GetxController {
  RxBool exist = false.obs;
  final int id;

  VerifierIfExist(this.id);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkExist();
  }

  Future<void> checkExist() async {
    exist.value = await FavoriteController.isExist(id);
  }
}
