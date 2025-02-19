part of 'star_bloc.dart';

@immutable
sealed class StarState {}

final class StarInitial extends StarState {}

class StarFetchingLoadingState extends StarState{}

class StarFetchingLoadedState extends StarState{
  final List<TurfModel> starTurfs;
  StarFetchingLoadedState(this.starTurfs);
}
class StarEmptyState extends StarState{}
