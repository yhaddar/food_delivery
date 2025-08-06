import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/core/constants/colors.dart' as colors;
import 'package:iconsax/iconsax.dart';

class HeroScreen extends StatefulWidget {
  const HeroScreen({super.key});

  @override
  State<HeroScreen> createState() => _HeroScreenState();
}

class _HeroScreenState extends State<HeroScreen> {
  List<Map<String, dynamic>> results = [];

  Future<List<Map<String, dynamic>>> fetchRecipesWithUserAndCategory() async {
    final recipes = await FirebaseFirestore.instance
        .collection("recipes")
        .orderBy("created_at", descending: true)
        .limit(3)
        .get();

    for (var recipe in recipes.docs) {
      final recipeData = recipe.data();
      final user = recipeData["user_id"];

      var recipeWithUser = await FirebaseFirestore.instance
          .collection("users")
          .where("user_id", isEqualTo: user)
          .limit(1)
          .get();

      final category = await FirebaseFirestore.instance
          .collection("categories")
          .where("id", isEqualTo: recipeData["category_id"])
          .get();

      if (recipeWithUser!.docs!.isNotEmpty) {
        final userFinal = recipeWithUser.docs.first.data();
        results.add({
          "recipes": recipeData,
          "user": userFinal,
          "category": category,
        });
      } else {
        print("not user found for this user : $user");
      }
    }

    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: FutureBuilder(
        future: fetchRecipesWithUserAndCategory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: results.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 200,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/images/recipes/${snapshot.data![index]["recipes"]["image"]}",
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: colors.Colors.blackOpacity,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "${snapshot.data![index]["recipes"]["title"]}",
                              style: TextStyle(
                                color: colors.Colors.textWhite,
                                fontSize: 24,
                                fontFamily: 'Sora',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        image: DecorationImage(
                                          image: AssetImage(
                                            "assets/images/users/${snapshot.data![index]["user"]["profile"]}",
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Text(
                                      "${snapshot.data![index]["user"]["name"]}",
                                      style: TextStyle(
                                        color: colors.Colors.textWhite,
                                        fontSize: 14,
                                        fontFamily: 'NataSans',
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Iconsax.clock, color: colors.Colors.textWhite,),
                                    SizedBox(width: 6,),
                                    Text(
                                      "${snapshot.data![index]["recipes"]["prep_time"]} min",
                                      style: TextStyle(
                                        color: colors.Colors.textWhite,
                                        fontSize: 14,
                                        fontFamily: 'NataSans',
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
