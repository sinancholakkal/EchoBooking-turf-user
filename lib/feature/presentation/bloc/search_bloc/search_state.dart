part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState{}

class SearchLoadedState extends SearchState{
  final List<TurfModel>searchTurfs;
  SearchLoadedState({required this.searchTurfs});
}

//speech to search
class SpeachLoadingState extends SearchState{}
class SpeechLoadedState extends SearchState{
  final String text;
  SpeechLoadedState({required this.text});
}

//Filter state--
class RangeValueLoadedState extends SearchState{
  RangeValues rangeValue;
  RangeValueLoadedState({required this.rangeValue});
}
class DatePickerSuccessState extends SearchState{
  String date;
  DatePickerSuccessState({required this.date});
}
class TimePickerSuccessState extends SearchState{
  String pickDate;
  TimePickerSuccessState({required this.pickDate});
}