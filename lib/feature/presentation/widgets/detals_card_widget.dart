import 'dart:developer';

import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/pages/screen_booking/widgets/booking_cardItem_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class DetailsCardWidget extends StatelessWidget {
  const DetailsCardWidget(
      {super.key,
      required this.screenWidth,
      required this.details,
      required this.type});

  final double screenWidth;
  final List<Map<String, String>> details;
  final DetailsCardType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 25, right: 10, bottom: 25),
      width: screenWidth * .85,
      //height: 300,
      decoration: BoxDecoration(
          gradient: linearGradient, borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(details.length, (index) {
          String? date;
          if (details[index].entries.first.key == "Date") {
            log(details[index].entries.first.value);
            date = DateFormat('dd MMM yyyy').format(DateFormat('dd-MM-yyyy')
                .parse(details[index].entries.first.value));
            log("$date ===============");
          }
          return BookingCardItemWidget(
            type: type,
            leftText: details[index].entries.first.key,
            rightText: date ?? details[index].entries.first.value,
            divider: (details.length - 1 == index) ? false : true,
          );
        }),
      ),
    );
  }
}
