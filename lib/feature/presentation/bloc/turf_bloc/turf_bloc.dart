import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:echo_booking/domain/model/turf_model.dart';
import 'package:echo_booking/domain/repository/turf_service.dart';
import 'package:meta/meta.dart';

part 'turf_event.dart';
part 'turf_state.dart';

class TurfBloc extends Bloc<TurfEvent, TurfState> {
  final TurfService turfService = TurfService();
  TurfBloc() : super(TurfInitial()) {
    on<TurfFetchEvent>((event, emit) async{
      log("turf bloc called");
      emit(TurfFetchLoadingState());
      try{
        List<List<TurfModel>> turfModels = await turfService.fetchAllTurfs();
        if(turfModels[0].isEmpty){
          emit(TurfEmptyState());
        }else{
          emit(TurfFetchLoadedState(turfModels: turfModels));
        }
        
      }catch(e){
        log("somthing wrong while fetching all turfs $e ===================");
      }
    });
  }
}
