part of 'star_bloc.dart';

@immutable
sealed class StarEvent {}

class AddTurfStarEvent extends StarEvent{
  TurfModel turfModel;
  Map<String, List<Map<String, dynamic>>> timeSlots;
  AddTurfStarEvent({required this.timeSlots,required this.turfModel});
}
class RemoveTurfStarEvent extends StarEvent{
  final String turfId;
  RemoveTurfStarEvent({required this.turfId});
}

class FetchStarTurfsEvent extends StarEvent{}