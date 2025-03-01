import 'package:echo_booking/core/constent/text/text_constend.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/core/until/validation.dart';
import 'package:echo_booking/feature/presentation/screen_forgot/screen_forgot.dart';
import 'package:echo_booking/feature/presentation/widgets/text_form_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldsWidget extends StatelessWidget {
  const TextFieldsWidget({
    super.key,
    required this.screenHeight,
    required TextEditingController email,
    required TextEditingController password,
  })  : _email = email,
        _password = password;

  final double screenHeight;
  final TextEditingController _email;
  final TextEditingController _password;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: screenHeight * 0.05,
          ),
          //E-mail----------------
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
          TextFormFieldWidget(
            validator: (value) {
              return Validation.passWordValidation(value);
            },
            controller: _password,
          ),
          SizedBox(
            height: 5,
          ),
          //forgot button----------
          GestureDetector(
            onTap: () {
              Get.to(ScreenForgot(),
                  transition: Transition.cupertino,
                  duration: Duration(microseconds: 800));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Align(
                alignment: Alignment.topRight,
                child: TextWidget(
                  text: "Forgot Password",
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  size: 14,
                ),
              ),
            ),
          ),

          SizedBox(
            height: screenHeight * 0.06,
          ),
        ],
      ),
    );
  }
}