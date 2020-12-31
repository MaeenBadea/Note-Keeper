import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';
import 'package:note_keeper/models/Note.dart';

class ApiHelper{

  static ApiHelper _apiHelper;

  factory ApiHelper(){
    if(_apiHelper==null){
      _apiHelper = new ApiHelper();
    }
    return _apiHelper;
  }

  insertNote(Note note){

  }
  updateNote(Note note){

  }

  getNotesList(){

  }



}