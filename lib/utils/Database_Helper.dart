import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:note_keeper/models/Note.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper{
  static DatabaseHelper _databaseHelper;
  static Database _database;


  String noteTable = "note_table";
  String colId ="id";
  String colTitle = "title";
  String colDescrip = "description";
  String colDate = "date";
  String colPriority = "priority";

  DatabaseHelper._createInstance();
  factory DatabaseHelper(){
    if(_databaseHelper==null){
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }
  Future<Database> _intitalizeDatabase() async{
    print("llllllllllllllllllllmm");
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "notes.db";

    var noteDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return noteDatabase;
  }
  Future<Database> get database async{
    if(_database ==null){
      _database = await _intitalizeDatabase();
    }
    return _database;
  }

  Future<int> insertNote(Note note) async{
    Database db = await this.database;
    var result = db.insert(noteTable, note.toMap());
    return result;
  }
  Future<int> updateNote(Note note) async{
    Database db = await this.database;
    var result = db.update(noteTable, note.toMap(), where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }
  Future<int> deleteNote(Note note) async{
    Database db = await this.database;
    var result = db.delete(noteTable, where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }
  Future<List<Map<String , dynamic>>> getNoteMapList () async{
    Database db =await this.database;
    var result = db.query(noteTable, orderBy: '$colPriority ASC');
    return result;
  }


  Future<int> getCount(Note) async{
    Database db = await this.database;
    List<Map<String,dynamic>> x =await db.rawQuery("SELECT COUNT(*) FROM $noteTable");
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Note>> getNoteList () async{
    List<Note> noteList = List<Note>();
    var noteMapList = await getNoteMapList();
    int mapListLen = noteMapList.length;
    
    for(int i = 0; i<mapListLen ; i++){
      noteList.add(Note.fromMapObj(noteMapList[i]));
    }
    return noteList;
  }
  void _createDb(Database db, int newVersion) async {
    print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");

    await db.execute('CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
        '$colDescrip TEXT, $colPriority INTEGER, $colDate TEXT)');
  }

}