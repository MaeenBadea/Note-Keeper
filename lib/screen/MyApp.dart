import 'package:flutter/material.dart';
import 'package:note_keeper/redux/app_state.dart';
import 'package:note_keeper/screen/scoped_model_wrapper.dart';
import 'package:scoped_model/scoped_model.dart';

import 'note_list.dart';
import 'package:note_keeper/redux/store.dart';
import 'package:note_keeper/screen/note_list.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:note_keeper/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return

      StoreProvider<AppState>(
          store: store,
          child:
          ScopedModelDescendant<AppModel>(
          builder: (context, child, model) => MaterialApp(
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
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: Colors.blue,
              primaryColorLight: Colors.white,

              // This makes the visual density adapt to the platform that you run
              // the app on. For desktop platforms, the controls will be smaller and
              // closer together (more dense) than on mobile platforms.
              visualDensity: VisualDensity.adaptivePlatformDensity,

            ),
            home: NoteList(),
          )
          )
      );
  }
}