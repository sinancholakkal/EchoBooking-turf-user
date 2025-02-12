part of 'item_view_bloc.dart';

@immutable
sealed class ItemViewEvent {}
class CarouselDoubt extends ItemViewEvent{
  int currentDobt;
  CarouselDoubt({required this.currentDobt});
}
