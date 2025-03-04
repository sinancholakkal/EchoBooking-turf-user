import 'dart:developer';

import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:bloc/bloc.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/domain/repository/star_rating_service.dart';
import 'package:echo_booking/feature/presentation/bloc/user/user_bloc.dart';
import 'package:echo_booking/feature/presentation/widgets/animated_star_rating.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'star_rating_event.dart';
part 'star_rating_state.dart';

class StarRatingBloc extends Bloc<StarRatingEvent, StarRatingState> {
  StarRatingBloc() : super(StarRatingInitial()) {
    on<PostStarRatingEvent>((event, emit)async {
      emit(PostLoadingState());
      try{
        log("Rating event called");
        await StarRatingService().postStarRating(rating: event.rating, command: event.command, ownerId: event.ownerId, turfId: event.turfId, userName: event.userName,bookingId: event.bookingId);
        emit(PostLoadedState());
      }catch(e){
        log("Somthing happen while posting rating");
      }
    });
     on<FetchReviewEvent>((event, emit)async {
      emit(PostLoadingState());
      try{
        Map<String,dynamic>review = await StarRatingService().fetchReview(turfId: event.turfId);
        log(review.toString());

        emit(ReviewFetchLoadedState(review: review));
      }catch(e){
        log("Somthing happen while fetch single review $e");
      }
    });
    on<FetchAllReviewsEvent>((event, emit)async {
      emit(FetchAllReviewsLoadingState());
      try{
       Map<String,dynamic>reviews = await StarRatingService().fetchAllReviews(ownerId: event.ownerId, turfId: event.turfId);
       emit(FetchAllReviewsLoadedState(reviews: reviews));
      }catch(e){
        log("Somthing happen while Fetching all reviews $e");
      }
    });
  }
}

