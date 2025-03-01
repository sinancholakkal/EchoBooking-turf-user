import 'package:echo_booking/core/constent/image/image_constand.dart';
import 'package:echo_booking/core/constent/text/text_constend.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/screen_login/screen_login.dart';
import 'package:echo_booking/feature/presentation/pages/sign_up/screen_sign_up.dart';
import 'package:echo_booking/feature/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:get/get.dart';

class LoginPartWidget extends StatelessWidget {
  const LoginPartWidget({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Center(
            child: CustomButton(
              onTap: () {
                Get.off(
                  () => ScreenLogin(),
                  transition: Transition.cupertino,
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
    );
  }
}
