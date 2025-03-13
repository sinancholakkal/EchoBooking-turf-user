import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/pages/screen_privacy_policy/widget/privacy_policy_section.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ScreenPrivacyPolicy extends StatelessWidget {
  const ScreenPrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        title: TextWidget(text: "Privacy Policy"),
        centerTitle: true,
        backgroundColor: backGroundColor,
        iconTheme: IconThemeData(
          color: kWhite
        ),
      ),
      body: SingleChildScrollView(
        child: PrivacyPolicyContentSection(),
      ),
    );
  }
}

