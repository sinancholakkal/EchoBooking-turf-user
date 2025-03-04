import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/home_screen.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ScreenPaymentSuccess extends StatefulWidget {
  const ScreenPaymentSuccess({super.key});

  @override
  State<ScreenPaymentSuccess> createState() => _ScreenPaymentSuccessState();
}

class _ScreenPaymentSuccessState extends State<ScreenPaymentSuccess> {
Future<void>splashTime()async{
  await Future.delayed(Duration(milliseconds: 1500));
  Get.offAll(()=>ScreenHome());
}
  @override
  void initState() {
    splashTime();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: backGroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(
                'https://lottie.host/5c09846e-0f86-4fd2-8e0f-df3e0d780015/bAGmD18dit.json',
                height: 250,
                width: 350),
             Center(
              child: TextWidget(text: "Payment Done"),
            ),
             Center(
              child: TextWidget(text: "Successfully"),
            ),

          ],
        ),
      ),
    );
  }
}