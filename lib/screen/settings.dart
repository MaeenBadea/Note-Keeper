import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:note_keeper/actions/actions.dart';
import 'package:note_keeper/redux/app_state.dart';
import 'package:note_keeper/generated/l10n.dart';
import 'package:note_keeper/screen/scoped_model_wrapper.dart';
import 'package:note_keeper/utils/StorageUtils.dart';
import 'package:note_keeper/utils/config.dart';
import 'package:note_keeper/widgets/MyTheme.dart';
import 'package:scoped_model/scoped_model.dart';


class Settings extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings),

      ),

      body: Container(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius:60,
                    backgroundImage: AssetImage('assets/images/flutter_icon.png'),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 12,bottom: 4, top: 20),
                child: Text(S.of(context).settings),
              ),
              Center(
                child: Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(S.of(context).arabic, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black54, fontSize: 16),),
                        trailing: StoreConnector<AppState,AppState>(
                          converter: (store)=>store.state,
                          builder: (context,state){
                            return ScopedModelDescendant<AppModel>(builder: (context, child,model, ){
                              return Switch(
                                  value: state.isArabic,
                                  onChanged: (bool userVal){

                                    StoreProvider.of<AppState>(context).dispatch(new setIsArabic(userVal));
                                    StorageUtil.putBool("isArabic", userVal);
                                    model.changeDirection();
                                  });

                            });
                          },

                        )
                          ,
                        ),

                      Padding(padding: EdgeInsets.only(top: 5,bottom: 5),),
                      //
                      ListTile(
                        title: Text(S.of(context).dark, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black54, fontSize: 16),),
                        trailing: StoreConnector<AppState,AppState>(
                          converter: (store)=>store.state,
                          builder: (context,state){
                              return Switch(
                                  value: MyTheme.dark,
                                  onChanged: (bool userVal){
                                    print("chaning dark state : "+userVal.toString());
                                    currentTheme.switchTheme();
                                    //StoreProvider.of<AppState>(context).dispatch(new setIsDark(userVal));
                                  });
                          },

                        )
                        ,
                      ),

                      Padding(padding: EdgeInsets.only(top: 5,bottom: 5),),
                      //
                      ListTile(
                        title: Text(S.of(context).online, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black54, fontSize: 16),),
                        trailing: StoreConnector<AppState, AppState>(
                          converter: (store) => store.state,
                          builder: (context, state){
                            return Switch(
                              value: false,//state.isOnline,
                              onChanged: (bool userVal){
                                StoreProvider.of<AppState>(context).dispatch(setIsOnline(userVal));
                                final SnackBar snackBar = SnackBar(content: Text("Next Version!"));
                                Scaffold.of(context).showSnackBar(snackBar);
                              },

                            );
                          },
                        ),
                      ),
                    ],
                  )
                )
              )
            ],
          )
        ),
      ),

    );
  }


}

