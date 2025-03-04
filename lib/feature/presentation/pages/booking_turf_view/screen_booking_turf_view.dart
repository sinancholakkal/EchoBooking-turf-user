import 'dart:developer';

import 'package:echo_booking/core/constent/size/size.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/bloc/star_rating_bloc/star_rating_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/booking_turf_view/data/data.dart';
import 'package:echo_booking/feature/presentation/pages/booking_turf_view/widget/location_button.dart';
import 'package:echo_booking/feature/presentation/pages/booking_turf_view/widget/star_rating_field_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_booking/widgets/booking_cardItem_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/widgets/carousel_dobts_builder.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/widgets/carousel_slider_builder_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/detals_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenBookingTurfView extends StatefulWidget {
  String tag;
  final dynamic turfmodel;
  ScreenBookingTurfView(
      {super.key, required this.tag, required this.turfmodel});
  @override
  State<ScreenBookingTurfView> createState() => _ScreenBookingTurfViewState();
}
class _ScreenBookingTurfViewState extends State<ScreenBookingTurfView> {
  late List<Map<String, String>> details;
  late TextEditingController _feedbackController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double rating = 1;
  @override
  void initState() {
    log(widget.turfmodel.turfId);
    log(widget.turfmodel.bookingId);
    log("===============");
    log("===========");
    context
        .read<StarRatingBloc>()
        .add(FetchReviewEvent(turfId: widget.turfmodel.bookingId));
    _feedbackController = TextEditingController();
    details = getDetails(widget.turfmodel);
    super.initState();
  }
  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backGroundColor,
        iconTheme: IconThemeData(color: kWhite),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: backGroundGradient,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //carousal image displaying--------------
              CarouselSlideBuilderWidget(
                  widget: widget, screenWidth: screenWidth),
              SizedBox(
                height: 4,
              ),
              //carousal dobts.............
              CarouselDobtsBuilderWidget(widget: widget),
              SizedBox(
                height: 30,
              ),
              //Displat the card and details-------------
              SizedBox(
                child: Column(
                  children: [
                    DetailsCardWidget(
                      screenWidth: screenWidth,
                      details: details,
                      type: DetailsCardType.fromBooking,
                    ),
                    height10,
                    //Star rating field--------
                    StarRatingFieldWidget(widget: widget, screenWidth: screenWidth, feedbackController: _feedbackController, formKey: _formKey, rating: rating),
                    height10,
                    //Outline button for view location-----------
                    LocationButtonWidget(widget: widget),
                  ],
                ),
              ),
              height10,
              height10
            ],
          ),
        ),
      ),
    );
  }
}
