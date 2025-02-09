import 'package:flutter/foundation.dart';

class Note {
  int? id;
  String body;

  Note({this.id, required this.body});

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id:map['id'] as int?,  
      body:map['body'] as String,
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'id':id,  
      'body':body,
    };
  }
}
