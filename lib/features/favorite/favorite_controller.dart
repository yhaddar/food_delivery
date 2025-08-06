import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FavoriteController {

  static Future<void> addFavoriteToCategory(int id) async {
      final userId = FirebaseAuth.instance.currentUser?.uid;

      final recipeExist = await FirebaseFirestore.instance.collection("favorite").where("recipe_id", isEqualTo: id).where("user_id", isEqualTo: userId).get();

      if(recipeExist.docs.isEmpty){
        await FirebaseFirestore.instance.collection("favorite").doc("${userId}_$id").set({
          "user_id": userId,
          "recipe_id": id
        });

      }else {
        print("you already saved");
      }

  }

  static Future<void> removeRecipeFromFavorite(int id) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    FirebaseFirestore.instance.collection("favorite").doc("${userId}_$id").delete();

  }
  static Stream<RxInt> numberOfFavorite() {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return FirebaseFirestore.instance
    .collection("favorite")
    .where("user_id", isEqualTo: userId)
    .snapshots()
    .map((s) => s.size.obs);
  }

  static Future<bool> isExist(int id) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    final recipe = await FirebaseFirestore.instance.collection("favorite").where("recipe_id", isEqualTo: id).where("user_id", isEqualTo: userId).get();

    return recipe.docs.isEmpty;
  }

}