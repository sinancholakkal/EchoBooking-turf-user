import 'package:echo_booking/core/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularWidget extends StatelessWidget {
  final double top;
  const CircularWidget({super.key,this.top = 300});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: top,
          ),
          CircularProgressIndicator(
            color: kWhite,
            strokeWidth: 1.5,
          ),
        ],
      ),
    );
  }
}
