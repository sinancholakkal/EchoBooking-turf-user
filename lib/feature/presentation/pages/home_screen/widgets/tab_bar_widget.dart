import 'package:echo_booking/core/constent/size/size.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({
    super.key,
    required this.screenWidth,
    required this.tabRadius,
  });

  final double screenWidth;
  final double tabRadius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04),
      child: TabBar(
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(tabRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent,
              blurRadius: 4.0,
            ),
          ],
        ),
        labelColor: kWhite,
        unselectedLabelColor: Colors.grey,
        tabs: [
          Tab(
            icon: Icon(
              Icons.home,
              color: homeIconColor,
              size: homeTabIconSize,
            ),
            text: "For You",
          ),
          Tab(
            icon: Icon(
              Icons.bookmark_added,
              size: homeTabIconSize,
              color: bookingIconColor,
            ),
            text: "Booking",
          ),
          Tab(
            icon: Icon(
              Icons.stars,
              size: homeTabIconSize,
              color: starIconColor,
            ),
            text: "Star",
          )
        ],
      ),
    );
  }
}

