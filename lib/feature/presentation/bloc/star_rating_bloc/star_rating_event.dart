part of 'star_rating_bloc.dart';

@immutable
sealed class StarRatingEvent {}
class PostStarRatingEvent extends StarRatingEvent{
  final String userName;
  final String rating;
  final String command;
  final String ownerId;
  final String turfId;
  PostStarRatingEvent({required this.userName, required this.rating,required this.command,required this.ownerId,required this.turfId});
}
class FetchReviewEvent extends StarRatingEvent{
   final String turfId;
   FetchReviewEvent({required this.turfId});
}
class FetchAllReviewsEvent extends StarRatingEvent{
  final String ownerId;
  final String turfId;
  FetchAllReviewsEvent({required this.ownerId,required this.turfId});
}