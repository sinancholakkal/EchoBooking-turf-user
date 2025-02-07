import 'package:echo_booking/core/constent/text/text_constend.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/core/until/validation.dart';
import 'package:echo_booking/feature/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:echo_booking/feature/presentation/widgets/text_form_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenForgot extends StatefulWidget {
   ScreenForgot({super.key});

  @override
  State<ScreenForgot> createState() => _ScreenForgotState();
}

class _ScreenForgotState extends State<ScreenForgot> {
  late TextEditingController _email;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _email = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: backGroundColor,
        iconTheme: IconThemeData(color: kWhite),
        title: TextWidget(text: "Forgot Password"),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              textUserName,
              style: TextStyle(
                  color: kWhite, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Form(
              key: _formKey,
              child: TextFormFieldWidget(
                controller: _email,
                validator: (value){
                  return Validation.emailValidation(value);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: ElevatedButton(onPressed: () {
                   if (_formKey.currentState!.validate()) {
                          print(" Validated--------------------");
                          context.read<AuthBlocBloc>().add(ForgotpasswordEvent(email: _email.text.trim()));
                        } else {
                          print("Not Validated--------------------");
                        }
                }, child: Text("Reset")))
          ],
        ),
      )),
    );
  }
}
