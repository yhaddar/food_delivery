import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/core/constants/colors.dart' as colors;

import '../../../shared/widgets/custom_recipe_cart2.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  Stream<List<Map<String, dynamic>>> getMyFavorite() {
     return FirebaseFirestore.instance
        .collection("favorite")
        .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .asyncMap((favorites) async {
          List<Map<String, dynamic>> allRecipe = [];

          for (var favorite in favorites.docs) {
            final r = favorite.data();

            final recipes = await FirebaseFirestore.instance
                .collection("recipes")
                .where("id", isEqualTo: r["recipe_id"])
                .get();

            for (var recipe in recipes.docs) {
              final category = await FirebaseFirestore.instance
                  .collection("categories")
                  .where("id", isEqualTo: recipe.data()["category_id"])
                  .get();

              allRecipe.add({
                "recipe": recipes.docs.first.data(),
                "category": category.docs.first.data(),
              });
            }
          }
          return allRecipe;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My Favorite",
                style: TextStyle(
                  color: colors.Colors.textDark,
                  fontFamily: "Sora",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 30),
              StreamBuilder(
                stream: getMyFavorite(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return snapshot.data!.isNotEmpty
                      ? Column(
                          children: List.generate(snapshot.data!.length, (
                            index,
                          ) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 6),
                              child: CustomRecipeCart2(
                                snapshot.data![index]["recipe"]["image"],
                                snapshot.data![index]["recipe"]["title"],
                                snapshot.data![index]["category"]["title"],
                                snapshot.data![index]["recipe"]["prep_time"],
                                snapshot.data![index]["recipe"]["id"],
                                snapshot.data![index]["category"]["image"],
                                snapshot.data![index]["recipe"]["description"],
                              ),
                            );
                          }),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: 2,
                              color: colors.Colors.gray,
                              style: BorderStyle.solid,
                            ),
                          ),
                          padding: EdgeInsets.all(8),
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Text(
                              "no recipe in your favorite",
                              style: TextStyle(
                                color: colors.Colors.textDark,
                                fontFamily: "Sora",
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
                              ),
                            ),
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
