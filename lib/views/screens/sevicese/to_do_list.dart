import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmapp/constants.dart';
import 'package:farmapp/controller/to_do_list.dart';
import 'package:farmapp/model/core/to_do_modal.dart';
import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:farmapp/views/widgets/button_icons_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({Key? key}) : super(key: key);

  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  TextEditingController contentTextEditorController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Stack(children: [
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: appBar(
          label: '',
        ),
      ),
      Positioned(
          top: 60,
          left: 0,
          right: 10,
          bottom: 0,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Members',
                style: AppFontMain(
                  color: AppColorCode.headerColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            TextField(
              controller: contentTextEditorController,
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                final todoModel = TodoModel(
                  content: contentTextEditorController.text.trim(),
                  isDone: false,
                  //   createdOn: Timestamp.now(),
                );
                await FirestoreDb.addTodo(todoModel);
                contentTextEditorController.clear();
              },
              child: const Text(
                "Add Todo",
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            GetX<TodoController>(
              init: Get.put<TodoController>(TodoController()),
              builder: (TodoController todoController) {
                if (todoController.todos == null) {
                  return Text('Loading');
                } else if (todoController.todos!.isEmpty) {
                  return Text('Empty List');
                } else
                  return Expanded(
                    child: ListView.builder(
                      itemCount: todoController.todos!.length,
                      itemBuilder: (BuildContext context, int index) {
                        print(todoController.todos![index].content);
                        final _todoModel = todoController.todos![index];
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _todoModel.content ?? '',
                                    style: TextStyle(
                                      fontSize:
                                          Get.textTheme.headline6!.fontSize,
                                      decoration: _todoModel.isDone ?? true
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                    ),
                                  ),
                                ),
                                Checkbox(
                                  value: _todoModel.isDone,
                                  onChanged: (status) {
                                    // FirestoreDb.updateStatus(
                                    //   status!,
                                    //   _todoModel.documentId,
                                    // );
                                  },
                                ),
                                IconButton(
                                  onPressed: () {
                                    // FirestoreDb.deleteTodo(
                                    //     _todoModel.documentId!);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: StreamBuilder<QuerySnapshot>(
                  stream: firebaseFirestore
                      .collection('users')
                      .doc(auth.currentUser!.uid)
                      .collection('todos')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, i) {
                            QueryDocumentSnapshot x = snapshot.data!.docs[i];
                            return Row(children: [
                              Expanded(
                                child: Text(
                                  x['content'],
                                  style: TextStyle(
                                    fontSize: Get.textTheme.headline6!.fontSize,
                                    decoration: x['isDone']
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                              ),
                              Checkbox(
                                value: x['isDone'],
                                onChanged: (status) async {
                                  await FirestoreDb.updateStatus(
                                    status!,
                                    x['documentId'],
                                  );
                                },
                              ),
                              IconButton(
                                onPressed: () async {
                                  await FirestoreDb.deleteTodo(
                                      x['documentId']!);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ]);
                          });
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            )
          ]))
    ])));
  }
}
