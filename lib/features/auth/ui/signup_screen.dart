import 'package:flutter/material.dart';
import 'package:food_delivery/core/constants/colors.dart' as colors;
import 'package:food_delivery/features/auth/authentication_controller.dart';
import 'package:food_delivery/features/auth/ui/login_screen.dart';
import 'package:food_delivery/shared/widgets/buttons/custom_button.dart';
import 'package:food_delivery/shared/widgets/custom_input.dart';
import '../../../shared/widgets/custom_auth_hero.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  List<Map<String, String>> errors = [];

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
              CustomAuthHero("Sign Up", "please sign up to get started"),
              Container(
                width: MediaQuery.of(context).size.width,
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
                      _nameController,
                      "Enter your name",
                      "Name :",
                      Icons.person_outline,
                      false,
                      TextInputType.text,
                    ),
                    SizedBox(height: 18),
                    CustomInput(
                      _emailController,
                      "Enter your email",
                      "Email :",
                      Icons.email_outlined,
                      false,
                      TextInputType.text,
                    ),
                    SizedBox(height: 18),
                    CustomInput(
                      _passwordController,
                      "Enter your password",
                      "Password :",
                      Icons.lock_outline,
                      true,
                      TextInputType.text,
                    ),
                    SizedBox(height: 18),
                    CustomInput(
                      _confirmPasswordController,
                      "Confirm your password",
                      "Confirm Password :",
                      Icons.lock_outline,
                      true,
                      TextInputType.text,
                    ),
                    SizedBox(height: 22),
                    CustomButton(
                      "Sign Up",
                      AuthenticationController(
                        _emailController.text,
                        _passwordController.text,
                        _nameController.text,
                        _confirmPasswordController.text,
                        context
                      ).signUp,
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have account ?",
                          style: TextStyle(
                            color: colors.Colors.textDark2,
                            fontSize: 14,
                            fontFamily: 'NataSans',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(width: 6),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "log in".toUpperCase(),
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
