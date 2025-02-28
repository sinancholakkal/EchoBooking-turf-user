import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:echo_booking/domain/model/turf_model.dart';
import 'package:echo_booking/domain/model/user_model.dart';
import 'package:echo_booking/domain/repository/payment_service.dart';
import 'package:meta/meta.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    on<PaymentSuccessEvent>((event, emit)async {
      emit(PaymentSuccessLoadingState());
      try{
        await PaymentService().disableTimeSlot(turfmodel: event.turfModel, datekey: event.dateKey, bookedTime: event.bookedTime);
        await PaymentService().addBookingTurf(turfModel: event.turfModel,date: event.dateKey,paymentId: event.paymentId,time: event.bookedTime,userName:event.userModel.name);
        await PaymentService().updateInOwner(date: event.dateKey,paymentId: event.paymentId, time: event.bookedTime,turfModel: event.turfModel,userModel: event.userModel);
        emit(PaymentSuccessState());
      }catch (e){
        log("Somthing wrong while update time availablity after booking $e");
      }
    });
  }
}
