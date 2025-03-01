import 'package:echo_booking/feature/presentation/pages/home_screen/widgets/search_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_account/screen_account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabBarIconSearchWidget extends StatelessWidget {
  const TabBarIconSearchWidget({
    super.key,
    required this.screenHeight,
    required this.image,
  });

  final double screenHeight;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            SizedBox(
              height: screenHeight * 0.05,
            ),
    
            // account icon button-----------------
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Get.to(() => ScreenAccount(),
                      transition: Transition.cupertino,
                      duration:
                          Duration(milliseconds: 600));
                },
                icon: Hero(
                  tag: "avatarHero",
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(image),
                  ),
                ),
              ),
            ),
            //search----------------
            SearchWidget(onTapMove: true,),
          ],
        ),
      ],
    );
  }
}

