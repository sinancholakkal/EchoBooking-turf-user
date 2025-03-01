import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/domain/repository/auth_service.dart';
import 'package:echo_booking/feature/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/screen_details_enter/screen_user_details.dart';
import 'package:echo_booking/feature/presentation/pages/sign_up/widget/heading_part_widget.dart';
import 'package:echo_booking/feature/presentation/pages/sign_up/widget/text_field_and_signup_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/loading_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/showDiolog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:get/get.dart';
class ScreenSignUp extends StatefulWidget {
  const ScreenSignUp({super.key});
  @override
  State<ScreenSignUp> createState() => _ScreenSignUpState();
}
class _ScreenSignUpState extends State<ScreenSignUp> {
  late TextEditingController _email;
  late TextEditingController _password;
  late TextEditingController _conformPassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _auth = AuthService();
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _conformPassword = TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return bloc.BlocListener<AuthBlocBloc, AuthBlocState>(
      listener: (context, state) {
        if(state is AuthLoadingState){
          loadingWidget(context);
        }
        else if (state is AuthSuccessState) {
          Get.off(
              () => ScreenUserDetails(
                    user: state.user,
                  ),
              transition: Transition.cupertino,duration: Duration(milliseconds: 1300));
        } else if (state is AuthErrorState) {
          if (state.errorMessage == "email-already-in-use") {
            Navigator.pop(context);
            showDiolog(
              context: context,
              title: "Email Already in Use",
              content:
                  "This email is already registered. Please use a different email or sign in.",
            );
          }
        }
      },
      child: Scaffold(
        backgroundColor: backGroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * .09),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Heading part--------------
                  HeadingPartWidget(screenHeight: screenHeight),

                  //Fields,signup and login-----
                  TextFieldsAndSignUp(screenHeight: screenHeight, email: _email, password: _password, conformPassword: _conformPassword, formKey: _formKey, screenWidth: screenWidth)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}