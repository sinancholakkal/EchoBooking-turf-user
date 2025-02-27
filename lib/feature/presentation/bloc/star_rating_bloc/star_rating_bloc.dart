import 'dart:developer';

import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:bloc/bloc.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/widgets/animated_star_rating.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'star_rating_event.dart';
part 'star_rating_state.dart';

class StarRatingBloc extends Bloc<StarRatingEvent, StarRatingState> {
  StarRatingBloc() : super(StarRatingInitial()) {
    on<ShowStarRating>((event, emit)async {
    // await showDialog(
    //     context: event.context,
    //     builder: (context) {
    //       return AlertDialog(
    //         backgroundColor: const Color.fromARGB(255, 14, 11, 59),
    //         title: Column(
    //           children: [
    //             Row(
    //               children: [
    //                 Spacer(),
    //                 TextWidget(text: "RATING"),
    //                 Spacer(),
    //                 TextButton(onPressed: (){
    //                   Navigator.of(context).pop();
    //                 }, child: Text("Skip",style: TextStyle(color: kWhite),))
    //               ],
    //             ),
    //             AnimatedStarRatingWidget(onChanged: (rating){
    //               log(rating.toString());
    //             },),
                
    //           ],
    //         ),
    //       );
    //     },
    //   );
    });
  }
}

