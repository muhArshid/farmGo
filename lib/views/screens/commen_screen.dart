import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:farmapp/views/Dashboard/dashboard_screen.dart';
import 'package:farmapp/views/Dashboard/main/main_screen.dart';
import 'package:farmapp/views/screens/Home/main_home_holder.dart';
import 'package:farmapp/views/widgets/button_icons_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class TextSrceen extends StatefulWidget {
  const TextSrceen({Key? key}) : super(key: key);

  @override
  _TextSrceenState createState() => _TextSrceenState();
}

class _TextSrceenState extends State<TextSrceen> {
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
          label: 'myapp',
        ),
      ),
      Positioned(
          top: 75,
          left: 0,
          right: 10,
          bottom: 0,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 3.h),
                child: Column(
                  children: [
                    Text(
                      'Heading details',
                      style: AppFontMain(
                        color: AppColorCode.headerColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Heading details',
                      style: AppFontMain(
                        color: AppColorCode.headerColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Heading details',
                      style: AppFontMain(
                        color: AppColorCode.headerColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Heading details',
                      style: AppFontMain(
                        color: AppColorCode.headerColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      child: buildtextForm(
                        label: 'Email',
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Enter Email ID';
                          }
                          if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val)) {
                            return 'Enter a Valid Email';
                          }
                          return null;
                        },
                      ),
                    ),
                    Divider(),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColorCode.pureWhite,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: 30.w, //It will take a 20% of screen width
                      height: 20.h, //It will take a 30% of screen height
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 1.h, horizontal: 1.h),
                        child: Column(
                          children: [
                            Text(
                              'Heading details',
                              style: AppFontMain(
                                color: AppColorCode.headerColor,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              ' details',
                              style: AppFontMain(
                                color: AppColorCode.headerColor,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              ' details',
                              style: AppFontMain(
                                color: AppColorCode.headerColor,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              ' details',
                              style: AppFontMain(
                                color: AppColorCode.headerColor,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              ' details',
                              style: AppFontMain(
                                color: AppColorCode.headerColor,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    button(
                      width: 20.w, //It will take a 20% of screen width
                      height: 5.h, //It will take a 30% of screen height
                      onTap: () {
                        Get.to(() => MainScreen());
                      },
                      label: 'HOME',
                    ),
                  ],
                ),
              )
            ],
          )),
      Container()
    ])));
  }
}
