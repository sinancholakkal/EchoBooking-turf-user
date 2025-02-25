import 'package:echo_booking/core/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularWidget extends StatelessWidget {
  const CircularWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 380,
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