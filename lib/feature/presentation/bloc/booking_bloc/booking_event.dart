part of 'booking_bloc.dart';

@immutable
sealed class BookingEvent {}
class FetchBookingTurfEvent extends BookingEvent{}