import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/firebase_options.dart';

import 'features/auth/ui/login_screen.dart';

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
      home: LoginScreen(),
    );
  }
}
