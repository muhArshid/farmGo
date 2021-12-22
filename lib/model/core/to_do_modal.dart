import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? content;
  Timestamp? createdOn;
  bool? isDone;

  TodoModel({
    this.content,
    this.isDone,
    this.createdOn,
  });

  TodoModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    content = documentSnapshot["content"];
    createdOn = documentSnapshot["createdOn"];
    isDone = documentSnapshot["isDone"];
  }
}
