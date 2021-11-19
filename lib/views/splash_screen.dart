import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:farmapp/utils/AssetConstants.dart';
import 'package:farmapp/views/screens/commen_screen.dart';
import 'package:farmapp/views/screens/home/main_home_holder.dart';
import 'package:farmapp/views/widgets/button_icons_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () {
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
              top: 512,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.asset(AssetConstant.bgImage),
                    SizedBox(height: 14),
                    Text(
                      'WELCOME',
                      style: AppFontMain(
                        color: AppColorCode.black,
                        fontSize: 33,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10),
                    button(
                      label: 'Log In',
                      height: size.height * 0.07,
                      width: size.width * 0.30,
                      onTap: () {
                        Get.offAll(() => MainHomeHolder());
                      },
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
