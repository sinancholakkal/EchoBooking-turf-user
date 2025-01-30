import 'dart:developer';

import 'package:echo_booking/core/constent/text/text_constend.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/core/until/validation.dart';
import 'package:echo_booking/feature/domain/auth_service.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/home_screen.dart';
import 'package:echo_booking/feature/presentation/pages/screen_details/screen_user_details.dart';
import 'package:echo_booking/feature/presentation/pages/screen_login/screen_login.dart';
import 'package:echo_booking/feature/presentation/widgets/custom_button.dart';
import 'package:echo_booking/feature/presentation/widgets/heading_text.dart';
import 'package:echo_booking/feature/presentation/widgets/rich_text_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/text_form_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenSignUp extends StatefulWidget {
  const ScreenSignUp({super.key});

  @override
  State<ScreenSignUp> createState() => _ScreenSignUpState();
}

class _ScreenSignUpState extends State<ScreenSignUp> {
  late TextEditingController _email;
  late TextEditingController _password;
  late TextEditingController _conformPassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _auth = AuthService();

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _conformPassword = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backGroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * .09),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: HeadingText(
                    text: appTitle,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.06,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: HeadingText(
                    text: "Create Account Now!",
                  ),
                ),

                //E-mail----------------
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Text(
                  textUserName,
                  style: TextStyle(
                      color: kWhite, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                TextFormFieldWidget(
                  validator: (value) {
                    return Validation.emailValidation(value);
                  },
                  controller: _email,
                ),

                //password-------------
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Text(
                  textPassword,
                  style: TextStyle(
                      color: kWhite, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                TextFormFieldWidget(
                  validator: (value) {
                    return Validation.passWordValidation(value);
                  },
                  controller: _password,
                ),

                //Conform password---------------
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Text(
                  conformPassword,
                  style: TextStyle(
                      color: kWhite, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                TextFormFieldWidget(
                  validator: (value) {
                    return Validation.conformPasswordValidation(value: value, password: _password.text, conformPassword: _conformPassword.text);
                  },
                  controller: _conformPassword,
                ),

                SizedBox(
                  height: screenHeight * 0.05,
                ),
                //Signup button------------
                Center(
                  child: CustomButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        print(" Validated--------------------");
                        _signUp();
                      } else {
                        print("Not Validated--------------------");
                      }
                    },
                    screenWidth: screenWidth,
                    text: textSignUpButton,
                  ),
                ),
                SizedBox(
                  height: 08,
                ),
                //Have already account----------------
                Center(
                  child: RichTextWidget(
                    text: "Have an account already?",
                    eventText: "Login",
                    onTap: () {
                      Get.off(ScreenLogin(), transition: Transition.cupertino);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signUp() async {
    print("signup called ==============================");
    final user =
        await _auth.createUserWithEmailAndPassword(_email.text, _password.text,context);
    if (user != null) {
      log("User created successfully");
      
      Get.off(() => ScreenUserDetails(user: user,), transition: Transition.cupertino);
    }
  }
}
