part of 'booking_bloc.dart';

@immutable
sealed class BookingState {}

final class BookingInitial extends BookingState {}

class FetchLoadingState extends BookingState{}

class FetchLoadedState extends BookingState{
  final List<BookingTurfmodel>bookingTurfModels;
  FetchLoadedState({required this.bookingTurfModels});
}