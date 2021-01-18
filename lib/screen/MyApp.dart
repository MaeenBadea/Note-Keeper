import 'package:flutter/material.dart';
import 'package:note_keeper/actions/actions.dart';
import 'package:note_keeper/redux/app_state.dart';
import 'package:note_keeper/screen/scoped_model_wrapper.dart';
import 'package:note_keeper/utils/StorageUtils.dart';
import 'package:scoped_model/scoped_model.dart';

import 'note_list.dart';
import 'package:note_keeper/redux/store.dart';
import 'package:note_keeper/screen/note_list.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:note_keeper/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import'package:note_keeper/utils/config.dart';

import 'package:flutter_animated_theme/flutter_animated_theme.dart';


class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }

}
class MyAppState extends State<MyApp> {
  bool isArabic ;
  bool once = false;

  final defaultTheme  = ThemeData(

    primarySwatch: Colors.blue,
    primaryColorLight: Colors.white,


    visualDensity: VisualDensity.adaptivePlatformDensity,

  );
  final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    accentColor: Colors.greenAccent,
    bottomAppBarColor: Colors.greenAccent,
    hintColor: Colors.yellowAccent,
    textTheme: TextTheme(
      title: TextStyle(
        color: Colors.black,
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
  final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    accentColor: Colors.greenAccent,
    hintColor: Colors.deepOrangeAccent,
    bottomAppBarColor: Colors.grey,
    textTheme: TextTheme(
      title: TextStyle(
        color: Colors.white,
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );


  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      print("theme changed");
      setState(() { });
    });

  } // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return
      StoreProvider<AppState>(
          store: store,
          child:
          ScopedModelDescendant<AppModel>(
          builder: (context, child, model)
    {
      if(!once){
          isArabic = StorageUtil.getBool("isArabic");
          print("got isArabic: $isArabic");
          model.setLang(isArabic?"ar":"en");
          StoreProvider.of<AppState>(context).dispatch(new setIsArabic(isArabic));

          once = true;
      }
     return  AnimatedThemeApp(
        locale: model.appLocal,
        localizationsDelegates: [
          // 1
          S.delegate,
          // 2
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,

        debugShowCheckedModeBanner: false,
        themeMode: currentTheme.currentTheme(),
        theme: lightTheme,
        darkTheme: darkTheme,
        animationDuration: Duration(milliseconds: 600),

        animationType: AnimationType.CIRCULAR_ANIMATED_THEME,
        home: NoteList(),
      );
    }
          
          )
      );
  }
}
