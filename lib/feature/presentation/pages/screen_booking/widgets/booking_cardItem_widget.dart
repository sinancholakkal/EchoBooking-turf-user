import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookingCardItemWidget extends StatelessWidget {
  final String leftText;
  final String rightText;
  final Color? divideColor;
   final Color? textColor;
  final bool divider;
  final DetailsCardType type;
   BookingCardItemWidget({
    super.key,
    required this.leftText,
    required this.rightText,
     this.divideColor,
    this.textColor,
    this.divider = true,
    required this.type
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 14,bottom: 6,right: 14),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  text: leftText,
                  size: 16,
                  color: textColor?? Color.fromARGB(255, 215, 199, 199),
                ),
                SizedBox(width: (rightText.length>25)?35:0),
                Flexible(
                  child: TextWidget(
                    text: rightText,
                    size:(leftText=="Status")?22: 16,
                    maxLine: 10,
                    fontWeight: (leftText=="Status")?FontWeight.bold:FontWeight.normal,
                    color: (leftText=="Status")?const Color.fromARGB(255, 255, 48, 33):textColor?? Color.fromARGB(255, 215, 199, 199),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 14),
            child: Visibility(
              visible: divider,
              child: Divider(
                color: divideColor ?? Colors.grey[700],
              ),
            ),
          )
        ],
      ),
    );
  }
}
enum DetailsCardType{
  fromBooking,
  fromItemView,
}