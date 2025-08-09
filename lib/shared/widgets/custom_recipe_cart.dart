import 'package:flutter/material.dart';
import 'package:food_delivery/core/constants/colors.dart' as colors;
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../features/favorite/favorite_controller.dart';
import '../../features/food/ui/food_detail_screen.dart';

class CustomRecipeCart extends StatelessWidget {
  final String image;
  final String title;
  final String category;
  final int prep_time;
  final int id;
  final String category_image;

  const CustomRecipeCart(
    this.image,
    this.title,
    this.category,
    this.prep_time,
    this.id,
    this.category_image, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final VerifierIfExist2 verifierIfExist2 = Get.put(VerifierIfExist2(id));
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => FoodDetailScreen(id)));
      },
      child: Obx(
            () => Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 250,
            height: 300,
            padding: EdgeInsets.all(3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: AssetImage("assets/images/recipes/$image"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: colors.Colors.blackOpacity,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),

                    InkWell(
                      onTap: () async => {
                        if (verifierIfExist2.exist.value)
                          {FavoriteController.addFavoriteToCategory(id)}
                        else
                          {FavoriteController.removeRecipeFromFavorite(id)},

                        await verifierIfExist2.checkExist()
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: colors.Colors.whiteColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: !verifierIfExist2.exist.value
                                ? Icon(Iconsax.heart5, color: colors.Colors.red)
                                : Icon(Iconsax.heart),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          title.length > 20
                              ? "${title.substring(0, 20)}..."
                              : title,
                          style: TextStyle(
                            color: colors.Colors.textDark,
                            fontSize: 18,
                            fontFamily: 'NataSans',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                                  fontSize: 16,
                                  fontFamily: 'NataSans',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Iconsax.clock, color: colors.Colors.textDark),
                              SizedBox(width: 8),
                              Text(
                                "${prep_time.toString()} min",
                                style: TextStyle(
                                  color: colors.Colors.textDark,
                                  fontSize: 16,
                                  fontFamily: 'NataSans',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VerifierIfExist2 extends GetxController {
  RxBool exist = false.obs;
  final int id;

  VerifierIfExist2(this.id);

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
