import 'package:note_keeper/actions/actions.dart';

import 'app_state.dart';

AppState reducer(AppState prevState,dynamic action){
  AppState newState = AppState.copyWith(prevState);
  if(action is setIsOnline){
    newState.isOnline = action.payload;
  }
  if(action is setIsArabic){
    newState.isArabic = action.payload;
  }
  return newState;
}