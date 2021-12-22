// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmapp/constants.dart';
import 'package:farmapp/model/core/to_do_modal.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  Rxn<List<TodoModel>> todoList = Rxn<List<TodoModel>>([]);
  List<TodoModel>? get todos => todoList.value;

  @override
  void onReady() {
    todoList.bindStream(FirestoreDb.todoStream());
  }
}

class FirestoreDb {
  static addTodo(TodoModel todomodel) async {
    await firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('todos')
        .add({
      'content': todomodel.content,
      'createdon': Timestamp.now(),
      'isDone': false,
    });
  }

  static Stream<List<TodoModel>> todoStream() {
    return firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('todos')
        .snapshots()
        .map((QuerySnapshot querysnapshot) {
      List<TodoModel> todos = [];
      List<TodoModel> todoData = <TodoModel>[];
      querysnapshot.docs.forEach((element) {
        print(element.data());
        todoData.add(TodoModel.fromSnapshot(element));
      });
      print('Total message fetched: ${todoData.length}');
      return todoData;
      //
    });
  }

  static updateStatus(bool isDone, documentId) {
    firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('todos')
        .doc(documentId)
        .update(
      {
        'isDone': isDone,
      },
    );
  }

  static deleteTodo(String documentId) {
    firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('todos')
        .doc(documentId)
        .delete();
  }
}
