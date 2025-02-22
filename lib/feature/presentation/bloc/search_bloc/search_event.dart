part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}
class SearchQueryEvent extends SearchEvent{
  final Map<String,String>searchQuery;
  SearchQueryEvent({required this.searchQuery});
}
class SearchResetEvent extends SearchEvent {}



//speach to text
class SpeechToTextInitial extends SearchEvent{
}
class SpeechToTextStartListerning extends SearchEvent{
}

//Filter---
class RangeValueEvent extends SearchEvent{
  RangeValues rangeValue;
  RangeValueEvent({required this.rangeValue});
}