import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'app_reducer.dart';
import 'app_state.dart';

final _intialState = AppState(false, false);
Store<AppState> store = Store<AppState>(reducer, initialState: _intialState);