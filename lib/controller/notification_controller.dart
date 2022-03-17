import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmapp/constants/firebase.dart';
import 'package:farmapp/model/core/notification_modal.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class NotificationController extends GetxController {
  Rxn<List<NotificationModel>> notiList = Rxn<List<NotificationModel>>([]);
  List<NotificationModel>? get data => notiList.value;
  @override
  void onReady() {
    notiList.bindStream(NotiDB.notificationStream());
  }
}

class NotiDB {
  static addNotification(NotificationModel model) async {
    String id = Uuid().v1();
    await firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('notifications')
        .doc(id)
        .set({
      'id': id,
      'mainTittle': model.mainTittle,
      'subTittle': model.subTittle,
      'todoDate': model.notificationDate,
      'createdon': Timestamp.now(),
      'isDone': false,
    });
  }

  static Stream<List<NotificationModel>> notificationStream() {
    return firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('notifications')
        .snapshots()
        .map((QuerySnapshot querysnapshot) {
      List<NotificationModel> _todoData = [];
      querysnapshot.docs.forEach((element) {
        print(element.data());
        _todoData.add(
            NotificationModel.fromMap(element.data() as Map<String, dynamic>));
      });
      return _todoData;
      //
    });
  }
}
