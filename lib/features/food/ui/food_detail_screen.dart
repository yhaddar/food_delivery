import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/core/constants/colors.dart' as colors;
import 'package:iconsax/iconsax.dart';

class FoodDetailScreen extends StatefulWidget {
  final int id;

  const FoodDetailScreen(this.id, {super.key});

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  Future<Map<String, dynamic>> getRecipeDetail() async {
    final recipe = await FirebaseFirestore.instance
        .collection("recipes")
        .where("id", isEqualTo: widget.id)
        .get();
    final category = await FirebaseFirestore.instance
        .collection("categories")
        .where("id", isEqualTo: recipe.docs.first.data()["category_id"])
        .get();
    final user = await FirebaseFirestore.instance
        .collection("users")
        .where("user_id", isEqualTo: recipe.docs.first.data()["user_id"])
        .get();

    Map<String, dynamic> recipeList = {};

    recipeList["recipe"] = recipe.docs.first.data();
    recipeList["category"] = category.docs.first.data();
    recipeList["user"] = user.docs.first.data();

    return recipeList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.Colors.whiteColor,
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getRecipeDetail(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.4,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/recipes/${snapshot.data!["recipe"]["image"]}",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 25,
                      left: 6,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: colors.Colors.whiteColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(Iconsax.arrow_left_2),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                    color: colors.Colors.whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${snapshot.data!["recipe"]["title"]}",
                        style: TextStyle(
                          color: colors.Colors.textDark,
                          fontFamily: 'NataSans',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                width: 50,
                                height: 50,
                                "assets/icons/categories/${snapshot.data!["category"]["image"]}",
                              ),
                              SizedBox(width: 12),
                              Text(
                                "${snapshot.data!["category"]!["title"]}",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  color: colors.Colors.textDark,
                                  fontFamily: 'NataSans',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/users/${snapshot.data!["user"]["profile"]}",
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                "${snapshot.data!["user"]!["name"]}",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  color: colors.Colors.textDark,
                                  fontFamily: 'NataSans',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        "${snapshot.data!["recipe"]!["description"]}",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: colors.Colors.textDark,
                          fontFamily: 'NataSans',
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Ingredients :",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: colors.Colors.textDark,
                          fontFamily: 'NataSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 8),
                      snapshot.data!["recipe"]["ingredient"] != null
                          ? Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  snapshot.data!["recipe"]["ingredient"].length,
                                  (index) {
                                    return Container(
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      child: Text(
                                        "- ${snapshot.data!["recipe"]["ingredient"][index]}",
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          color: colors.Colors.textDark,
                                          fontFamily: 'NataSans',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
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
                                  "no ingredient found ",
                                  style: TextStyle(
                                    color: colors.Colors.textDark,
                                    fontFamily: "Sora",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
