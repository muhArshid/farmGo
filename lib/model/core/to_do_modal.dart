import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  static const ID = "id";
  static const CON = "content";
  static const ISDONE = "isDone";
  static const CEON = "createdOn";
  String? id;
  String? content;
  Timestamp? createdOn;
  bool? isDone;

  TodoModel({
    this.id,
    this.content,
    this.isDone,
    this.createdOn,
  });

  TodoModel.fromMap(Map<String, dynamic> data) {
    id = data[ID];
    content = data[CON];
    createdOn = data[CEON];
    isDone = data[ISDONE];
  }

  Map toJson() => {ID: id, CON: content, CEON: createdOn, ISDONE: isDone};
}
