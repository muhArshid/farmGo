// ignore_for_file: must_be_immutable

import 'package:farmapp/controller/MenuController.dart';
import 'package:farmapp/responsive.dart';
import 'package:farmapp/views/Dashboard/dashboard_screen.dart';
import 'package:farmapp/views/Dashboard/main/compodent/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  MenuController menuCtrp = Get.put(MenuController());
  MenuController menuCtr = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: menuCtr.scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: DashboradScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
