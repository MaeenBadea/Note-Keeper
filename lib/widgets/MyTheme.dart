import 'package:flutter/material.dart';
import 'package:note_keeper/utils/StorageUtils.dart';

class MyTheme with ChangeNotifier{
  static bool _dark = false;

  static bool get dark => _dark;
  MyTheme(){
    _dark = StorageUtil.getBool("isDark")??false;
  }
  ThemeMode currentTheme(){
    return _dark?ThemeMode.dark:ThemeMode.light;
  }

  void switchTheme(){
    _dark = ! _dark;
    StorageUtil.putBool("isDark", _dark);
    notifyListeners();
  }

}