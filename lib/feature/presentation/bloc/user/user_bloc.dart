import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:echo_booking/domain/model/user_model.dart';
import 'package:echo_booking/domain/repository/user_service.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService userService = UserService();
  UserBloc() : super(UserInitial()) {
    on<UserStoreEvent>((event, emit) async{
      try{
        emit(UserLoadingState());
        await Future.delayed(Duration(seconds: 2),);
        await userService.userStore(event.user);
        emit(UserLoadedState());
      }catch(e){
        log("somthing wrong during store User $e");
      }
    });
  }
}
