// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmapp/constants/firebase.dart';
import 'package:farmapp/model/core/to_do_modal.dart';
import 'package:farmapp/utils/helper/date_format_helper.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class TodoController extends GetxController {
  Rxn<List<TodoModel>> todoList = Rxn<List<TodoModel>>([]);
  Rxn<List<TodoModel>> todayList = Rxn<List<TodoModel>>([]);
  List<TodoModel>? get todos => todoList.value;
  List<TodoModel>? get todays => todayList.value;

  @override
  void onReady() {
    todoList.bindStream(FirestoreDb.todoStream());
    todayList.bindStream(FirestoreDb.todayListStream());
  }
}

class FirestoreDb {
  static addTodo(TodoModel todomodel) async {
    String id = Uuid().v1();
    await firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('todos')
        .doc(id)
        .set({
      'id': id,
      'content': todomodel.content,
      'todoDate': todomodel.todoDate,
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
      List<TodoModel> _todoData = [];
      querysnapshot.docs.forEach((element) {
        print(element.data());
        _todoData
            .add(TodoModel.fromMap(element.data() as Map<String, dynamic>));
      });
      print('Total message fetched: ${_todoData.length}');
      return _todoData;
      //
    });
  }

  static Stream<List<TodoModel>> todayListStream() {
    final DateTime now = DateTime.now();
    String today = DateFormatHelper.formatYearMonthDayServer(now.toString());
    return firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('todos')
        .where("todoDate", isEqualTo: today)
        .snapshots()
        .map((QuerySnapshot querysnapshot) {
      List<TodoModel> _todoData = [];
      querysnapshot.docs.forEach((element) {
        print(element.data());
        _todoData
            .add(TodoModel.fromMap(element.data() as Map<String, dynamic>));
      });
      print('Total message fetched: ${_todoData.length}');
      return _todoData;
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
