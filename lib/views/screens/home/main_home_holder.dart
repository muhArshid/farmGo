import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmapp/constants.dart';
import 'package:farmapp/service/FireBase/notification_service.dart';
import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AssetConstants.dart';

import 'package:farmapp/views/screens/profile/profile.dart';
import 'package:farmapp/views/screens/profile/widgets/post_widget.dart';
import 'package:farmapp/views/screens/sevicese/home_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MainHomeHolder extends StatefulWidget {
  final int? currentIndex;
  MainHomeHolder({this.currentIndex, Key? key}) : super(key: key);

  @override
  _MainHomeHolderState createState() => _MainHomeHolderState();
}

class _MainHomeHolderState extends State<MainHomeHolder> {
  int currentIndex = 1;
  // MainController mainCt = Get.find();
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  void initState() {
    if (widget.currentIndex != null) {
      currentIndex = widget.currentIndex!;
    }
    super.initState();
    //give you the message on which user tag
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routerfromeMessege = message.data["route"];
        print(routerfromeMessege);
      }
    });
    //foreGround
    FirebaseMessaging.onMessage.listen((message) async {
      if (message.notification != null) {
        print(message.notification!.title);
        NotificationService.showNotifications(message);
      }
    });
    //Background open app page via nottification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routerfromeMessege = message.data["route"];
      Get.toNamed(routerfromeMessege);
      print(routerfromeMessege);
    });
  }

  Widget callpage(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return ProfileScreen();
      case 1:
        return HomeScreen();
      case 2:
        return PostWidgets();

      default:
        return PostWidgets();
    }
  }

  @override
  Widget build(BuildContext context) {
    void onTabTapped(int index) {
      setState(() {
        currentIndex = index;
      });
    }

    BottomNavigationBarItem bottomNavigationBarItem(
            {int? index, String? icon, String? label, String? activeIcon}) =>
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            icon!,
            color: currentIndex == index
                ? AppColorCode.primaryText
                : AppColorCode.butColor,
            height: 20,
          ),
          label: label,
          activeIcon: SvgPicture.asset(
            activeIcon!,
            color: currentIndex == index
                ? AppColorCode.primaryText
                : AppColorCode.butColor,
            height: 30,
          ),
        );

    DateTime? _lastQuitTime;
    return WillPopScope(
      onWillPop: () async {
        if (_lastQuitTime == null ||
            DateTime.now().difference(_lastQuitTime!).inSeconds > 2) {
          Fluttertoast.showToast(
              msg: 'Press again Back Button exit',
              backgroundColor: AppColorCode.brandColor);
          Get.back();
          _lastQuitTime = DateTime.now();
          return false;
        } else {
          print('Exited');
          Get.back(result: true);
          return true;
        }
      },
      child: Scaffold(
          backgroundColor: AppColorCode.backgroundColor,
          body: callpage(currentIndex),
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 1,
            height: 60.0,
            items: <Widget>[
              Icon(Icons.perm_identity, size: 30),
              Icon(Icons.home_outlined, size: 30),
              Icon(Icons.explore_outlined, size: 30),
            ],
            color: AppColorCode.brandColor,
            buttonBackgroundColor: AppColorCode.brandColor,
            backgroundColor: bgColor,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            letIndexChange: (index) => true,
          )),
    );
  }
}
