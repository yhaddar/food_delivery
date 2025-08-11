import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/core/constants/colors.dart' as colors;
import 'package:food_delivery/shared/widgets/buttons/custom_button.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import '../../../shared/widgets/custom_input.dart';
import '../../../shared/widgets/custom_textarea.dart';

class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({super.key});

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController prepTimeController = TextEditingController();

  int? _category_selected = 0;

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategories() {
    final recipes = FirebaseFirestore.instance
        .collection("categories")
        .snapshots();
    return recipes;
  }

  ImagePicker _imagePicker = ImagePicker();
  File? _image;

  Future<void> _pick() async {
    final _pickedImage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (_pickedImage != null) {
      setState(() {
        _image = File(_pickedImage.path);
      });
    }

  }

  Future<void> addRecipe() async {

    try {
      // final imageRef = await FirebaseStorage.instance.ref("images").child("${titleController.text}.jpg");
      // final uploadImage = await imageRef.putFile(_image!);
      // final imageUrl = await uploadImage.ref.getDownloadURL();

      final added = FirebaseFirestore.instance.collection("recipes").add({
        "title": titleController.text,
        "description": descriptionController.text,
        "prep_time": prepTimeController.text,
        "category_id": _category_selected,
        "image": "no image",
        "created_at": DateTime.now(),
        "updated_at": DateTime.now(),
        "user_id": FirebaseAuth.instance.currentUser!.uid
      });

      if(added != null){
        print("success");
      }
    } on FirebaseException catch(e){
      print(e.message);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Add new Recipe",
            style: TextStyle(
              color: colors.Colors.textDark,
              fontFamily: "Sora",
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 30),
          Center(
            child: InkWell(
              onTap: _pick,
              child: DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  color: colors.Colors.dark,
                  strokeWidth: 2,
                  dashPattern: [7],
                  radius: Radius.circular(20),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 150,
                  child: _image != null
                      ? Image.file(_image!, fit: BoxFit.cover)
                      : Center(child: Icon(Iconsax.gallery_import, size: 45,),),
                ),
              ),
            ),
          ),
          SizedBox(height: 30),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomInput(
                titleController,
                "Enter title of recipe :",
                "Title :",
                Iconsax.text,
                false,
                TextInputType.text,
              ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Category :",
                      style: TextStyle(
                        color: colors.Colors.textDark,
                        fontSize: 16,
                        fontFamily: "NataSans",
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 15),
                    StreamBuilder(
                      stream: getAllCategories(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: Text("no category"));
                        }
                        return DropdownButtonFormField<int>(
                          decoration: InputDecoration(
                            prefixIconColor: colors.Colors.textDark,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(),
                            filled: true,
                            fillColor: colors.Colors.inputColor,
                          ),
                          items: [
                            DropdownMenuItem(
                              value: 0,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/icons/category.png",
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Select Category",
                                    style: TextStyle(
                                      fontFamily: 'NataSans',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ...List.generate(
                              snapshot.data!.docs.length,
                              (index) => DropdownMenuItem(
                                value: snapshot.data!.docs[index].data()["id"],
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/icons/categories/${snapshot.data!.docs[index].data()["image"]}",
                                      width: 20,
                                      height: 20,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      snapshot.data!.docs[index]
                                          .data()["title"],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                          isExpanded: true,
                          value: _category_selected,
                          onChanged: (int? v) {
                            setState(() {
                              if (v != 0) {
                                _category_selected = v;
                              }
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              CustomInput(
                prepTimeController,
                "Enter preparation time :",
                "Preparation time :",
                Iconsax.timer_1,
                false,
                TextInputType.number,
              ),
              SizedBox(height: 30),
              CustomTextarea(
                descriptionController,
                "Enter description of recipe :",
                "Description : ",
              ),
            ],
          ),
          SizedBox(height: 30),
          CustomButton("add", addRecipe),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
