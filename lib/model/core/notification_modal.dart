import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  static const ID = "id";
  static const MAIN = "mainTittle";
  static const SUB = "subTittle";
  static const ISDONE = "isDone";
  static const CEON = "createdOn";
  static const DATE = "notificationDate";
  String? id;
  String? mainTittle;
  String? subTittle;

  String? notificationDate;
  Timestamp? createdOn;
  bool? isDone;

  NotificationModel({
    this.id,
    this.mainTittle,
    this.subTittle,
    this.isDone,
    this.createdOn,
    this.notificationDate,
  });

  NotificationModel.fromMap(Map<String, dynamic> data) {
    id = data[ID];
    mainTittle = data[MAIN];
    subTittle = data[SUB];

    createdOn = data[CEON];
    isDone = data[ISDONE];
    notificationDate = data[DATE];
  }

  Map toJson() => {
        ID: id,
        SUB: subTittle,
        MAIN: mainTittle,
        CEON: createdOn,
        ISDONE: isDone,
        DATE: notificationDate
      };
}
