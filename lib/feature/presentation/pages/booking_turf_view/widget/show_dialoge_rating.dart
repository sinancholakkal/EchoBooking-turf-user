import 'package:echo_booking/core/constent/size/size.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/core/until/validation.dart';
import 'package:echo_booking/feature/presentation/bloc/star_rating_bloc/star_rating_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/booking_turf_view/screen_booking_turf_view.dart';
import 'package:echo_booking/feature/presentation/widgets/animated_star_rating.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

Future<dynamic> showDialogRating({
  required BuildContext context,
  required double rating,
  required TextEditingController feedbackController,
  required GlobalKey<FormState>formKey,
  required ScreenBookingTurfView widget,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 14, 11, 59),
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                TextWidget(text: "RATING"),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      rating = 1;
                      feedbackController.clear();
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(color: kWhite),
                    ))
              ],
            ),
            //Animated rating widget after closed------
            AnimatedStarRatingWidget(
              initial: 1,
              onChanged: (value) {
                rating = value;
              },
            ),
            height10,
            Form(
              key: formKey,
              child: TextFormField(
                validator: (value) {
                  return Validation.nameValidate(
                      value: value, comment: "Feedback");
                },
                controller: feedbackController,
                maxLines: 4,
                style: TextStyle(color: kWhite),
                decoration: InputDecoration(
                    label: Text("Feedback"), border: OutlineInputBorder()),
              ),
            )
          ],
        ),
        //Submit button--------------
        actions: [
          OutlinedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  print(" Validated--------------------");
                  Get.back();
                  context.read<StarRatingBloc>().add(PostStarRatingEvent(
                        userName: widget.turfmodel.userName,
                        rating: rating.toString(),
                        command: feedbackController.text,
                        ownerId: widget.turfmodel.ownerId,
                        turfId: widget.turfmodel.turfId,
                      ));
                  rating = 1;
                  feedbackController.clear();
                } else {
                  print("Not Validated--------------------");
                }
              },
              child: Text("Submit"))
        ],
      );
    },
  );
}
