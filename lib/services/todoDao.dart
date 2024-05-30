import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

import '../models/todo.dart';

class TodoDao{
  final _databaseRef = FirebaseDatabase.instance.ref("toods");

  void saveTodo (Todo todo){
    _databaseRef.push().set(todo.toJson());
  }

  Query getMessageQuery(){
    if(!kIsWeb){
      FirebaseDatabase.instance.setPersistenceEnabled(true);
    }
    return _databaseRef;
  }

  void deleteTodo(String key){
    _databaseRef.child(key).remove();
  }

  void upadateTodo(String key, Todo todo){
    _databaseRef.child(key).update(todo.toMap());
  }

}