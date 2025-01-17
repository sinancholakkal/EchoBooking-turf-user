import 'package:echo_booking/core/constent/image_constand.dart';
import 'package:echo_booking/core/constent/text_constend.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/widgets/custom_button.dart';
import 'package:echo_booking/feature/presentation/widgets/heading_text.dart';
import 'package:echo_booking/feature/presentation/pages/screen_login/screen_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenWelcome extends StatelessWidget {
  const ScreenWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backGroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 60,
          ),
          Padding(
            padding: EdgeInsets.only(left: 26),
            child: HeadingText(
              text: appTitle,
            ),
          ),
          Image(
            height: 340,
            width: 420,
            fit: BoxFit.cover,
            image: AssetImage(
                loginPlayer),
          ),
          SizedBox(height: 10,),
          Center(
              child: HeadingText(
            text: "Hello, Welcome !",
          )),
          Center(
              child: Text(
            "Welcome to EchoBooking.In Top\nplatform to coders",
            textAlign: TextAlign.center,
            style: TextStyle(color: kWhite),
          )),
          SizedBox(
            height: 40,
          ),
          //login button-------------------
          Center(
            child: CustomButton(
              onTap: (){
                Get.to(ScreenLogin(),transition: Transition.cupertino);
              },
              screenWidth: screenWidth,
              text: 'Login',
            ),
          ),
          SizedBox(
            height: 16,
          ),
          //signup button----------
          Center(
            child: CustomButton(
              screenWidth: screenWidth,
              text: 'Sign up',
            ),
          ),
          SizedBox(
            height: 40,
          ),
          //social madia login-------
          Center(
              child: Text(
            "Or  via social media",
            style: TextStyle(color: kWhite),
          )),
          SizedBox(
            height: 30,
          ),
          Center(
            child: IconButton(
              onPressed: () {},
              icon: Image.asset(loginGoogleIcon,width: 30,height: 30,),
            ),
          ),
        ],
      ),
    );
  }
}
