import 'package:flutter/material.dart';
import 'package:note_keeper/screen/MyApp.dart';
import 'package:scoped_model/scoped_model.dart';

class ScopeModelWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(model: AppModel(), child: MyApp());
  }
}

class AppModel extends Model {
  Locale _appLocale = Locale('en');
  Locale get appLocal => _appLocale ?? Locale("en");

  void changeDirection() {
    if (_appLocale == Locale("ar")) {
      _appLocale = Locale("en");
      print("localllllllllllllllll "+_appLocale.toString());
    } else {
      _appLocale = Locale("ar");
      print("localllllllllllllllll "+_appLocale.toString());

    }
    notifyListeners();
  }
}