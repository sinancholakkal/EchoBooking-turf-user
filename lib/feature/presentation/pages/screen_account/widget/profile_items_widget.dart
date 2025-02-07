import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ProfileItemsWidget extends StatelessWidget {
  final IconData? icon;
  final String text;
  final double screenWidth;
  final Function()? onTap;
  final Widget? widget;
  ProfileItemsWidget({
    super.key,
    this.icon,
    required this.text,
    required this.screenWidth,
    this.onTap,
    this.widget
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: screenWidth*.05),
      child: ListTile(
        onTap: onTap  ,
        leading: Padding(
          padding:  EdgeInsets.only(right: 8),
          child: (widget==null)?Icon(
            icon,
            size: 35,
            color: iconColor,
          ):widget,
        ),
        title: TextWidget(text: text),
      ),
    );
  }
}
