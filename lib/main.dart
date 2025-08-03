import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/features/starts/favorite_screen.dart';
import 'package:food_delivery/firebase_options.dart';
import 'package:food_delivery/core/constants/colors.dart' as colors;

import 'features/app_tree.dart';


void main() async {
  // for activate the firebase with flutter using firebase core
  WidgetsFlutterBinding.ensureInitialized();

  try {

    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    print("firebase was connected");

  }catch (e){
    print("failed to connect with firebase : $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
          splash: 'assets/gif/Food.gif',
          nextScreen: FirebaseAuth.instance.currentUser == null ? FavoriteScreen() : AppTree(),
        duration: 3000,
        backgroundColor: colors.Colors.whiteColor,
      ),
    );
  }
}
