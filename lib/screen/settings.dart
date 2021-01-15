import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:note_keeper/actions/actions.dart';
import 'package:note_keeper/redux/app_state.dart';
import 'package:note_keeper/generated/l10n.dart';
import 'package:note_keeper/redux/store.dart';
import 'package:note_keeper/screen/scoped_model_wrapper.dart';
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
                  radius:53,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: CircleAvatar(
                    radius:50,
                    backgroundColor: Colors.blueGrey,
                    //backgroundImage: AssetImage('assets/images/.jpg'),
                  ),
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
                                    StoreProvider.of<AppState>(context).dispatch(setIsArabic(userVal));
                                    model.changeDirection();
                                  });

                            });
                          },

                        )
                          ,
                        ),

                      Padding(padding: EdgeInsets.only(top: 5,bottom: 5),),
                      ListTile(
                        title: Text(S.of(context).online, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black54, fontSize: 16),),
                        trailing: StoreConnector<AppState, AppState>(
                          converter: (store) => store.state,
                          builder: (context, state){
                            return Switch(
                              value: state.isOnline,
                              onChanged: (bool userVal){
                                StoreProvider.of<AppState>(context).dispatch(setIsOnline(userVal));
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

