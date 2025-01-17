import 'package:echo_booking/feature/presentation/pages/screen_welcome/screen_welcome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: ScreenWelcome(),
      debugShowCheckedModeBanner: false,
    );
  }
}