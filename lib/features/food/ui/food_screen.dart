import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/shared/widgets/custom_recipe_cart2.dart';
import 'package:iconsax/iconsax.dart';
import '../../../shared/widgets/custom_input.dart';

class FoodScreen extends StatefulWidget {


  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  TextEditingController searchController = TextEditingController();

  Future<List<Map<String, dynamic>>> getAllRecipe() async {
    final recipes = await FirebaseFirestore.instance
        .collection("recipes")
        .orderBy("created_at", descending: true)
        .get();

    List<Map<String, dynamic>> allRecipe = [];

    for (var recipe in recipes.docs) {
      final r = recipe.data();

      final category = await FirebaseFirestore.instance
          .collection("categories")
          .where("id", isEqualTo: r["category_id"])
          .get();

      allRecipe.add({"recipe": r, "category": category.docs.first.data()});
    }
    return allRecipe;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomInput(
              searchController,
              "search",
              "Search for an Recipe",
              Iconsax.search_favorite,
              false
          ),
          SizedBox(height: 30,),
          FutureBuilder(
              future: getAllRecipe(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                }
                return Column(
                  children: List.generate(snapshot.data!.length, (index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      child: CustomRecipeCart2(
                          snapshot.data![index]["recipe"]["image"],
                          snapshot.data![index]["recipe"]["title"],
                          snapshot.data![index]["category"]["title"],
                          snapshot.data![index]["recipe"]["prep_time"],
                          snapshot.data![index]["recipe"]["id"],
                          snapshot.data![index]["category"]["image"],
                          snapshot.data![index]["recipe"]["description"]
                      ),
                    );
                  }),
                );
              },
          ),
        ],
      ),
    );
  }
}
