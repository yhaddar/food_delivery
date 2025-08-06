import 'package:flutter/material.dart';
import 'package:food_delivery/core/constants/colors.dart' as colors;
import '../../features/favorite/favorite_controller.dart';
import 'custom_recipe_cart.dart';

class CustomRecipe extends StatelessWidget {
  final String title;
  final Future<List<Map<String, dynamic>>> callback;

  const CustomRecipe(this.title, this.callback, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: colors.Colors.textDark,
                  fontFamily: "Sora",
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          FutureBuilder(
            future: callback,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return snapshot.data!.isNotEmpty
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      child: ListView.builder(
                        itemCount: snapshot.data!.length < 10 ? snapshot.data!.length : 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: CustomRecipeCart(
                              snapshot.data![index]["recipe"]["image"],
                              snapshot.data![index]["recipe"]["title"],
                              snapshot.data![index]["category"]["title"],
                              snapshot.data![index]["recipe"]["prep_time"],
                              snapshot.data![index]["recipe"]["id"],
                              snapshot.data![index]["category"]["image"],
                            ),
                          );
                        },
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          width: 2,
                          color: colors.Colors.gray,
                          style: BorderStyle.solid
                        )
                      ),
                      padding: EdgeInsets.all(8),
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          "coming soon",
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
    );
  }
}
