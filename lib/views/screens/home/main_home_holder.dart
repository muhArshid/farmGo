import 'package:farmapp/constants.dart';
import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AssetConstants.dart';
import 'package:farmapp/views/screens/home/explore.dart';
import 'package:farmapp/views/screens/commen_screen.dart';
import 'package:farmapp/views/screens/home/profile.dart';
import 'package:farmapp/views/screens/sevicese/home_screen.dart';
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
  int currentIndex = 0;
  // MainController mainCt = Get.find();
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  void initState() {
    if (widget.currentIndex != null) {
      currentIndex = widget.currentIndex!;
    }
    super.initState();
  }

  Widget callpage(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return ProfileScreen();
      case 1:
        return HomeScreen();
      case 2:
        return ExploreScreen();

      default:
        return TextSrceen();
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
            index: 0,
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
