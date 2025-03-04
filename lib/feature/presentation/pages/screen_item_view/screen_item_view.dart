import 'dart:developer';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/data/get_star_id.dart';
import 'package:echo_booking/feature/data/repository/fetch_time_slotes.dart';
import 'package:echo_booking/feature/presentation/bloc/item_view/item_view_bloc.dart';
import 'package:echo_booking/feature/presentation/bloc/star_rating_bloc/star_rating_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/widgets/card_turf_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/widgets/carousel_dobts_builder.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/widgets/carousel_slider_builder_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/widgets/floating_actions.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/widgets/loc_and_book_button_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/widgets/rating_field_part_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/widgets/time_slot_part_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/widgets/turf_details_part_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/circular_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
class ScreenItemView extends StatefulWidget {
  String tag;
  final dynamic turfmodel;
  final ActionTypeFrom type;
  ScreenItemView(
      {super.key,
      required this.tag,
      required this.turfmodel,
      required this.type});

  @override
  State<ScreenItemView> createState() => _ScreenItemViewState();
}
class _ScreenItemViewState extends State<ScreenItemView> {
  int currentDobt = 0;
  ValueNotifier<int> selectedDateIndex = ValueNotifier(0);
  ValueNotifier<int?> selectedTimeSlotIndex = ValueNotifier<int?>(null);
  List<Map<String, dynamic>> slots = [];
  @override
  void initState() {
    log(widget.turfmodel.turfId);
    log("==========");
    context.read<StarRatingBloc>().add(FetchAllReviewsEvent(
        ownerId: widget.turfmodel.ownerId, turfId: widget.turfmodel.turfId));
    context.read<ItemViewBloc>().add(CarouselDoubt(currentDobt: 0));
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
        height: double.infinity,
        //decoration: BoxDecoration(gradient: backGroundGradient),
        color: backGroundColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // carousal builder----------------
              CarouselSlideBuilderWidget(
                  widget: widget, screenWidth: screenWidth),
              SizedBox(
                height: 4,
              ),
              //carousal dobts.............
              CarouselDobtsBuilderWidget(widget: widget),
              FutureBuilder(
                future: getStarIds(widget.turfmodel.turfId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    //Loading-----
                    return CircularWidget(
                      top: 200,
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    bool? isFav = snapshot.data;
                    log(snapshot.data.toString());
                    return FutureBuilder(
                        future: fetchingTimeSlots(
                            turfmodel: widget.turfmodel, type: widget.type),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            //Loading-------
                            return CircularWidget(
                              top: 200,
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            Map<String, List<Map<String, dynamic>>> timeSlots =
                                snapshot.data ?? {};
                            List<String> dateKeys = timeSlots.keys.toList();

                            return SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //Turf details part widget(name,landmark,price and includes)------------------
                                  TurfDetailsPartWidget(
                                      widget: widget,
                                      timeSlots: timeSlots,
                                      isFav: isFav),
                                  //Booking date displaying-------------------------
                                  timeSlots.isEmpty
                                      ? Center(
                                          child: TextWidget(
                                              text:
                                                  "No time slotes available now!"),
                                        )
                                      : DateAndTimeSlotWidget(
                                          dateKeys: dateKeys,
                                          selectedDateIndex: selectedDateIndex,
                                          selectedTimeSlotIndex:
                                              selectedTimeSlotIndex,
                                          timeSlots: timeSlots,
                                        ),

                                  //Rating part field---------
                                  RatingFieldPartWidget(),
                                  //Location and Book now button------------------
                                  LocAndBookButtonWidget(widget: widget, screenWidth: screenWidth, selectedTimeSlotIndex: selectedTimeSlotIndex, dateKeys: dateKeys, selectedDateIndex: selectedDateIndex)
                                ],
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        });
                  } else {
                    return SizedBox();
                  }
                },
              )
            ],
          ),
        ),
      ),
      //floating action button
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: FloatingActionsWidget(widget: widget),
    );
  }
}

