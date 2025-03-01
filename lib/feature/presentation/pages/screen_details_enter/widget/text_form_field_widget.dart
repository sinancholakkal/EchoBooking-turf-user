import 'package:echo_booking/core/constent/text/text_constend.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/core/until/validation.dart';
import 'package:echo_booking/domain/model/user_model.dart';
import 'package:echo_booking/feature/presentation/bloc/user/user_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/screen_details_enter/screen_user_details.dart';
import 'package:echo_booking/feature/presentation/widgets/custom_button.dart';
import 'package:echo_booking/feature/presentation/widgets/text_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextFormFieldesWidget extends StatelessWidget {
  const TextFormFieldesWidget({
    super.key,
    required this.screenHeight,
    required TextEditingController fullName,
    required TextEditingController phone,
    required TextEditingController address,
    required GlobalKey<FormState> formKey,
    required this.avatarSelected,
    required this.widget,
    required this.screenWidth,
  })  : _fullName = fullName,
        _phone = phone,
        _address = address,
        _formKey = formKey;

  final double screenHeight;
  final TextEditingController _fullName;
  final TextEditingController _phone;
  final TextEditingController _address;
  final GlobalKey<FormState> _formKey;
  final int avatarSelected;
  final ScreenUserDetails widget;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          //Full name----------------
          SizedBox(
            height: screenHeight * 0.03,
          ),
          Text(
            fullNameText,
            style: TextStyle(
                color: kWhite, fontSize: 20, fontWeight: FontWeight.bold),
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
                color: kWhite, fontSize: 20, fontWeight: FontWeight.bold),
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
                color: kWhite, fontSize: 20, fontWeight: FontWeight.bold),
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
                    gender: (avatarSelected == 0) ? "boy" : "girl",
                    name: _fullName.text,
                    phone: _phone.text,
                    address: _address.text,
                    uid: widget.user.uid,
                  );
                  context.read<UserBloc>().add(UserStoreEvent(user: user));
                  // Get.off(ScreenHome());
                } else {
                  print("Not Validated--------------------");
                }
              },
              screenWidth: screenWidth,
              text: "Save",
            ),
          )
        ],
      ),
    );
  }
}
