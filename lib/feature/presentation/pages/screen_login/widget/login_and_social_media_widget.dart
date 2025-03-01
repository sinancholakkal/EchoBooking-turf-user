
import 'dart:developer';

import 'package:echo_booking/core/constent/image/image_constand.dart';
import 'package:echo_booking/core/constent/size/size.dart';
import 'package:echo_booking/core/constent/text/text_constend.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/home_screen.dart';
import 'package:echo_booking/feature/presentation/pages/sign_up/screen_sign_up.dart';
import 'package:echo_booking/feature/presentation/widgets/custom_button.dart';
import 'package:echo_booking/feature/presentation/widgets/rich_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:get/get.dart';

class LoginAndSocialMediaWidget extends StatelessWidget {
  const LoginAndSocialMediaWidget({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController email,
    required TextEditingController password,
    required this.screenWidth,
  }) : _formKey = formKey, _email = email, _password = password;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _email;
  final TextEditingController _password;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Center(
            child: CustomButton(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  log(" Validated--------------------");
                  context.read<AuthBlocBloc>().add(SignInEvent(
                      email: _email.text,
                      password: _password.text,
                      context: context));
                  // _signIn(context);
                } else {
                  print("Not Validated--------------------");
                }
              },
              screenWidth: screenWidth,
              text: textLoginButton,
            ),
          ),
          SizedBox(
            height: 08,
          ),
          //Rich text --------------------------------
          Center(
            child: RichTextWidget(
              text: "Don’t have an account?",
              eventText: "Sign up",
              onTap: () {
                Get.off(ScreenSignUp(),
                    transition: Transition.cupertino);
              },
            ),
          ),
          height10,
          //social madia login-------
          Center(
              child: Text(
            "Or  via social media",
            style: TextStyle(color: kWhite),
          )),
          height10,
          Center(
            child: InkWell(
              onTap: () async {
                context
                    .read<AuthBlocBloc>()
                    .add(SignInWithGoogle());
                //await _auth.signInWithGoogle();
                Get.off(ScreenHome());
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
    );
  }
}
