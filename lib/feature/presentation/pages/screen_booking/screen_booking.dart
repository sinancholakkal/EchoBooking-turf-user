import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/domain/model/turf_model.dart';
import 'package:echo_booking/feature/presentation/bloc/payment_screen_bloc/payment_bloc.dart';
import 'package:echo_booking/feature/presentation/bloc/user/user_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/screen_booking/data/data.dart';
import 'package:echo_booking/feature/presentation/pages/screen_booking/widgets/booking_cardItem_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_booking/widgets/payment_button_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_booking/widgets/turf_card_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_payment_success/screen_payment_success.dart';
import 'package:echo_booking/feature/presentation/widgets/detals_card_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/flutter_toast.dart';
import 'package:echo_booking/feature/presentation/widgets/loading_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ScreenBooking extends StatefulWidget {
   TurfModel turfModel;
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
  final ScreenBookingData screenBookingData = ScreenBookingData();
  void handlePaymentSuccess(PaymentSuccessResponse response) {
    paymentId = response.paymentId;
    context.read<UserBloc>().add(UserDataFetchingEvent());
  }
 
  late List<Map<String, String>> details;
  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, screenBookingData.handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, screenBookingData.handleExternalWallet);
    int price = int.parse(widget.turfModel.price);
    taxesAndFee = price * (18 / 100);
    details = ScreenBookingData.getDetailsScreenBooking(
        turfModel: widget.turfModel,
        taxesAndFee: taxesAndFee,
        time: widget.time);
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
              widget.turfModel.turfId = ScreenBookingData.getRandomId();
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
                //Display turf card(Image,name,landmark)---------
                TurfCardWidget(screenWidth: screenWidth, widget: widget),
                SizedBox(
                  height: screenHeight * 0.18,
                ),
                //Details card(amount,time,...)
                DetailsCardWidget(
                  screenWidth: screenWidth,
                  details: details,
                  type: DetailsCardType.fromItemView,
                ),
                SizedBox(
                  height: screenHeight * 0.06,
                ),
                //Payment Button----------------
                PaymentButtonWidget(taxesAndFee: taxesAndFee, widget: widget, razorpay: _razorpay, screenWidth: screenWidth)
              ],
            ),
          ),
        ),
      ),
    );
  }

}