part of 'item_view_bloc.dart';

@immutable
sealed class ItemViewEvent {}
class CarouselDoubt extends ItemViewEvent{
  int currentDobt;
  CarouselDoubt({required this.currentDobt});
}
class GoogleMapLauncherEvent extends ItemViewEvent{
  String position;
  GoogleMapLauncherEvent({required this.position});
}
class CallLauncherEvent extends ItemViewEvent{
  String phone;
  CallLauncherEvent({required this.phone});
}

class WhatsAppLauncher extends ItemViewEvent{
  String phone;
  WhatsAppLauncher({required this.phone});
}