import 'package:echo_booking/domain/repository/auth_service.dart';
import 'package:echo_booking/feature/presentation/pages/screen_account/widget/profile_items_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_welcome/screen_welcome.dart';
import 'package:echo_booking/feature/presentation/widgets/alert_dialog_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogOutWidget extends StatelessWidget {
  const LogOutWidget({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return ProfileItemsWidget(
      text: "Long out",
      icon: Icons.exit_to_app,
      screenWidth: screenWidth,
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialogWidget(
                title: "Logout",
                content: "Are you sure you want to logout?",
                cancelOnTap: () {
                  Get.back();
                },
                okOnTap: () async{
                  loadingWidget(context);
                  AuthService().signOut();
                  await Future.delayed(Duration(seconds: 1));
                  Get.offAll(() => ScreenWelcome(),
                      transition: Transition.cupertino);
                },
              );
            });
      },
    );
  }
}


