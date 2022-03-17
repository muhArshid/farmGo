import 'package:farmapp/controller/to_do_list.dart';
import 'package:farmapp/model/core/to_do_modal.dart';
import 'package:farmapp/service/FireBase/notification_service.dart';
import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:farmapp/utils/helper/date_format_helper.dart';
import 'package:farmapp/views/widgets/button_icons_widgets.dart';
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
  TextEditingController todoDateCtr = TextEditingController();
  bool showAdd = false;
  final _formKey = GlobalKey<FormState>();
  late DateTime pickedDate;
  Future<void> _selectDateTo(BuildContext context) async {
    DateTime chooseDate = DateTime.now();
    final today = DateTime.now();
    final oneDaysFromNow = today.add(const Duration(days: 1));
    pickedDate = (await showDatePicker(
      context: context,
      initialDate: oneDaysFromNow,
      firstDate: oneDaysFromNow,
      lastDate: DateTime(3000),
    ))!;
    print(pickedDate);
    // ignore: unnecessary_null_comparison
    if (pickedDate != null && pickedDate != chooseDate)
      setState(() {
        todoDateCtr.text = DateFormatHelper.formatYearMonthDayServer(
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
          label: ''.tr,
        ),
      ),
      Positioned(
          top: 60,
          left: 0,
          right: 10,
          bottom: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Container(
              child: ListView(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Add_Activites'.tr,
                      style: AppFontMain(
                        color: AppColorCode.headerColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          showAdd = !showAdd;
                        });
                      },
                      child: !showAdd
                          ? Icon(
                              Icons.add_box,
                              color: AppColorCode.brandColor,
                              size: 27,
                            )
                          : Text(
                              'Cancel'.tr,
                              style: AppFontMain(
                                color: AppColorCode.brandColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                    ),
                    const SizedBox(
                      width: 1,
                    ),
                  ],
                ),
                showAdd
                    ? Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            buildtextForm(
                              controller: contentTextEditorController,
                              label: 'Content'.tr,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Enter_Content'.tr;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: buildtextForm(
                                controller: todoDateCtr,
                                onTap: () {
                                  _selectDateTo(context);
                                },
                                label: 'Date'.tr,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Choose_Date'.tr;
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  final todoModel = TodoModel(
                                    todoDate: todoDateCtr.text,
                                    content:
                                        contentTextEditorController.text.trim(),
                                    isDone: false,

                                    //   createdOn: Timestamp.now(),
                                  );
                                  await FirestoreDb.addTodo(todoModel);
                                  contentTextEditorController.clear();
                                  todoDateCtr.clear();
                                  await NotificationService()
                                      .scheduleNotifications(
                                          pickedDate,
                                          "Today Activity",
                                          contentTextEditorController.text);
                                  setState(() {
                                    showAdd = false;
                                  });
                                }
                              },
                              child: Text(
                                'Add_Todo'.tr,
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                          ],
                        ),
                      )
                    : Container(
                        height: 80.h,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5.h,
                            ),
                            GetX<TodoController>(
                              init: Get.put<TodoController>(TodoController()),
                              builder: (TodoController todoController) {
                                if (todoController.todos == null) {
                                  return Text('Loading'.tr);
                                } else if (todoController.todos!.isEmpty) {
                                  return Text(
                                    'Empty_List'.tr,
                                    style: AppFontMain(
                                      color: AppColorCode.gray,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  );
                                } else
                                  return Expanded(
                                    child: ListView.builder(
                                      itemCount: todoController.todos!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        print(todoController
                                            .todos![index].content);
                                        final _todoModel =
                                            todoController.todos![index];
                                        return Container(
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 4,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.black26,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    Container(
                                                      height: 4.h,
                                                      width: 50.w,
                                                      child: Text(
                                                        _todoModel.content ??
                                                            ''.tr,
                                                        style: TextStyle(
                                                          fontSize: Get
                                                              .textTheme
                                                              .bodyText1!
                                                              .fontSize,
                                                          decoration:
                                                              _todoModel.isDone ??
                                                                      true
                                                                  ? TextDecoration
                                                                      .lineThrough
                                                                  : TextDecoration
                                                                      .none,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      _todoModel.todoDate ??
                                                          ''.tr,
                                                      style: TextStyle(
                                                        fontSize: Get
                                                            .textTheme
                                                            .headline6!
                                                            .fontSize,
                                                      ),
                                                    ),
                                                  ],
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
                                                    FirestoreDb.deleteTodo(
                                                        _todoModel.id!);
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
                          ],
                        ),
                      ),
              ]),
            ),
          ))
    ])));
  }
}
