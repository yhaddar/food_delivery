import 'package:flutter/material.dart';
import 'package:food_delivery/core/constants/colors.dart' as colors;
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../features/favorite/favorite_controller.dart';

class CustomRecipeCart2 extends StatefulWidget {
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
  State<CustomRecipeCart2> createState() => _CustomRecipeCart2State();
}

class _CustomRecipeCart2State extends State<CustomRecipeCart2> {

  @override
  Widget build(BuildContext context) {
    final VerifierIfExist verifierIfExist = Get.put(VerifierIfExist(widget.id));
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
                      image: AssetImage("assets/images/recipes/${widget.image}"),
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
                      child: InkWell(
                        onTap: () async {
                          if (verifierIfExist.exist.value)
                          {FavoriteController.addFavoriteToCategory(widget.id);}
                          else
                          {FavoriteController.removeRecipeFromFavorite(widget.id);}

                          await verifierIfExist.checkExist();
                        },
                        child: !verifierIfExist.exist.value
                            ? Icon(Iconsax.heart5, color: colors.Colors.red)
                            : Icon(Iconsax.heart),
                      )
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
                          widget.title.length > 20
                              ? "${widget.title.substring(0, 20)}..."
                              : widget.title,
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
                          widget.description.length > 95
                              ? "${widget.description.substring(0, 95)}..."
                              : widget.description,
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
                        "assets/icons/categories/${widget.category_image}",
                        width: 32,
                        height: 32,
                      ),
                      SizedBox(width: 8),
                      Text(
                        widget.category,
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
