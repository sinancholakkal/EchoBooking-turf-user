import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/pages/screen_search/screen_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchWidget extends StatelessWidget {
  final bool onTapMove;
  final double width;
  final TextEditingController? controller;
  final void Function(String)? onSubmitted;
  final bool enable;

  SearchWidget({
    super.key,
    required this.onTapMove,
    this.width = 400,
    this.controller,
    this.onSubmitted,
    this.enable = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapMove?() {
        if (onTapMove) {
          print("Navigating to ScreenSearch..."); // Debugging print
          Get.to(() => ScreenSearch(), transition: Transition.fade);
        }
      }:null,
      child: SizedBox(
        width: width,
        height: 50,
        child: Stack(
          children: [
            CupertinoSearchTextField(
              enabled: enable,
              controller: controller,
              style: TextStyle(color: kWhite),
              onSubmitted: onSubmitted,
              itemColor: Colors.white60,
              itemSize: 26,
              backgroundColor: searchBgColor,
            ),
            Visibility(
              visible: onTapMove,
              child: Positioned.fill(
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
