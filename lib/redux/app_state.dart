import 'package:meta/meta.dart';


@immutable
class AppState {
  bool isOnline;

  AppState(this.isOnline);

  factory AppState.intialize() => AppState(false);

  AppState.copyWith(AppState another){
    this.isOnline = another.isOnline;
  }
}