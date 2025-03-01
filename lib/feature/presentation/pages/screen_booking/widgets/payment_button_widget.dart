import 'package:echo_booking/core/constent/size/size.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/pages/screen_booking/data/data.dart';
import 'package:echo_booking/feature/presentation/pages/screen_booking/screen_booking.dart';
import 'package:echo_booking/feature/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentButtonWidget extends StatelessWidget {
  const PaymentButtonWidget({
    super.key,
    required this.taxesAndFee,
    required this.widget,
    required Razorpay razorpay,
    required this.screenWidth,
  }) : _razorpay = razorpay;

  final num taxesAndFee;
  final ScreenBooking widget;
  final Razorpay _razorpay;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onTap: () {
        num totalAmount =
            (taxesAndFee + int.parse(widget.turfModel.price)) * 100;
       ScreenBookingData.openCheckout(totalAmount,_razorpay);
      },
      text: "Add Payment Method",
      color: kblue,
      height: 55,
      radius: cardRadius,
      width: screenWidth * .85,
      textStyle: TextStyle(
          color: kWhite, fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}