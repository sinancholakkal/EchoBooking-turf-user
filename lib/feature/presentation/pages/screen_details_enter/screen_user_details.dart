import 'dart:developer';
import 'package:echo_booking/core/constent/image/image_constand.dart';
import 'package:echo_booking/core/constent/text/text_constend.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/bloc/user/user_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/home_screen.dart';
import 'package:echo_booking/feature/presentation/pages/screen_details_enter/widget/text_form_field_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/heading_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
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
  int avatarSelected = 0;
  @override
  void initState() {
    _fullName = TextEditingController();
    _phone = TextEditingController();
    _address = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _fullName.dispose();
    _phone.dispose();
    _address.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    log(widget.user.uid);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return bloc.BlocListener<UserBloc, UserState>(
      listener: (context, state) async {
        if (state is UserLoadingState) {
        } else if (state is UserAddedState) {
          log("poped==============");
          Get.offAll(() => ScreenHome(),
              transition: Transition.cupertino,
              duration: Duration(milliseconds: 1300));
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
                  //Avatar select part----------
                  SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: ListWheelScrollView(
                        physics: FixedExtentScrollPhysics(),
                        perspective: 0.009,
                        onSelectedItemChanged: (val) {
                          avatarSelected = val;
                        },
                        itemExtent: 100,
                        children: [
                          RotatedBox(
                            quarterTurns: 1,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage(avatar[0]),
                            ),
                          ),
                          RotatedBox(
                            quarterTurns: 1,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage(avatar[1]),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  //All text form fields--------------
                  TextFormFieldesWidget(screenHeight: screenHeight, fullName: _fullName, phone: _phone, address: _address, formKey: _formKey, avatarSelected: avatarSelected, widget: widget, screenWidth: screenWidth)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}