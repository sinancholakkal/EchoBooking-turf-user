import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:echo_booking/domain/model/turf_model.dart';
import 'package:echo_booking/domain/repository/search_services.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchServices searchServices = SearchServices();
  
  stt.SpeechToText _speech = stt.SpeechToText();
  SearchBloc() : super(SearchInitial()) {
    on<SearchQueryEvent>((event, emit)async{
      emit(SearchLoadingState());
      try{
        final List<TurfModel> turfmodels = await searchServices.searching(event.searchQuery);
        for(var turf in turfmodels){
          log(turf.turfName);
        }
        emit(SearchLoadedState(searchTurfs: turfmodels));
        log("Search loaded");
      }catch(e){
        log("Somthing happening while searching $e");
        
      }
    });
    on<SearchResetEvent>((event, emit) {
      emit(SearchInitial());
    });

    on<SpeechToTextInitial>((event, emit)async {
      await _speech.initialize();
    });
    on<SpeechToTextStartListerning>((event, emit)async {
      emit(SpeachLoadingState());
      String? text;
      await _speech.listen(
      onResult: (result){
        
         text = result.recognizedWords;
         
      
      });
      await Future.delayed(Duration(seconds: 6));
      log(text.toString());
       if(text !=null){
        emit(SpeechLoadedState(text: text!));
       }
    },);
    //Filter--------
     on<RangeValueEvent>((event, emit)async {
      emit(RangeValueLoadedState(rangeValue: event.rangeValue));
    });
  }
}
