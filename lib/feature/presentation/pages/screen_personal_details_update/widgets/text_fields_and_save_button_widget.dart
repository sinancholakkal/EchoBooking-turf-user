import 'dart:developer';

import 'package:echo_booking/core/constent/size/size.dart';
import 'package:echo_booking/core/constent/text/text_constend.dart';
import 'package:echo_booking/core/until/validation.dart';
import 'package:echo_booking/domain/model/user_model.dart';
import 'package:echo_booking/feature/presentation/bloc/user/user_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/screen_personal_details_update/widgets/profile_text_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextFieldsAndSaveButtonWidget extends StatelessWidget {
   TextFieldsAndSaveButtonWidget({
    super.key,
    required TextEditingController name,
    required TextEditingController address,
    required TextEditingController phone,
    required this.gender,
    required GlobalKey<FormState> formKey,
    required this.data,
  }) : _name = name, _address = address, _phone = phone, _formKey = formKey;

  final TextEditingController _name;
  final TextEditingController _address;
  final TextEditingController _phone;
  ValueNotifier<String?>gender;
  final GlobalKey<FormState> _formKey;
  final UserModel? data;

  @override
  Widget build(BuildContext context) {
    log("$gender 555555555555555");
    return SizedBox(
      child: Column(
        children: [
          //name form--------------
    ProfileTextFormField(
      labelText: fullNameText,
      controller: _name,
      validation: (value) {
        return Validation.nameValidate(value: _name.text);
      },
    ),
    height10,
    //address form-----------------
    ProfileTextFormField(
      labelText: addressText,
      controller: _address,
      validation: (value) {
        return Validation.addressValidate(
            value: _address.text);
      },
    ),
    height10,
    //phone form----------------
    ProfileTextFormField(
      labelText: phoneText,
      controller: _phone,
      validation: (value) {
        return Validation.phoneNumberValidate(
            value: _phone.text);
      },
    ),
    //submit button---------------
    ValueListenableBuilder(
      valueListenable: gender,
      builder: (context, gValue, child) {
        return ElevatedButton(
          onPressed: () {
            log("$gender================");
            if (_formKey.currentState!.validate()) {
              print(" Validated--------------------");
              UserModel userModel = UserModel(
                name: _name.text,
                phone: _phone.text,
                address: _address.text,
                uid: data!.uid,
                gender: gValue !,
              );
              context.read<UserBloc>().add(
                  UserDataUpdateEvent(userModel: userModel));
            } else {
              print("Not Validated--------------------");
            }
          },
          child: Text("Update"))
;      },
    
    )
        ],
      ),
    );
  }
}

