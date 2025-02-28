import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ReviewAllButtonWidget extends StatelessWidget {
  Function()? onTap;
   ReviewAllButtonWidget({
    super.key,
    required this.onTap,
    
  });


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 22),
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            border: Border.all(color: kWhite),
            borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: TextWidget(
            text: "View All",
            size: 16,
          ),
        ),
      ),
    );
  }
}