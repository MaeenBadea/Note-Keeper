import 'package:flutter/material.dart';
import 'package:note_keeper/models/Note.dart';
import 'package:note_keeper/redux/store.dart';
import 'package:note_keeper/screen/note_details.dart';
import 'package:note_keeper/screen/settings.dart';
import 'package:note_keeper/utils/Database_Helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:note_keeper/generated/l10n.dart';

class NoteList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return NoteListState();
  }
}

class NoteListState extends State<NoteList>{
  int count = 0;
  List<Note> noteList ;
  DatabaseHelper databaseHelper = DatabaseHelper();


  @override
  Widget build(BuildContext context) {
    if(noteList==null){
      noteList = List<Note>();
      updateNoteList();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).app_title),
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context){ return Settings();}));
            },
            child: Padding(
              padding: EdgeInsetsDirectional.only(end: 10),
              child: Icon(Icons.settings),
            ),
          )
        ],
      ),
      body: getNotesList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          navigateToDetails(Note('', '', 2),S.of(context).add_note);
        },
        tooltip: "Add note",

      ),
    );
  }

  ListView getNotesList(){
    TextStyle textStyle = Theme.of(context).textTheme.subhead;

    ListView lv = ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context , int index){
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: getNotePriorityColor(this.noteList[index].priority),
                child: getNotePriorityIcon(this.noteList[index].priority),
              ),
              title: Text(this.noteList[index].title, style: textStyle,),
              subtitle: Text(this.noteList[index].date),
              trailing: GestureDetector(
                child: Icon(Icons.delete, color: Colors.teal,),
                onTap: (){
                  _deleteNote(context, this.noteList[index]);
                },
              ),
              onTap: (){
                  navigateToDetails(this.noteList[index], S.of(context).edit_note);
              },
            ),
          );
        }
    );
    return lv;
  }
  void _deleteNote(BuildContext context , Note note) async{
      int result  = await databaseHelper.deleteNote(note);
      if(store.state.isOnline){

      }else{

      }
      if(result!=0){
        _showSnackBar(context,"Note deleted successfully");
        updateNoteList();
      }
  }
  Color getNotePriorityColor(int prio){
    switch(prio){
      case 1:
        return Colors.deepOrange;
      case 2:
        return Colors.lightGreenAccent;
      default:
        return Colors.lightGreenAccent;
    }
  }
  Icon getNotePriorityIcon(int prio){
    switch(prio){
      case 1:
        return Icon(Icons.keyboard_arrow_up);
      case 2:
        return Icon(Icons.keyboard_arrow_down);
      default:
        return Icon(Icons.keyboard_arrow_down);
    }
  }
  void navigateToDetails(Note note,String pageTitle) async{
    bool result = await Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return NoteDetails(note, pageTitle);
    }) ) ;
    if(result==true) updateNoteList();
  }
  updateNoteList() async{
      List<Note> offlineNotes = await databaseHelper.getNoteList();
      // get list from internet4
      List<Note> onlineNotes = await databaseHelper.getNoteList();

      if(store.state.isOnline){
        setState(() {
          this.noteList = onlineNotes;
          this.count = onlineNotes.length;
        });
      }else{
        setState(() {
          this.noteList = offlineNotes;
          this.count = offlineNotes.length;
        });
      }
  }
  _showSnackBar(BuildContext context,String str){
    final SnackBar snackBar = SnackBar(content: Text(str));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}