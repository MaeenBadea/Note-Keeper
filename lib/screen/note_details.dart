import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_keeper/models/Note.dart';
import 'package:note_keeper/redux/store.dart';
import 'package:note_keeper/utils/Database_Helper.dart';
import 'package:note_keeper/generated/l10n.dart';

class NoteDetails extends StatefulWidget{
  final String barTitle;
  Note note;

  NoteDetails(this.note, this.barTitle);

  @override
  State<StatefulWidget> createState() {
    return NoteDetailsState(this.note , this.barTitle);
  }
}

enum Pr  {HiGH , LOW}
class NoteDetailsState extends State<NoteDetails>{
  var _priorities  = [ Pr.HiGH,Pr.LOW,  ];
  String bTitle="";


  DatabaseHelper helper = DatabaseHelper();
  Note note;

  NoteDetailsState(Note nt , title){
    bTitle = title;
    note = nt;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    titleController.text  = note.title;
    descriptionController.text = note.description;



    return
      WillPopScope(
        onWillPop: (){
          returnToPreviousScreen();
        },
          child:
          Scaffold(
          appBar: AppBar(
            title: Text(bTitle),

          ),
          body: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 15),
            child: ListView(
              children: [
                Text(S.of(context).priority),
                ListTile(
                    title: DropdownButton<Pr>(

                    value: updatePrIntToEnum(note.priority),
                    style: textStyle,
                    items: Pr.values.map((Pr pr){
                      print('value lllllllllllll'+pr.toString());
                      return DropdownMenuItem<Pr>(child: Text(prToString(pr)) , value: pr);
                    }).toList(),
                    onChanged: (userVal){
                      //print("got "+ userVal);
                      setState(() {
                          updatePriorityAsInt(userVal);
                      });
                    },
                  )
                ),
                //Second Element
                Padding(
                  padding: EdgeInsets.only(top:15, bottom: 15),
                  child: TextField(
                    controller: titleController,
                    style: textStyle,
                    onChanged: (val){
                      print('val from textfiled'+val);
                      note.title = titleController.text;
                    },
                    decoration: InputDecoration(
                      labelText: S.of(context).title,
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)
                      )
                    ),
                  ),
                ),
                //Third Element
                Padding(
                  padding: EdgeInsets.only(top:15, bottom: 15),
                  child: TextField(
                    controller: descriptionController,
                    style: textStyle,
                    onChanged: (val){
                      print('val from textfiled'+val);
                      note.description = descriptionController.text;
                    },
                    decoration: InputDecoration(
                        labelText: S.of(context).descrip,
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)
                        )
                    ),
                  ),
                ),
                //Fourth element
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: RaisedButton(

                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          color: Theme.of(context).primaryColorDark,
                          child: Text(
                            S.of(context).delete,
                            textScaleFactor: 1.5,
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: (){
                            debugPrint('delete button pressed');
                            _delete();
                          },
                      )
                      ),
                      Padding(padding: EdgeInsets.only(left: 6, right: 6) ),
                      Expanded(

                          child: RaisedButton(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            color: Theme.of(context).primaryColorDark,
                            child: Text(
                              S.of(context).save,
                              textScaleFactor: 1.5,
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: (){
                              debugPrint('save button pressed');
                              _save();
                            },
                          )
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

    ));
  }
  returnToPreviousScreen(){
    Navigator.pop(context , true);
  }
  updatePriorityAsInt(Pr val){
    switch(val){
      case Pr.HiGH:
        note.priority=1;
        break;
      case Pr.LOW:
        note.priority =2;
        break;
    }
  }
  String prToString(Pr pr){
    switch(pr){
      case Pr.HiGH:
        return S.of(context).high;
        break;
      case Pr.LOW:
        return S.of(context).low;
        break;
    }
  }
  Pr updatePrIntToEnum(int val){
    Pr pr;
    switch(val){
      case 1:
        pr = Pr.HiGH;
        break;
      case 2:
        pr = Pr.LOW;
        break;
    }
    return pr;
  }
  void _save() async{
    int result;
    note.date = DateFormat.yMMMMd().format(DateTime.now());
    returnToPreviousScreen();

    if(store.state.isOnline){

    }else{

    }

    if(note.id!=null){//update
      result = await helper.updateNote(note);
    }else{
      result = await helper.insertNote(note);
    }
    if(result!=0){
        showAlertDialog("Status", "Note saved successfully.");
    }else{
      showAlertDialog("Status", "failed saving note.");

    }
  }
  void _delete() async{
    returnToPreviousScreen();

    if(this.note.id ==null){
      showAlertDialog("Status", "Nothing was deleted");
      return ;
    }

    if(store.state.isOnline){

    }else{

    }
    int result = await helper.deleteNote(note);
    if(result != 0){
      showAlertDialog("Status", "note deleted successfully");
    }else{
      showAlertDialog("Status", "failed deleting note");
    }
  }
  void showAlertDialog(String title , String message){
    showDialog(context: context, builder: (_)=> AlertDialog(title: Text(title),content: Text(message)) );
  }

}
