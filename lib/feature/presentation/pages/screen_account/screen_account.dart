import 'package:echo_booking/core/constent/size/size.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/domain/repository/auth_service.dart';
import 'package:echo_booking/feature/presentation/bloc/user/user_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/screen_account/widget/log_out_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_account/widget/profile_card_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_account/widget/profile_items_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_personal_details/screen_personal_details.dart';
import 'package:echo_booking/feature/presentation/pages/screen_welcome/screen_welcome.dart';
import 'package:echo_booking/feature/presentation/widgets/alert_dialog_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/loading_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:get/get.dart';

class ScreenAccount extends StatelessWidget {
   ScreenAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kWhite
        ),
        backgroundColor: backGroundColor,
        title: TextWidget(
          text: "Profile",
          fontWeight: FontWeight.bold,
          size: 22,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          //profile card widget-------------
          Align(
            alignment: Alignment.topCenter,
            child: ProfileCardWidget(screenWidth: screenWidth),
          ),
          height22,
          //Personal details-----
          ProfileItemsWidget(
            text: "Personal Details",
            icon: Icons.account_circle,
            screenWidth: screenWidth,
            onTap: () => Get.to(() => ScreenPersonalDetails(),
                transition: Transition.cupertino,duration: Duration(milliseconds: 800)),
          ),
          height22,
          //About--------------------
          ProfileItemsWidget(
            text: "About",
            icon: Icons.info,
            screenWidth: screenWidth,
          ),
          SizedBox(
            height: 22,
          ),
          // Long out----------
          LogOutWidget(screenWidth: screenWidth),
        ],
      ),
    );
  }
}
