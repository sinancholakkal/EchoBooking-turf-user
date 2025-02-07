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
        await Future.delayed(Duration(milliseconds: 1500),);
        await userService.userStore(event.user);
        emit(UserLoadedState());
      }catch(e){
        log("somthing wrong during store User $e");
      }
    });
    on<UserDataFetchingEvent>((event, emit) async{
      try{
        emit(UserLoadingState());
        //await Future.delayed(Duration(seconds: 1),);
        UserModel? user =await userService.userDataFetching();
        log("event called in bloc");
        
          log(user.gender);
          emit(UserLoadedState(user: user));
        
        
      }catch(e){
        log("somthing wrong during fetch User $e");
      }
    });

    on<UserDataUpdateEvent>((event, emit) async{
      try{
         emit(UserDataUpdating());
       //  emit(UserLoadingState());
        await userService.userDataUpdate(event.userModel);
        final updatedUser = await userService.userDataFetching();
        emit(UserLoadedState(user: updatedUser));
        
      }catch(e){
        log("somthing wrong during update User $e");
      }
    });
  }
}
