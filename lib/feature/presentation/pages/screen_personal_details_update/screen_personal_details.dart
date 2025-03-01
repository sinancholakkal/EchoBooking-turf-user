import 'dart:developer';
import 'package:echo_booking/core/constent/image/image_constand.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/bloc/user/user_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/screen_personal_details_update/widgets/avatar_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_personal_details_update/widgets/text_fields_and_save_button_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ScreenPersonalDetails extends StatefulWidget {
  const ScreenPersonalDetails({super.key});

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
                      //Fields and update button----------
                      TextFieldsAndSaveButtonWidget(name: _name, address: _address, phone: _phone, gender: gender, formKey: _formKey, data: data)
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

