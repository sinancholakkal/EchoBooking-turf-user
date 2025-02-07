part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class UserStoreEvent extends UserEvent{
  final UserModel user;
  UserStoreEvent({required this.user});

}
class UserDataFetchingEvent extends UserEvent{}

class UserDataUpdateEvent extends UserEvent{
  UserModel userModel;
  UserDataUpdateEvent({required this.userModel});
}
