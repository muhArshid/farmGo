import 'package:flutter/cupertino.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData?.size.width;
    screenHeight = _mediaQueryData?.size.width;
  }

  //double getProportinateScreenHeight(double inputHeight) {
  // double screenHeight = SizeConfig.screenHeight;

  //return (inputHeight / 812) * screenHeight;
  //}

  // double getProportinateScreenWidth(double inputWidth) {
  //   double screenWidth = SizeConfig.screenWidth;

  //   return (inputWidth / 375) * screenWidth;
  // }
}
