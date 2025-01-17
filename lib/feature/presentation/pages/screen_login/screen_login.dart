import 'package:echo_booking/core/constent/text_constend.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/widgets/custom_button.dart';
import 'package:echo_booking/feature/presentation/widgets/heading_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ScreenLogin extends StatelessWidget {
  const ScreenLogin({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backGroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * .09),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: HeadingText(
                  text: appTitle,
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: HeadingText(
                  text: "Welcome Back!",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Login to continue",
                  style: TextStyle(color: kWhite,fontSize: 16),
                ),
              ),
              //username----------------
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Text(
                textUserName,
                style: TextStyle(
                    color: kWhite, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              TextFormFieldWidget(),

              //password-------------
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Text(
                textPassword,
                style: TextStyle(
                    color: kWhite, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              TextFormFieldWidget(),

              SizedBox(
                height: screenHeight * 0.10,
              ),
              Center(
                child: CustomButton(
                  screenWidth: screenWidth,
                  text: 'Sign up',
                ),
              ),
              SizedBox(height: 08,),
              Center(
                child: RichText(
                    text: TextSpan(text: "Don’t have an account?", children: [
                  TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                      text: "Sign Up",
                      recognizer: TapGestureRecognizer()..onTap = () {})
                ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: kWhite,
          //border: UnderlineInputBorder(),

          //label: Text(textUserName),
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(26)),
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(26))),
    );
  }
}
