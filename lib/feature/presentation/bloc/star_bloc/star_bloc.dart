import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:echo_booking/domain/model/turf_model.dart';
import 'package:echo_booking/domain/repository/turf_service.dart';
import 'package:meta/meta.dart';

part 'star_event.dart';
part 'star_state.dart';

class StarBloc extends Bloc<StarEvent, StarState> {
  StarBloc() : super(StarInitial()) {
    on<AddTurfStarEvent>((event, emit)async {
      await TurfService().starAddTurf(event.turfModel, event.timeSlots);

    });
    on<RemoveTurfStarEvent>((event, emit)async {
      await TurfService().deleteTurfFromStar(event.turfId);
       final List<TurfModel>starTurfs = await TurfService().fetchTurfStars();
       log("eeeeeeeeeeeeeeeeee");
      log("${starTurfs.length} ================");
      
      if(starTurfs.isEmpty){
        emit(StarEmptyState());
      }else{
        emit(StarFetchingLoadedState(starTurfs));
      }
    });

    on<FetchStarTurfsEvent>((event, emit)async {
      emit(StarFetchingLoadingState());
      log("fetchStare calling");
      final List<TurfModel>starTurfs = await TurfService().fetchTurfStars();
      log("${starTurfs.length} ================");
      log("fetchStare called");
      if(starTurfs.isEmpty){
        emit(StarEmptyState());
      }else{
        emit(StarFetchingLoadedState(starTurfs));
      }
    });
  }
}
