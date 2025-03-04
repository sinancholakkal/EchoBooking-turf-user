import 'dart:developer';

import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/bloc/booking_bloc/booking_bloc.dart';
import 'package:echo_booking/feature/presentation/bloc/star_rating_bloc/star_rating_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/booking_turf_view/screen_booking_turf_view.dart';
import 'package:echo_booking/feature/presentation/pages/booking_turf_view/widget/show_dialoge_rating.dart';
import 'package:echo_booking/feature/presentation/widgets/animated_star_rating.dart';
import 'package:echo_booking/feature/presentation/widgets/circular_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StarRatingFieldWidget extends StatelessWidget {
  const StarRatingFieldWidget({
    super.key,
    required this.widget,
    required this.screenWidth,
    required TextEditingController feedbackController,
    required GlobalKey<FormState> formKey,
    required this.rating,
  }) : _feedbackController = feedbackController, _formKey = formKey;

  final ScreenBookingTurfView widget;
  final double screenWidth;
  final TextEditingController _feedbackController;
  final GlobalKey<FormState> _formKey;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible:
          (widget.turfmodel.status == "Closed") ? true : false,
      child: BlocListener<StarRatingBloc, StarRatingState>(
        listener: (context, state) {
          if (state is PostLoadedState) {
            context.read<StarRatingBloc>().add(FetchReviewEvent(
                turfId: widget.turfmodel.bookingId));
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
                            //Show dialog for rating--------------
                            showDialogRating(context: context,feedbackController: _feedbackController,formKey: _formKey,rating: rating,widget: widget,);
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
    );
  }
}
