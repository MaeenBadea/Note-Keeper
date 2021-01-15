import 'package:meta/meta.dart';


@immutable
class AppState {
  bool isOnline;
  bool isArabic;

  AppState(this.isOnline ,this.isArabic);

  factory AppState.intialize() => AppState(false,false);

  AppState.copyWith(AppState another){
    this.isOnline = another.isOnline;
    this.isArabic = another.isArabic;

  }
}