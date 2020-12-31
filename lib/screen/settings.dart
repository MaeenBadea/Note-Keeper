import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:note_keeper/actions/actions.dart';
import 'package:note_keeper/redux/app_state.dart';


class Settings extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
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
                    backgroundImage: AssetImage('assets/images/lu.jpg'),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 12,bottom: 4, top: 20),
                child: Text("settings"),
              ),
              Center(
                child: Card(
                  child: ListTile(
                    title: Text("online", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black54, fontSize: 16),),
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
                )
              )
            ],
          )
        ),
      ),

    );
  }


}

