import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_booking/core/constent/image/image_constand.dart';
import 'package:echo_booking/core/constent/text/text_constend.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/home_screen.dart';
import 'package:echo_booking/feature/presentation/pages/screen_details_enter/screen_user_details.dart';
import 'package:echo_booking/feature/presentation/pages/sign_up/screen_sign_up.dart';
import 'package:echo_booking/feature/presentation/widgets/custom_button.dart';
import 'package:echo_booking/feature/presentation/widgets/heading_text.dart';
import 'package:echo_booking/feature/presentation/pages/screen_login/screen_login.dart';
import 'package:echo_booking/feature/presentation/widgets/loading_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/showDiolog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;

class ScreenWelcome extends StatelessWidget {
  const ScreenWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
    return bloc.BlocListener<AuthBlocBloc, AuthBlocState>(
        listener: (context, state) async{
          if (state is AuthLoadingState) {
            loadingWidget(context);
          } else if (state is AuthSuccessState) {
            DocumentSnapshot docs = await FirebaseFirestore.instance.collection('userApp').doc(state.user!.user!.uid).get();
            if(docs.exists){
              log("exxisted");
              Get.off(
              () => ScreenHome(),
              //transition: Transition.cupertino,
              duration: Duration(milliseconds: 1300),
            );
            }else{
              log("Not existed");
              Get.off(
              () => ScreenUserDetails(user: state.user.user,),
              //transition: Transition.cupertino,
              duration: Duration(milliseconds: 1300),
            );
            }
            
          } else if (state is AuthErrorState) {
            if (state.errorMessage == "invalid-credential") {
              showDiolog(
                context: context,
                title: "Incorrect Password",
                content:
                    "The password you entered is incorrect.\nPlease try again.",
              );
            }
          }
        },
        child: Scaffold(
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
                image: AssetImage(loginPlayer),
              ),
              SizedBox(
                height: 10,
              ),
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
                  onTap: () {
                    Get.off(
                      () => ScreenLogin(),
                      //transition: Transition.cupertino,
                    );
                  },
                  screenWidth: screenWidth,
                  text: textLoginButton,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              //signup button----------
              Center(
                child: CustomButton(
                  onTap: () {
                    Get.off(
                      () => ScreenSignUp(),
                      // transition: Transition.cupertino,
                    );
                  },
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
                child: InkWell(
                  onTap: () {
                    context.read<AuthBlocBloc>().add(SignInWithGoogle());
                  },
                  child: Image.asset(
                    loginGoogleIcon,
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
