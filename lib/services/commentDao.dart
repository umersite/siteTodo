import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

import '../models/comment.dart';

class CommentDao{
  final _databaseRef = FirebaseDatabase.instance.ref("comment");

  void saveComment (Comment comment){
    _databaseRef.push().set(comment.toJson());
  }

  Query getMessageQuery(){
    if(!kIsWeb){
      FirebaseDatabase.instance.setPersistenceEnabled(true);
    }
    return _databaseRef;
  }

  void deleteComment(String key){
    _databaseRef.child(key).remove();
  }

  void upadateComment(String key, Comment comment){
    _databaseRef.child(key).update(comment.toMap());
  }

}