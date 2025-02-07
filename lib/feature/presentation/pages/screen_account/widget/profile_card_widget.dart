import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_booking/core/constent/image/image_constand.dart';
import 'package:echo_booking/core/constent/size/size.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/domain/repository/auth_service.dart';
import 'package:echo_booking/feature/presentation/bloc/user/user_bloc.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCardWidget extends StatefulWidget {
   ProfileCardWidget({
    super.key,
    required this.screenWidth,
  });
  final double screenWidth;


  @override
  State<ProfileCardWidget> createState() => _ProfileCardWidgetState();
}

class _ProfileCardWidgetState extends State<ProfileCardWidget> {
  @override
  void initState() {
    context.read<UserBloc>().add(UserDataFetchingEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: profilecardHeight,
      width: widget.screenWidth * .85,
      decoration: BoxDecoration(
          color: cardBgColor,
          borderRadius: BorderRadius.circular(profilecardRadius)),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if(state is UserLoadedState){
            final data = state.user;
            log(data!.gender);
            log("========================");
            String image = (data.gender=="boy")?avatar[0]:avatar[1];
            return Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 14),
                width: widget.screenWidth * .23,
                height: widget.screenWidth * .23,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(profilecardRadius),
                  //color: Colors.grey,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(profilecardRadius),
                  child: Hero(
                    tag: "avatarHero",
                    child: Image.asset(
                      fit: BoxFit.cover,
                      image,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: 3,
                children: [
                  TextWidget(
                    text: data.name,
                    color: kBlack,
                    size: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    width: widget.screenWidth *0.5,
                    child: TextWidget(
                      text: AuthService().getCurrentUser()!.email.toString(),
                      color: Colors.grey,
                      size: 14,
                    ),
                  ),
                ],
              )
            ],
          );
          }else{
            return SizedBox();
          }
        },
      ),
    );
  }
}
