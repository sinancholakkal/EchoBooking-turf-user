import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/home_screen.dart';
import 'package:echo_booking/feature/presentation/pages/screen_welcome/screen_welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    splashingtime();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: Center(
        child: Text("Loading",style: TextStyle(color: kWhite,fontSize: 18),),
      ),
    );
  }
  Future<void>splashingtime()async{
    await Future.delayed(Duration(seconds: 2));
    if(_auth.currentUser==null){
      Get.off(()=>ScreenWelcome(),transition: Transition.cupertino);
    }else{
      Get.off(()=>ScreenHome(),transition: Transition.cupertino);
    }
    
  }
}
