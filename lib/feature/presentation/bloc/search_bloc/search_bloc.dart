import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:echo_booking/domain/model/turf_model.dart';
import 'package:echo_booking/domain/repository/search_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchServices searchServices = SearchServices();

  stt.SpeechToText _speech = stt.SpeechToText();
  SearchBloc() : super(SearchInitial()) {
    on<SearchQueryEvent>((event, emit) async {
      emit(SearchLoadingState());
      try {
        final List<TurfModel> turfmodels =
            await searchServices.searching(event.searchQuery);
        for (var turf in turfmodels) {
          log(turf.turfName);
        }
        emit(SearchLoadedState(searchTurfs: turfmodels));
        log("Search loaded");
      } catch (e) {
        log("Somthing happening while searching $e");
      }
    });
    on<SearchResetEvent>((event, emit) {
      emit(SearchInitial());
    });

    on<SpeechToTextInitial>((event, emit) async {
      await _speech.initialize();
    });
    on<SpeechToTextStartListerning>(
      (event, emit) async {
        emit(SpeachLoadingState());
        String? text;
        await _speech.listen(onResult: (result) {
          text = result.recognizedWords;
        });
        await Future.delayed(Duration(seconds: 6));
        log(text.toString());
        if (text != null) {
          emit(SpeechLoadedState(text: text!));
        }
      },
    );
    //Filter--------
    on<RangeValueEvent>((event, emit) async {
      emit(RangeValueLoadedState(rangeValue: event.rangeValue));
    });
    //Date picker for filter
    on<DatePickerEvent>((event, emit) async {
      final DateTime? pickedDate = await showDatePicker(
        context: event.context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year, DateTime.now().month, 1),
        lastDate: DateTime(2100),
      );
      if (pickedDate != null) {
        String newDateKey = DateFormat("yyyy-MM-dd").format(pickedDate);
        emit(DatePickerSuccessState(date: newDateKey));
      }
    });
    on<TimePickerEvent>((event, emit) async {
      final TimeOfDay now = TimeOfDay.now();
      final TimeOfDay initialTime = TimeOfDay(hour: now.hour, minute: 00);
      final TimeOfDay? timeOfDay = await showTimePicker(
        context: event.context,
        initialEntryMode: TimePickerEntryMode.input,
        initialTime: initialTime,
      );
      if (timeOfDay != null) {
        log("${timeOfDay.hour} ${timeOfDay.minute}");
        int hour = timeOfDay.hour;
        int minute = timeOfDay.minute;

        String period = hour >= 12 ? "PM" : "AM";
        int hour12 = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);

        String formattedHour = hour12 < 10 ? "0$hour12" : "$hour12";
        String formattedMinute = minute < 10 ? "0$minute" : "$minute";

        String formattedTime = "$formattedHour:$formattedMinute $period";
        log(formattedTime);
        emit(TimePickerSuccessState(pickDate: formattedTime));
      }
    });
  }
}
