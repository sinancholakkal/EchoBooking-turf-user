import 'dart:developer';

import 'package:echo_booking/core/constent/size/size.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/core/until/validation.dart';
import 'package:echo_booking/feature/presentation/bloc/booking_bloc/booking_bloc.dart';
import 'package:echo_booking/feature/presentation/bloc/item_view/item_view_bloc.dart';
import 'package:echo_booking/feature/presentation/bloc/star_rating_bloc/star_rating_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/screen_booking/widgets/booking_cardItem_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/widgets/carousel_dobts_builder.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/widgets/carousel_slider_builder_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/animated_star_rating.dart';
import 'package:echo_booking/feature/presentation/widgets/circular_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/detals_card_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

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
    context
        .read<StarRatingBloc>()
        .add(FetchReviewEvent(turfId: widget.turfmodel.turfId));
    _feedbackController = TextEditingController();
    details = [
      {'Name': widget.turfmodel.turfName},
      {'Date': widget.turfmodel.bookingDate},
      {'Time': widget.turfmodel.bookingTime},
      {'Category': widget.turfmodel.catogery},
      {'Landmark': widget.turfmodel.landmark},
      {'Includes': widget.turfmodel.includes},
      {'Price': "₹${widget.turfmodel.price}"},
      {'Payment': "Success"},
      {'Status': widget.turfmodel.status},
    ];
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
                    Visibility(
                      visible:
                          (widget.turfmodel.status == "Closed") ? true : false,
                      child: BlocListener<StarRatingBloc, StarRatingState>(
                        listener: (context, state) {
                          if (state is PostLoadedState) {
                            context.read<StarRatingBloc>().add(FetchReviewEvent(
                                turfId: widget.turfmodel.turfId));
                          }
                        },
                        child: BlocBuilder<StarRatingBloc, StarRatingState>(
                          builder: (context, state) {
                            if (state is FetchLoadingState) {
                              return CircularWidget();
                            } else if (state is ReviewFetchLoadedState) {
                              log("${state.review}");
                              return Container(
                                padding: const EdgeInsets.all(10),
                                width: screenWidth * .85,
                                // height: 100,
                                decoration: BoxDecoration(
                                  gradient: linearGradient,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      spacing: 10,
                                      children: [
                                        AnimatedStarRatingWidget(
                                          onChanged: (val) {},
                                          initial: double.parse(
                                              state.review['rating']),
                                          readOnly: true,
                                          starSize: 16,
                                        ),
                                        TextWidget(
                                          text: state.review['rating'],
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: TextWidget(
                                        text: state.review["command"],
                                        maxLine: 10,
                                        color: kGrey,
                                        size: 15,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                            return Container(
                              width: screenWidth * .85,
                              height: 70,
                              decoration: BoxDecoration(
                                gradient: linearGradient,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextWidget(text: "Rating"),
                                      IconButton(
                                          onPressed: () {
                                            //context.read<StarRatingBloc>().add(ShowStarRating(context: context));
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 14, 11, 59),
                                                  title: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          SizedBox(),
                                                          TextWidget(
                                                              text: "RATING"),
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                rating = 1;
                                                                _feedbackController
                                                                    .clear();
                                                              },
                                                              child: Text(
                                                                "Skip",
                                                                style: TextStyle(
                                                                    color:
                                                                        kWhite),
                                                              ))
                                                        ],
                                                      ),
                                                      AnimatedStarRatingWidget(
                                                        initial: 1,
                                                        onChanged: (value) {
                                                          rating = value;
                                                        },
                                                      ),
                                                      height10,
                                                      Form(
                                                        key: _formKey,
                                                        child: TextFormField(
                                                          validator: (value) {
                                                            return Validation
                                                                .nameValidate(
                                                                    value:
                                                                        value,
                                                                    comment:
                                                                        "Feedback");
                                                          },
                                                          controller:
                                                              _feedbackController,
                                                          maxLines: 4,
                                                          style: TextStyle(
                                                              color: kWhite),
                                                          decoration: InputDecoration(
                                                              label: Text(
                                                                  "Feedback"),
                                                              border:
                                                                  OutlineInputBorder()),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  //Submit button--------------
                                                  actions: [
                                                    OutlinedButton(
                                                        onPressed: () {
                                                          if (_formKey
                                                              .currentState!
                                                              .validate()) {
                                                            print(
                                                                " Validated--------------------");
                                                            Get.back();
                                                            context
                                                                .read<
                                                                    StarRatingBloc>()
                                                                .add(
                                                                    PostStarRatingEvent(
                                                                  userName: widget
                                                                      .turfmodel
                                                                      .userName,
                                                                  rating: rating
                                                                      .toString(),
                                                                  command:
                                                                      _feedbackController
                                                                          .text,
                                                                  ownerId: widget
                                                                      .turfmodel
                                                                      .ownerId,
                                                                  turfId: widget
                                                                      .turfmodel
                                                                      .turfId,
                                                                ));
                                                            rating = 1;
                                                            _feedbackController
                                                                .clear();
                                                          } else {
                                                            print(
                                                                "Not Validated--------------------");
                                                          }
                                                        },
                                                        child: Text("Submit"))
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          icon: Icon(
                                            Icons.star_border,
                                            size: 40,
                                            color: Colors.amber,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
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
                    ),
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
