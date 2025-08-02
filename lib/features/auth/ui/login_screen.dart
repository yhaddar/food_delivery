import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_delivery/features/auth/ui/signup_screen.dart';
import 'package:food_delivery/shared/widgets/custom_auth_hero.dart';
import 'package:food_delivery/core/constants/colors.dart' as colors;
import 'package:food_delivery/shared/widgets/custom_button.dart';
import 'package:food_delivery/shared/widgets/custom_input.dart';

import '../../../shared/widgets/custom_2oauth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void login() async {
    print(
      "your email : ${_emailController.text} and password ${_passwordController.text}",
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    login();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: colors.Colors.secondary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAuthHero(
                "Log In",
                "please sign in to your existing account",
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height * 0.7,
                padding: EdgeInsets.all(15),
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
                    CustomInput(
                      _emailController,
                      "Enter your email",
                      "Email :",
                      Icons.email_outlined,
                      false,
                    ),
                    SizedBox(height: 20),
                    CustomInput(
                      _passwordController,
                      "Enter your password",
                      "Password :",
                      Icons.lock_outline,
                      true,
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            print("page forgot password");
                          },
                          child: Text(
                            "Forgot Password ?",
                            style: TextStyle(
                              color: colors.Colors.danger,
                              fontSize: 13,
                              fontFamily: 'NataSans',
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    CustomButton("Log In", login()),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have account ?",
                          style: TextStyle(
                            color: colors.Colors.textDark2,
                            fontSize: 14,
                            fontFamily: 'NataSans',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(width: 6,),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
                          },
                          child: Text(
                            "sign up".toUpperCase(),
                            style: TextStyle(
                              color: colors.Colors.textOrange,
                              fontSize: 14,
                              fontFamily: 'NataSans',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    Center(
                      child: Text(
                        "Or",
                        style: TextStyle(
                          color: colors.Colors.textDark2,
                          fontSize: 14,
                          fontFamily: 'NataSans',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(height:  15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Custom2oauth(colors.Colors.blue, "facebook.png"),
                        SizedBox(width: 10,),
                        Custom2oauth(colors.Colors.dark, "twitter.png"),
                        SizedBox(width: 10,),
                        Platform.isIOS ? Custom2oauth(colors.Colors.dark, "apple.png") : Custom2oauth(colors.Colors.red, "google.png"),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
