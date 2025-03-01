import 'dart:ui';

import 'package:echo_booking/core/constent/size/size.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/pages/screen_booking/screen_booking.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class TurfCardWidget extends StatelessWidget {
  const TurfCardWidget({
    super.key,
    required this.screenWidth,
    required this.widget,
  });

  final double screenWidth;
  final ScreenBooking widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: profilecardHeight,
      width: screenWidth * .85,
      decoration: BoxDecoration(
          gradient: linearGradient,
          borderRadius: BorderRadius.circular(profilecardRadius)),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 14),
            width: screenWidth * .23,
            height: screenWidth * .23,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(profilecardRadius),
              //color: Colors.grey,
            ),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(profilecardRadius),
              child: Image.network(
                fit: BoxFit.cover,
                widget.turfModel.images[0],
              ),
            ),
          ),
          Flexible(
            child: SizedBox(
              width: screenWidth * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: 3,
                children: [
                  TextWidget(
                    text: widget.turfModel.turfName,
                    color: kWhite,
                    size: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    width: screenWidth * 0.5,
                    child: TextWidget(
                      text: widget.turfModel.landmark,
                      color: Colors.grey,
                      size: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
