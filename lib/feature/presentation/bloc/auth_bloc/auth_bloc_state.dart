part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocState {}

class AuthBlocInitial extends AuthBlocState {}

class AuthLoadingState extends AuthBlocState {}

// class AuthLoginedState extends AuthBlocState {}

// class AuthUnLoginedState extends AuthBlocState {}

class AuthErrorState extends AuthBlocState {
  final String errorMessage;
  AuthErrorState({required this.errorMessage});
}

class AuthSuccessState extends AuthBlocState {
  final user;
  AuthSuccessState({this.user});
}
class AuthUnSuccessState extends AuthBlocState {}
