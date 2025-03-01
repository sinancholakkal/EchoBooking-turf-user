import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/home_screen.dart';
import 'package:echo_booking/feature/presentation/pages/screen_details_enter/screen_user_details.dart';
import 'package:echo_booking/feature/presentation/pages/screen_welcome/widget/heading_and_img_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_welcome/widget/login_part_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/loading_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/showDiolog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
class ScreenWelcome extends StatelessWidget {
  const ScreenWelcome({super.key});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return bloc.BlocListener<AuthBlocBloc, AuthBlocState>(
        listener: (context, state) async {
          if (state is AuthLoadingState) {
            loadingWidget(context);
          } else if (state is AuthSuccessState) {
            DocumentSnapshot docs = await FirebaseFirestore.instance
                .collection('userApp')
                .doc(state.user!.user!.uid)
                .get();
            if (docs.exists) {
              log("exxisted");
              Get.off(
                () => ScreenHome(),
                //transition: Transition.cupertino,
                duration: Duration(milliseconds: 1300),
              );
            } else {
              log("Not existed");
              Get.off(
                () => ScreenUserDetails(
                  user: state.user.user,
                ),
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
              //Headings and image-----------
              HeadingsAndImgWidget(),
              //login button-------------------
              LoginPartWidget(screenWidth: screenWidth)
            ],
          ),
        ));
  }
}