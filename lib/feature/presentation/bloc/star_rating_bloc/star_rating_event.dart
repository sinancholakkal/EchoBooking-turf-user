part of 'star_rating_bloc.dart';

@immutable
sealed class StarRatingEvent {}
class ShowStarRating extends StarRatingEvent{
  final BuildContext context;
  ShowStarRating({required this.context});
}