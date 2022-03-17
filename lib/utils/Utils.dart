import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/views/screens/sevicese/widgets/PopUps/PopUpLoading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:farmapp/model/core/FamilyData.dart';

class Utils {
  static Size? displaySize;

  //System Chrome UI Theme

  static bool dangerStatus = true;

  static List socialData = [];

  static var lightNavbar = SystemUiOverlayStyle.light.copyWith(
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: AppColorCode.black,
      statusBarColor: AppColorCode.brandColor);

  static var darkNavbar = SystemUiOverlayStyle.dark.copyWith(
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: AppColorCode.black,
      statusBarColor: AppColorCode.brandColor);

  //TextStyles
  static TextStyle getprimaryStyle(Color color) {
    return TextStyle(color: color, fontFamily: 'Natosans');
  }

  static TextStyle getprimaryBoldStyle(Color color) {
    return TextStyle(
        color: color, fontFamily: 'Natosans', fontWeight: FontWeight.bold);
  }

  static TextStyle getprimaryFieldTextStyle(Color color) {
    return TextStyle(
        color: AppColorCode.greyColor, fontFamily: 'Natosans', fontSize: 13.0);
  }

  static TextStyle getprimaryFieldTextStyleWhite(Color color) {
    return TextStyle(
        color: AppColorCode.pureWhite, fontFamily: 'Natosans', fontSize: 13.0);
  }

  //TextFormField Styles

  static FamilyData? familyData;
  static double borderRadius = 20.0;
  static double buttonBorderRadius = 10.0;

  static InputDecoration getDefaultTextInputDecoration(
      String label, var suffixIcon) {
    return InputDecoration(
        labelText: label,
        errorStyle: TextStyle(fontSize: 11, color: Colors.red),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        labelStyle: TextStyle(fontSize: 13.0, color: AppColorCode.greyColor),
        suffixIcon: suffixIcon,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: AppColorCode.primaryText, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: AppColorCode.primaryText, width: 2.0),
        ));
  }

  static InputDecoration getDefaultTextInputDecorationForHomeSearch(
      String label, Icon suffixIcon) {
    return InputDecoration(
        labelText: label,
        errorStyle: TextStyle(fontSize: 11, color: Colors.red),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        labelStyle: TextStyle(fontSize: 13.0, color: AppColorCode.pureWhite),
        suffixIcon: suffixIcon,
        fillColor: Colors.white,
        focusColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: AppColorCode.pureWhite, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: AppColorCode.pureWhite, width: 2.0),
        ));
  }

  //Loading Widgets

  static bool checkShowLoader = false;
  static BuildContext? parentLoadingContext = null;

  static Future showLoader(context) async {
    await showDialog(
      context: context,
      builder: (_) => PopUpLoading(),
    ).then((onValue) {
      parentLoadingContext = context;
      checkShowLoader = true;
    });
  }

  static Future hideLoader() async {
    if (checkShowLoader == true && parentLoadingContext != null) {
      Navigator.pop(parentLoadingContext!);
      parentLoadingContext = null;
      checkShowLoader = false;
    }
  }

  static Future hideLoaderCurrrent(context) async {
    Navigator.pop(context);
    parentLoadingContext = null;
    checkShowLoader = false;
  }

  //Toast Contents

  static showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
