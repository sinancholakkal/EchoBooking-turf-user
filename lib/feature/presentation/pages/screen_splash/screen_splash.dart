import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:echo_booking/feature/presentation/bloc/turf_bloc/turf_bloc.dart';
import 'package:echo_booking/feature/presentation/bloc/user/user_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/home_screen.dart';
import 'package:echo_booking/feature/presentation/pages/screen_welcome/screen_welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
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
    super.initState();
    context.read<AuthBlocBloc>().add(CheckLoginStatusEvent());
    context.read<TurfBloc>().add(TurfFetchEvent());
    //context.read<UserBloc>().add(UserDataFetchingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return bloc.BlocListener<AuthBlocBloc, AuthBlocState>(
      listener: (context, state) {
       if(state is AuthSuccessState){
        Get.off(() => ScreenHome(), transition: Transition.cupertino);
       }else if(state is AuthUnSuccessState){
         Get.off(() => ScreenWelcome(), transition: Transition.cupertino);
       }
      },
      child: Scaffold(
        backgroundColor: backGroundColor,
        body: Center(
          child: Text(
            "Loading",
            style: TextStyle(color: kWhite, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
