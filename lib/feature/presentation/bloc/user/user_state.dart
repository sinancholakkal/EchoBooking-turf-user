part of 'user_bloc.dart';

@immutable
sealed class UserState {}

 class UserInitial extends UserState {}

class UserLoadingState extends UserState{}

class UserLoadedState extends UserState{
  UserModel? user;
  UserLoadedState({this.user});
}
class UserDataUpdating extends UserState{}
class UserDataUpdated extends UserState{}