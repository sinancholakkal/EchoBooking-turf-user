import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:echo_booking/domain/model/booking_turf_model.dart';
import 'package:echo_booking/domain/repository/turf_service.dart';
import 'package:meta/meta.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitial()) {
    on<FetchBookingTurfEvent>((event, emit) async{
      emit(FetchLoadingState());
      try{
        List<BookingTurfmodel> turfs = await TurfService().fetchBookings();
        emit(FetchLoadedState(bookingTurfModels: turfs));
      }catch(e){
        log("Something wrong while fetch bookings $e");
      }
    });
  }
}
