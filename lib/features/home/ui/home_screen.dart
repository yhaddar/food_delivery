import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/shared/widgets/custom_category.dart';

import '../../../shared/widgets/custom_recipe.dart';
import '../../../shared/widgets/custom_recipe_cart.dart';
import 'hero_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future<List<Map<String, dynamic>>> getLatestRecipes() async {
    final recipes = await FirebaseFirestore.instance.collection("recipes").orderBy("created_at", descending: true).limit(10).get();

    List<Map<String, dynamic>> allRecipe = [];

    for(var recipe in recipes.docs){

      final r = recipe.data();


      final category = await FirebaseFirestore.instance.collection("categories").where("id", isEqualTo: r["category_id"]).get();


      allRecipe.add({
        "recipe": r,
        "category": category.docs.first.data()
      });
    }
    return allRecipe;
  }

  Future<List<Map<String, dynamic>>> getRecipeWithCategory(int category) async {
    final recipes = await FirebaseFirestore.instance.collection("recipes").where("category_id", isEqualTo: category).limit(10).get();

    List<Map<String, dynamic>> allRecipe = [];

    for(var recipe in recipes.docs){

      final r = recipe.data();


      final category = await FirebaseFirestore.instance.collection("categories").where("id", isEqualTo: r["category_id"]).get();


      allRecipe.add({
        "recipe": r,
        "category": category.docs.first.data()
      });
    }
    return allRecipe;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeroScreen(),
        SizedBox(height: 30),
        CustomCategory(),
        SizedBox(height: 30),
        CustomRecipe("Latest Recipes", getLatestRecipes()),
        SizedBox(height: 30),
        CustomRecipe("Summer Recipes", getRecipeWithCategory(5)),
        SizedBox(height: 30),
        CustomRecipe("Dessert Recipes", getRecipeWithCategory(2)),
        SizedBox(height: 30),
      ],
    );
  }
}
