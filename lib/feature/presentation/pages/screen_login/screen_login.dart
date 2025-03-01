import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/domain/repository/auth_service.dart';
import 'package:echo_booking/feature/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/home_screen.dart';
import 'package:echo_booking/feature/presentation/pages/screen_login/widget/heading_part_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_login/widget/login_and_social_media_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_login/widget/text_fields_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/loading_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/showDiolog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:get/get.dart';
class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});
  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}
class _ScreenLoginState extends State<ScreenLogin> {
  late TextEditingController _email;
  late TextEditingController _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return bloc.BlocListener<AuthBlocBloc, AuthBlocState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          loadingWidget(context);
        } else if (state is AuthSuccessState) {
          Get.offAll(() => ScreenHome(),
              transition: Transition.cupertino,
              duration: Duration(milliseconds: 1300));
        } else if (state is AuthErrorState) {
          Navigator.pop(context);
          if (state.errorMessage == "invalid-credential") {
            showDiolog(
              context: context,
              title: "Incorrect Password",
              content:
                  "The password you entered is incorrect.\nPlease try again.",
            );
          }
        }
        //Navigator.pop(context);
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
                  //all Headings part-----------
                  HeadingsPartWidget(),
                  //Text fieds widget(E-mail, password and forgot password)------
                  TextFieldsWidget(
                      screenHeight: screenHeight,
                      email: _email,
                      password: _password),
                  //Login button------------
                  LoginAndSocialMediaWidget(formKey: _formKey, email: _email, password: _password, screenWidth: screenWidth)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



