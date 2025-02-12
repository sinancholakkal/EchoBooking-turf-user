part of 'item_view_bloc.dart';

@immutable
sealed class ItemViewState {}

final class ItemViewInitial extends ItemViewState {}

class CarouselDoubtChangedState extends ItemViewState{
  int currentDoubt;
  CarouselDoubtChangedState({required this.currentDoubt});
}
