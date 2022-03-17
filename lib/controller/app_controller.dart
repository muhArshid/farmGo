import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppController extends GetxController {
  static AppController instance = Get.find();
  late String fcmToken;
  String? language;
  String? langId;

  void setlangId(String lan) async {
    print('setting langId');
    final prefs = await SharedPreferences.getInstance();
    final storeData = jsonEncode({'langId': lan});
    prefs.setString('langId', storeData);
    update();
  }

  void getLang() async {
    final prefs = await SharedPreferences.getInstance();
    final extractedUserData =
        json.decode(prefs.getString('langId') ?? '') as Map<String, dynamic>;
    setlangId(extractedUserData['langId'].toString());

    update();
  }

  void updatelang(int langId) {
    switch (langId) {
      case (0):
        Get.updateLocale(Locale('en', 'US'));
        setlangId(langId.toString());
        language = "English";
        update();

        break;
      case (1):
        Get.updateLocale(Locale('mal', 'IN'));
        setlangId(langId.toString());

        language = "Malayalam";
        update();

        break;
      case (2):
        Get.updateLocale(Locale('hi', 'IN'));
        setlangId(langId.toString());

        language = "Hindi";
        update();
        break;
    }
  }

  List languageList = [
    'English'.tr,
    'മലയാളം',
    'हिन्दी',
  ];
  RxBool isLoginWidgetDisplayed = true.obs;

  changeDIsplayedAuthWidget() {
    isLoginWidgetDisplayed.value = !isLoginWidgetDisplayed.value;
  }

////////Connectivity
  //StreamSubscription<ConnectivityResult> connectivitySubscription;

  // setUpConnectivity() {
  //   connectivitySubscription = Connectivity()
  //       .onConnectivityChanged
  //       .listen((ConnectivityResult result) {
  //     if (result == ConnectivityResult.none) {
  //       EasyLoading.showInfo('No Internet');
  //     }
  //   });
  // }

  // disposeConnectivity() {
  //   connectivitySubscription.cancel();
  // }

//////////Notification
  // setNotificationToken() async {
  //   fcmToken = await FirebaseMessaging.instance.getToken();
  // }

  // configureNotification() async {
  //   await setNotificationToken();
  //   print(fcmToken);
  //   FirebaseMessaging.instance
  //       .getInitialMessage()
  //       .then((RemoteMessage message) {
  //     if (message != null) {
  //       print(message);
  //     }
  //   });
  // }

}
