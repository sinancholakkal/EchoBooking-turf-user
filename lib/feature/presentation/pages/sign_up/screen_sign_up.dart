import 'package:echo_booking/core/constent/text_constend.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/pages/screen_login/screen_login.dart';
import 'package:echo_booking/feature/presentation/widgets/custom_button.dart';
import 'package:echo_booking/feature/presentation/widgets/heading_text.dart';
import 'package:echo_booking/feature/presentation/widgets/rich_text_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/text_form_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenSignUp extends StatelessWidget {
  const ScreenSignUp({super.key});

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
              

              //username----------------
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
              TextFormFieldWidget(),

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
              TextFormFieldWidget(),

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
              TextFormFieldWidget(),


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
              TextFormFieldWidget(),

              SizedBox(
                height: screenHeight * 0.05,
              ),
              //Login button------------
              Center(
                child: CustomButton(
                  screenWidth: screenWidth,
                  text: textLoginButton,
                ),
              ),
              SizedBox(
                height: 08,
              ),
              Center(
                child: RichTextWidget(
                  text: "Have an account already?",
                  eventText: "Login",
                  onTap: (){
                    Get.off(ScreenLogin(),transition: Transition.cupertino);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

