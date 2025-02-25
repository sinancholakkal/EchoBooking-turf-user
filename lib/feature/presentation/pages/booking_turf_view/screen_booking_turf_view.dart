import 'package:echo_booking/core/constent/size/size.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/bloc/item_view/item_view_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/screen_booking/widgets/booking_cardItem_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/widgets/carousel_dobts_builder.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/widgets/carousel_slider_builder_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/detals_card_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
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
  @override
  void initState() {
    details = [
      {'Name': widget.turfmodel.turfName},
      {'Date': widget.turfmodel.bookingDate},
      {'Time': widget.turfmodel.bookingTime},
      {'Category': widget.turfmodel.catogery},
      {'Landmark': widget.turfmodel.landmark},
      {'Includes': widget.turfmodel.includes},
      {'Status': widget.turfmodel.status},
    ];
    super.initState();
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
        child: Column(
          children: [
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
            DetailsCardWidget(
              screenWidth: screenWidth,
              details: details,
              type: DetailsCardType.fromBooking,
            ),
            height10,
            //Outline button for view location-----------
            OutlinedButton.icon(
              onPressed: () {
                context.read<ItemViewBloc>().add(GoogleMapLauncherEvent(
                    position:
                        "${widget.turfmodel.latitude},${widget.turfmodel.longitude}"));
              },
              icon: Icon(
                Icons.location_on,
                color: Colors.red,
              ),
              label: TextWidget(text: "View Location"),
            )
          ],
        ),
      ),
    );
  }
}
