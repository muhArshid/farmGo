import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/controller/app_controller.dart';
import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:farmapp/utils/AssetConstants.dart';
import 'package:farmapp/utils/helper/StyleConfig.dart';
import 'package:farmapp/views/screens/auth/login_screen.dart';
import 'package:farmapp/views/screens/home/main_home_holder.dart';
import 'package:farmapp/views/widgets/button_icons_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int? langId;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      // Get.offAll(() => TextSrceen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: AppColorCode.bgColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 100,
            child: Container(
              width: size.width,
              height: size.height,
              decoration: new BoxDecoration(
                //   color: AppColorCode.brandColor,
                image: new DecorationImage(
                    fit: BoxFit.fill,
                    // colorFilter: ColorFilter.mode(
                    //     Colors.black.withOpacity(0.1), BlendMode.dstATop),
                    image: new AssetImage(
                      AssetConstant.bgImage,
                    )),
              ),
            ),
          ),
          Positioned(
              top: 400,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [AppColorCode.grey1, AppColorCode.gray2],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(0.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.decal),
                    // color: AppColorCode.brandColor,
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(
                          color: AppColorCode.gray2,
                          blurRadius: 45.0,
                          spreadRadius: 25.0,
                          offset: Offset(0.0, 1.75)),
                    ]),
                child: GetBuilder<AppController>(builder: (ct) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset(AssetConstant.bgImage),
                      SizedBox(height: 14),
                      Text(
                        'WELCOME'.tr,
                        style: AppFontMain(
                          color: AppColorCode.black,
                          fontSize: 33,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        AssetConstant.appName,
                        style: AppFontMain(
                          color: AppColorCode.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            //
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),

                            boxShadow: [StyleConfig.boxShadow()],
                          ),
                          child: Center(
                            child: InputDecorator(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 4),
                                // labelText: widget.title,
                                border: InputBorder.none,
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: AppColorCode.buttunColorLate,
                                  ),
                                  hint: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.language_rounded,
                                        color: AppColorCode.brandColor,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      ct.language == null
                                          ? Text('Language'.tr,
                                              style: AppFontMain(
                                                  color: AppColorCode.darkGrey,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15))
                                          : Text(
                                              ct.language!,
                                              style: AppFontMain(
                                                color: AppColorCode.darkGrey,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                    ],
                                  ),
                                  isExpanded: true,
                                  iconSize: 30.0,
                                  style: new TextStyle(color: Colors.black),
                                  items: appController.languageList.map(
                                    (val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      );
                                    },
                                  ).toList(),
                                  validator: (value) => langId == null
                                      ? 'Please_gender'.tr
                                      : null,
                                  decoration: InputDecoration(
                                    errorStyle: TextStyle(
                                        color: AppColorCode.buttunColorDark),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(14)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.grey)),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  onChanged: (val) {
                                    setState(
                                      () {
                                        langId = appController.languageList
                                            .indexOf(val);
                                        appController.updatelang(langId!);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => LoginScreen());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'Skip'.tr,
                                  style: AppFontMain(
                                    color: AppColorCode.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: AppColorCode.gray,
                                size: 20,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: AppColorCode.gray,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }),
              ))
        ],
      ),
    );
  }
}
