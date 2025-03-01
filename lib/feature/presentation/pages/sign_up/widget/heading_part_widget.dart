import 'package:echo_booking/core/constent/text/text_constend.dart';
import 'package:echo_booking/feature/presentation/widgets/heading_text.dart';
import 'package:flutter/material.dart';

class HeadingPartWidget extends StatelessWidget {
  const HeadingPartWidget({
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          SizedBox(
      height: screenHeight * 0.05,
    ),
    Align(
      alignment: Alignment.topLeft,
      child: HeadingText(
        text: appTitle,
      ),
    ),
    SizedBox(
      height: screenHeight * 0.06,
    ),
    Align(
      alignment: Alignment.topLeft,
      child: HeadingText(
        text: "Create Account Now!",
      ),
    ),
        ],
      ),
    );
  }
}
