import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:echo_booking/domain/model/user_model.dart';
import 'package:echo_booking/domain/repository/auth_service.dart';
import 'package:echo_booking/feature/presentation/widgets/showDiolog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final _authService = AuthService();
  AuthBlocBloc() : super(AuthBlocInitial()) {
    on<CheckLoginStatusEvent>(
      (event, emit) async {
        bool? result;
        try {
          await Future.delayed(Duration(milliseconds: 2200), () {
            result = _authService.checkLoginStatus();
          });

          if (result == true) {
            emit(AuthSuccessState());
          } else {
            emit(AuthUnSuccessState());
          }
        } catch (e) {
          log("error $e");
        }
      },
    );
    on<SignUpEvent>(
      (event, emit) async {
        emit(AuthLoadingState());
        await Future.delayed(Duration(seconds: 2));
        try {
          final user = await _authService.createUserWithEmailAndPassword(
              event.email, event.password, event.context);
          emit(AuthSuccessState(user: user));
        } on FirebaseAuthException catch (e) {
          log("Somthing wrong while Sign Up ${e.code}");
          emit(AuthErrorState(errorMessage: e.code));
        }
      },
    );

    on<SignInEvent>(
      (event, emit) async {
        emit(AuthLoadingState());
        await Future.delayed(Duration(seconds: 2));
        try {
          final user = await _authService.signInUserWithEmailAndPassword(
              event.email, event.password, event.context);
          emit(AuthSuccessState(user: user));
        } on FirebaseAuthException catch (e) {
          log("Somthing wrong while SignIn ${e.code}");
          emit(AuthErrorState(errorMessage: e.code));
        }
      },
    );

    on<SignInWithGoogle>(
      (event, emit) async {
        emit(AuthLoadingState());
        await Future.delayed(Duration(seconds: 2));
        try {
          final user = await _authService.signInWithGoogle();
          log(user!.user!.uid);
          
          emit(AuthSuccessState(user: user));
        } on FirebaseAuthException catch (e) {
          log("Somthing wrong while SignIn ${e.code}");
          emit(AuthErrorState(errorMessage: e.code));
        }
      },
    );

    on<SignOutEvent>(
      (event, emit) async {
        emit(AuthLoadingState());
        await Future.delayed(Duration(milliseconds: 1000));
        try {
          _authService.signOut();
          emit(AuthSuccessState());
        } catch (e) {
          log("Somthing wrong during signout $e");
          emit(AuthErrorState(errorMessage: e.toString()));
        }
      },
    );

    on<ForgotpasswordEvent>((event, emit) {
      try{
        AuthService().forgotPassword(event.email);
      }on FirebaseAuthException catch(e){
        log("forgot issue ${e.code}");
      }
    },);
  }
}
