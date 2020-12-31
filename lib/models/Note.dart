import 'dart:convert';

class Note{
  int _id;
  String _title;
  String _description;
  int _priority;
  String _date;

  Note(this._title , this._date,this._priority,  [this._description]);
  Note.withId(this._id ,this._title , this._priority, this._date, [this._description]);

  int get id => _id;

  String get title => _title;
  set title(String value) {
    _title = value;
  }


  String get description => _description;
  set description(String value) {
    _description = value;
  }

  int get priority => _priority;
  set priority(int value) {
    if(value==1 || value ==2){
      _priority = value;
    }
  }

  String get date => _date;
  set date(String value) {
    _date = value;
  }

  Map<String , dynamic> toMap(){
    var map = Map<String , dynamic>();

    if(_id!=null){
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;
    return map;
  }
  Note.fromMapObj(Map<String, dynamic> map){
    this._id = map['id'];
    this._title = map['title'];
    this._description= map['description'];
    this._priority = map['priority'];
    this._date= map['date'];
  }
  Note.fromJson(Map<String, dynamic> json){
    if(json ==null) return ;
    this._id = json['id'];
    this._title = json['title'];
    this._description= json['description'];
    this._priority = json['priority'];
    this._date= json['date'];
  }

  static String toJson(Note note){
    Map<String, dynamic> n = {
      "id": note.id,
      "title": note.title,
      "description": note.description,
      "priority": note.priority,
      "date": note.date
    };
    return json.encode(n);
  }
  static List<Note> parseList(List<dynamic> json){
    return json.map((item) => Note.fromJson(item)).toList();
  }
  toString(){
    return "id: "+this._id.toString() + ","
        "title: "+this._title +","
        "description: "+ this._description+ ","
        "priority: "+ this._priority.toString() + ","
        "date: "+ this._date;
  }
}
