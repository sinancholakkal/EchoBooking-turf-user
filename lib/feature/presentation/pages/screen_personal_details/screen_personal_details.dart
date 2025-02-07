import 'dart:developer';

import 'package:echo_booking/core/constent/image/image_constand.dart';
import 'package:echo_booking/core/constent/size/size.dart';
import 'package:echo_booking/core/constent/text/text_constend.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/core/until/validation.dart';
import 'package:echo_booking/domain/model/user_model.dart';
import 'package:echo_booking/domain/repository/user_service.dart';
import 'package:echo_booking/feature/presentation/bloc/user/user_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/screen_personal_details/widgets/avatar_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_personal_details/widgets/profile_text_form_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ScreenPersonalDetails extends StatefulWidget {
  ScreenPersonalDetails({super.key});

  @override
  State<ScreenPersonalDetails> createState() => _ScreenPersonalDetailsState();
}

class _ScreenPersonalDetailsState extends State<ScreenPersonalDetails> {
  late TextEditingController _name;
  late TextEditingController _address;
  late TextEditingController _phone;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FixedExtentScrollController _scrollController;
  String? gender;

  @override
  void initState() {
    _name = TextEditingController();
    _address = TextEditingController();
    _phone = TextEditingController();
    _scrollController = FixedExtentScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _address.dispose();
    _phone.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if(state is UserDataUpdating){
           log("Updating........");
           loadingWidget(context);
        }else if(state is UserLoadedState){
          Navigator.pop(context);
          log("Updated");
        }
      
      },
      child: Scaffold(
        backgroundColor: backGroundColor,
        body: SingleChildScrollView(
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoadedState) {
                log(state.user!.name);
                final data = state.user;
                _name.text = data!.name;
                _address.text = data.address;
                _phone.text = data.phone;
                gender = data.gender;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollController.jumpToItem((data.gender == "boy") ? 0 : 1);
                });
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Avatar widget wheelScrolling-------------
                      Container(
                        width: double.infinity,
                        height: 200,
                        color: const Color.fromARGB(255, 31, 27, 27),
                        child: RotatedBox(
                          quarterTurns: -1,
                          child: ListWheelScrollView(
                            controller: _scrollController,
                            physics: FixedExtentScrollPhysics(),
                            perspective: 0.009,
                            onSelectedItemChanged: (val) {
                              log(val.toString());
                              gender = (val == 0) ? "boy" : "girl";
                            },
                            itemExtent: 100,
                            children: [
                              //avatar widget-------------
                              AvatarWidget(image: avatar[0],),
                              AvatarWidget(image: avatar[1],),
                            ],
                          ),
                        ),
                      ),
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
                      ElevatedButton(
                          onPressed: () {
                            log("$gender================");
                            if (_formKey.currentState!.validate()) {
                              print(" Validated--------------------");
                              UserModel userModel = UserModel(
                                name: _name.text,
                                phone: _phone.text,
                                address: _address.text,
                                uid: data.uid,
                                gender: gender!,
                              );
                              context.read<UserBloc>().add(
                                  UserDataUpdateEvent(userModel: userModel));
                            } else {
                              print("Not Validated--------------------");
                            }
                          },
                          child: Text("Update"))
                    ],
                  ),
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}

