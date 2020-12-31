import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_keeper/models/Note.dart';
import 'package:note_keeper/redux/store.dart';
import 'package:note_keeper/utils/Database_Helper.dart';

class NoteDetails extends StatefulWidget{
  final String barTitle;
  Note note;

  NoteDetails(this.note, this.barTitle);

  @override
  State<StatefulWidget> createState() {
    return NoteDetailsState(this.note , this.barTitle);
  }
}

class NoteDetailsState extends State<NoteDetails>{
  var _priorities  = [ "High","Low",  ];
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
                Text("Priority"),
                ListTile(
                    title: DropdownButton(

                    value: updatePriorityToString(note.priority),
                    style: textStyle,
                    items: _priorities.map((String pr){
                      return DropdownMenuItem(child: Text(pr,) , value: (pr),);
                    }).toList(),
                    onChanged: (userVal){
                      print("got "+ userVal);
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
                      labelText: "Title",
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
                        labelText: "Description",
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
                            "Delete",
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
                              "Save",
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
  updatePriorityAsInt(String val){
    switch(val){
      case 'High':
        note.priority=1;
        break;
      case 'Low':
        note.priority =2;
        break;
    }
  }
  String updatePriorityToString(int val){
    String pr;
    switch(val){
      case 1:
        pr = _priorities[0];
        break;
      case 2:
        pr = _priorities[1];
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
