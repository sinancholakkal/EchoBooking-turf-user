import 'package:echo_booking/core/constent/text/text_constend.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/core/until/validation.dart';
import 'package:echo_booking/feature/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/screen_login/screen_login.dart';
import 'package:echo_booking/feature/presentation/widgets/custom_button.dart';
import 'package:echo_booking/feature/presentation/widgets/rich_text_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/text_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'as bloc;
import 'package:get/get.dart';

class TextFieldsAndSignUp extends StatelessWidget {
  const TextFieldsAndSignUp({
    super.key,
    required this.screenHeight,
    required TextEditingController email,
    required TextEditingController password,
    required TextEditingController conformPassword,
    required GlobalKey<FormState> formKey,
    required this.screenWidth,
  }) : _email = email, _password = password, _conformPassword = conformPassword, _formKey = formKey;

  final double screenHeight;
  final TextEditingController _email;
  final TextEditingController _password;
  final TextEditingController _conformPassword;
  final GlobalKey<FormState> _formKey;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
      height: screenHeight * 0.03,
    ),
    //E-mail----------------
    Text(
      textUserName,
      style: TextStyle(
          color: kWhite,
          fontSize: 20,
          fontWeight: FontWeight.bold),
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
          color: kWhite,
          fontSize: 20,
          fontWeight: FontWeight.bold),
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
          color: kWhite,
          fontSize: 20,
          fontWeight: FontWeight.bold),
    ),
    SizedBox(
      height: screenHeight * 0.01,
    ),
    TextFormFieldWidget(
      validator: (value) {
        return Validation.conformPasswordValidation(
            value: value,
            password: _password.text,
            conformPassword: _conformPassword.text);
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
            context.read<AuthBlocBloc>().add(SignUpEvent(
                email: _email.text,
                password: _password.text,
                context: context));
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
          Get.off(ScreenLogin(),
              transition: Transition.cupertino);
        },
      ),
    )
        ],
      ),
    );
  }
}