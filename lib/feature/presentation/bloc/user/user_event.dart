part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class UserStoreEvent extends UserEvent{
  final UserModel user;
  UserStoreEvent({required this.user});
}
