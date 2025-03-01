import 'package:echo_booking/core/constent/size/size.dart';
import 'package:echo_booking/core/constent/text/text_constend.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/widgets/heading_text.dart';
import 'package:flutter/material.dart';

class HeadingsPartWidget extends StatelessWidget {
  const HeadingsPartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          height60,
          //app title-----------
          Align(
            alignment: Alignment.topLeft,
            child: HeadingText(
              text: appTitle,
            ),
          ),
          SizedBox(
            height: 70,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: HeadingText(
              text: "Welcome Back!",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Login to continue",
              style: TextStyle(color: kWhite, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
