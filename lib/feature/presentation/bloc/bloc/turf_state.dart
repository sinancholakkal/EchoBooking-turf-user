part of 'turf_bloc.dart';

@immutable
sealed class TurfState {}

final class TurfInitial extends TurfState {}

class TurfFetchLoadingState extends TurfState{}

class TurfFetchLoadedState extends TurfState{
  List<List<TurfModel>> turfModels;
  TurfFetchLoadedState({required this.turfModels});
}