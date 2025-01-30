import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_booking/core/constent/text/text_constend.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/core/until/validation.dart';
import 'package:echo_booking/domain/model/user_model.dart';
import 'package:echo_booking/domain/repository/auth_service.dart';
import 'package:echo_booking/feature/presentation/bloc/user/user_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/home_screen.dart';
import 'package:echo_booking/feature/presentation/pages/screen_login/screen_login.dart';
import 'package:echo_booking/feature/presentation/widgets/custom_button.dart';
import 'package:echo_booking/feature/presentation/widgets/heading_text.dart';
import 'package:echo_booking/feature/presentation/widgets/loading_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/rich_text_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/text_form_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ScreenUserDetails extends StatefulWidget {
  final User user;
  const ScreenUserDetails({super.key, required this.user});

  @override
  State<ScreenUserDetails> createState() => _ScreenSignUpState();
}

class _ScreenSignUpState extends State<ScreenUserDetails> {
  late TextEditingController _fullName;
  late TextEditingController _phone;
  late TextEditingController _address;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _auth = AuthService();

  @override
  void initState() {
    _fullName = TextEditingController();
    _phone = TextEditingController();
    _address = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(widget.user.uid);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLoadingState) {
          loadingWidget(context);
        } else if (state is UserLoadedState) {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context, rootNavigator: true).pop();
          }
          Get.off(() => ScreenHome());
        }
      },
      child: Scaffold(
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
                      text: "Personal Details",
                    ),
                  ),

                  //Full name----------------
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Text(
                    fullNameText,
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
                      return Validation.nameValidate(value: value);
                    },
                    controller: _fullName,
                  ),

                  //Phone -------------
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Text(
                    phoneText,
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
                      return Validation.phoneNumberValidate(value: value);
                    },
                    controller: _phone,
                  ),

                  //Address---------------
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Text(
                    addressText,
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
                      return Validation.addressValidate(value: value);
                    },
                    controller: _address,
                  ),

                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  //Signup button------------
                  Center(
                    child: CustomButton(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          print(" Validated--------------------");
                          final user = UserModel(
                            name: _fullName.text,
                            phone: _phone.text,
                            address: _address.text,
                            uid: widget.user.uid,
                          );
                          context
                              .read<UserBloc>()
                              .add(UserStoreEvent(user: user));
                          // Get.off(ScreenHome());
                        } else {
                          print("Not Validated--------------------");
                        }
                      },
                      screenWidth: screenWidth,
                      text: "Save",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

 
}
