import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmapp/constants.dart';
import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/controller/to_do_list.dart';
import 'package:farmapp/model/core/to_do_modal.dart';
import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:farmapp/utils/helper/date_format_helper.dart';
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
  final _formKey = GlobalKey<FormState>();
  late DateTime pickedDate;
  Future<void> _selectDateTo(BuildContext context) async {
    DateTime chooseDate = DateTime.now();

    pickedDate = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ))!;
    print(pickedDate);
    // ignore: unnecessary_null_comparison
    if (pickedDate != null && pickedDate != chooseDate)
      setState(() {
        serviceController.dob.text = DateFormatHelper.formatYearMonthDayServer(
            pickedDate.toIso8601String());
      });
  }

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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                ' Add Todo',
                style: AppFontMain(
                  color: AppColorCode.headerColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              buildtextForm(
                controller: contentTextEditorController,
                label: 'Content',
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Enter Content';
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: buildtextForm(
                  controller: serviceController.dob,
                  onTap: () {
                    _selectDateTo(context);
                  },
                  label: 'Date Of Birth',
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Choose Date ';
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 10,
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
                                      FirestoreDb.updateStatus(
                                        status!,
                                        _todoModel.id,
                                      );
                                    },
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      FirestoreDb.deleteTodo(_todoModel.id!);
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
            ]),
          ))
    ])));
  }
}
