import 'dart:developer';

import 'package:echo_booking/core/constent/size/size.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/domain/model/turf_model.dart';
import 'package:echo_booking/feature/presentation/bloc/payment_screen_bloc/payment_bloc.dart';
import 'package:echo_booking/feature/presentation/bloc/user/user_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/widgets/card_turf_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_booking/widgets/booking_cardItem_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_payment_success/screen_payment_success.dart';
import 'package:echo_booking/feature/presentation/widgets/custom_button.dart';
import 'package:echo_booking/feature/presentation/widgets/detals_card_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/flutter_toast.dart';
import 'package:echo_booking/feature/presentation/widgets/loading_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ScreenBooking extends StatefulWidget {
  final TurfModel turfModel;
  final String time;
  final String dateKey;
  ScreenBooking(
      {super.key,
      required this.turfModel,
      required this.time,
      required this.dateKey});

  @override
  State<ScreenBooking> createState() => _ScreenBookingState();
}

class _ScreenBookingState extends State<ScreenBooking> {
  late num taxesAndFee;
  late Razorpay _razorpay;
  String? paymentId;
  void openCheckout(amount) async {
    var options = {
      "key": 'rzp_test_4MBYamMKeUifHI',
      'amount': amount,
      'name': 'Echo Turf Booking Application',
      'prefill': {'contact': '1234567890', 'email': 'test@gmail.com'},
      "method": {"upi": true, "card": true, "netbanking": true, "wallet": true}
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      log("Error while doing payment $e");
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    paymentId = response.paymentId;
    context.read<UserBloc>().add(UserDataFetchingEvent());
  }

  void handlePaymentError(PaymentFailureResponse response) {
    flutterToast(msg: "Payment Fail ${response.message!}", color: kGrey);
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    flutterToast(
        msg: "Payment Successfull ${response.walletName!}", color: kGrey);
  }

  late List<Map<String, String>> details;

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
    int price = int.parse(widget.turfModel.price);
    taxesAndFee = price * (18 / 100);
    log(taxesAndFee.toString());

    details = [
      {"Time": widget.time},
      {"Book amount": "₹${widget.turfModel.price}"},
      {"Taxes & fees": taxesAndFee.toString()},
      {
        "Total Price": "${taxesAndFee + int.parse(widget.turfModel.price)}",
      }
    ];
    super.initState();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return MultiBlocListener(
      listeners: [
        BlocListener<PaymentBloc, PaymentState>(
          listener: (context, state) {
            if (state is PaymentSuccessLoadingState) {
              loadingWidget(context);
            } else if (state is PaymentSuccessState) {
              Navigator.pop(context);
              Get.to(() => ScreenPaymentSuccess());
              flutterToast(msg: "Payment Successfully Completed", color: kGrey);
            }
          },
        ),
        BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserLoadedState) {
              widget.turfModel.price =
                  "${taxesAndFee + int.parse(widget.turfModel.price)}";
              context.read<PaymentBloc>().add(PaymentSuccessEvent(
                  userModel: state.user!,
                  turfModel: widget.turfModel,
                  paymentId: paymentId!,
                  dateKey: widget.dateKey,
                  bookedTime: widget.time));
            }
          },
        ),
      ],
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: kWhite),
          title: TextWidget(text: "Booking"),
          centerTitle: true,
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: backGroundGradient,
          ),
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  height: profilecardHeight,
                  width: screenWidth * .85,
                  decoration: BoxDecoration(
                      gradient: linearGradient,
                      borderRadius: BorderRadius.circular(profilecardRadius)),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 14),
                        width: screenWidth * .23,
                        height: screenWidth * .23,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(profilecardRadius),
                          //color: Colors.grey,
                        ),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(profilecardRadius),
                          child: Image.network(
                            fit: BoxFit.cover,
                            widget.turfModel.images[0],
                          ),
                        ),
                      ),
                      Flexible(
                        child: SizedBox(
                          width: screenWidth * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            spacing: 3,
                            children: [
                              TextWidget(
                                text: widget.turfModel.turfName,
                                color: kWhite,
                                size: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(
                                width: screenWidth * 0.5,
                                child: TextWidget(
                                  text: widget.turfModel.landmark,
                                  color: Colors.grey,
                                  size: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.18,
                ),
                DetailsCardWidget(screenWidth: screenWidth, details: details,type: DetailsCardType.fromItemView,),
                SizedBox(
                  height: screenHeight * 0.06,
                ),
                CustomButton(
                  onTap: () {
                    num totalAmount =
                        (taxesAndFee + int.parse(widget.turfModel.price)) * 100;
                    openCheckout(totalAmount);
                  },
                  text: "Add Payment Method",
                  color: kblue,
                  height: 55,
                  radius: cardRadius,
                  width: screenWidth * .85,
                  textStyle: TextStyle(
                      color: kWhite, fontSize: 18, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}