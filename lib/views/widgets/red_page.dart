import 'dart:io';

import 'package:farmapp/controller/notification_controller.dart';
import 'package:farmapp/model/core/notification_modal.dart';
import 'package:farmapp/service/FireBase/demo.dart';
import 'package:farmapp/service/FireBase/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final TextEditingController _textController = TextEditingController();
  final CollectionReference _tokensDB =
      FirebaseFirestore.instance.collection('Tokens');
  final FCMNotificationService _fcmNotificationService =
      FCMNotificationService();

  late String _otherDeviceToken;
  DateTime? selectdate;
  @override
  void initState() {
    super.initState();

    //Subscribe to the NEWS topic.
    _fcmNotificationService.subscribeToTopic(topic: 'NEWS');

    load();
  }

  Future<void> load() async {
    //Request permission from user.
    if (Platform.isIOS) {
      _fcm.requestPermission();
    }

    //Fetch the fcm token for this device.
    String? token = await _fcm.getToken();

    //Validate that it's not null.
    assert(token != null);

    //Determine what device we are on.
    late String thisDevice;
    late String otherDevice;

    if (Platform.isIOS) {
      thisDevice = 'iOS';
      otherDevice = 'Android';
    } else {
      thisDevice = 'Android';
      otherDevice = 'Android';
    }

    //Update fcm token for this device in firebase.
    DocumentReference docRef = _tokensDB.doc(thisDevice);
    docRef.set({'token': token});

    //Fetch the fcm token for the other device.
    DocumentSnapshot docSnapshot = await _tokensDB.doc(otherDevice).get();
    _otherDeviceToken = docSnapshot['token'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: _textController,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.send),
                  label: Text('Send Notification'),
                  onPressed: () async {
                    try {
                      await _fcmNotificationService.sendNotificationToUser(
                        title: 'New Notification!',
                        body: _textController.text,
                        fcmToken: _otherDeviceToken,
                      );
                      print(_otherDeviceToken);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Notification sent.'),
                        ),
                      );
                      final notModel = NotificationModel(
                        mainTittle: 'New Notification',
                        subTittle: _textController.text,
                        isDone: false,

                        //   createdOn: Timestamp.now(),
                      );
                      await NotiDB.addNotification(notModel);
                      _textController.clear();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error, ${e.toString()}.'),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            TextButton(
                onPressed: () {
                  DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime: DateTime.now().add(Duration(days: 365)),
                      onChanged: (date) {
                    print('change $date');
                  }, onConfirm: (date) {
                    print('confirm $date');
                    setState(() {
                      selectdate = date;
                    });
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                child: Text(
                  'show date time picker',
                  style: TextStyle(color: Colors.blue),
                )),
            if (selectdate != null)
              Text(
                selectdate.toString(),
                style: TextStyle(color: Colors.blue),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.send),
                  label: Text('Time based Send Notification'),
                  onPressed: () async {
                    try {
                      // await _fcmNotificationService.sendNotificationToUser(
                      //   title: 'New Notification!',
                      //   body: _textController.text,
                      //   fcmToken: _otherDeviceToken,
                      // );
                      //  print(_otherDeviceToken);
                      await NotificationService().scheduleNotifications(
                          selectdate!, "Time check", _textController.text);
                      //   _fcmNotificationService.scheduleNotifications();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Notification sent.'),
                        ),
                      );
                      final notModel = NotificationModel(
                        mainTittle: 'New Notification',
                        subTittle: _textController.text,
                        isDone: false,

                        //   createdOn: Timestamp.now(),
                      );
                      await NotiDB.addNotification(notModel);
                      _textController.clear();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error, ${e.toString()}.'),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
