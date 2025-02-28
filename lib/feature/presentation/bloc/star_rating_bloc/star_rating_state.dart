part of 'star_rating_bloc.dart';

@immutable
sealed class StarRatingState {}

final class StarRatingInitial extends StarRatingState {}
class PostLoadingState extends StarRatingState{}
class PostLoadedState extends StarRatingState{}
class ReviewFetchLoadedState extends StarRatingState{
  Map<String,dynamic>review;
  ReviewFetchLoadedState({required this.review});
}
class FetchAllReviewsLoadingState extends StarRatingState{}
class FetchAllReviewsLoadedState extends StarRatingState{
  final Map<String,dynamic> reviews;
  FetchAllReviewsLoadedState({required this.reviews});
}