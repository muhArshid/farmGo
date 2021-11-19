import 'package:flutter/material.dart';

class AppColorCode {
  static const Color primaryTextHalf = Color(0x80414B5A);
  static const Color primaryText = Color(0xFF000000);
  static const Color borderColor = Color(0xFFEEEEEE);
  static const Color lineColor = Color(0xEEEEEEEE);
  static const Color facebookColor = Color(0xFF3B5998);
  static const Color greenColor = Color(0xFF23D40A);
  static const Color chevColor = Color(0xFF221E1E);
  static const Color greyColor = Color(0xFFDDDDDD);
  static const Color bgGreyColor = Color(0xFFF2F2F2);
  static const Color textGrey = Color(0xFF221815);
  static const Color textDim = Color.fromRGBO(34, 24, 21, 0.5);
  static const Color textGray = Color.fromRGBO(62, 73, 88, 1);
  static const Color yellowColor = Color(0xFFFCB70B);
  static const Color redColor = Color(0xFFF7471D);
  static const Color textGrey1 = Color(0xFF333333);
  static const Color inactiveGrey = Color(0xFF818181);
  static const Color buttunColorLate = Color(0xFF536DFE);
  static const Color buttunColorDark = Color(0xFF1A237E);

  ///Card Color
  ///
  static const Color brandGradient1 = Color.fromRGBO(65, 54, 241, 1);
  static const Color blueCardColor = Color(0xFFF7F5E0);
  static const Color orangeCardColor = Color(0xFFD67715);
  static const Color goldCardColor = Color(0x8743FF);
  static const Color starColor = Color.fromRGBO(255, 176, 36, 1);
  static const Color litetGrey = Color.fromRGBO(239, 239, 247, 1);
  static const Color darkGrey = Color.fromRGBO(62, 73, 88, 1);
  static const Color golBatDark = Color.fromRGBO(33, 37, 41, 1);
  static const Color golBalite = Color.fromRGBO(173, 181, 189, 1);
  static const Color shadow = Color.fromRGBO(125, 66, 253, 0.14);
  static const Color orangeShadow = Color.fromRGBO(249, 190, 173, 1);
  static const Color gray = Color.fromRGBO(51, 51, 51, 1);
  static const Color black = Color.fromRGBO(62, 73, 88, 1);
  static const Color whiteshadow = Color.fromRGBO(255, 255, 255, 1);
  static const Color mainDark = Color.fromRGBO(66, 80, 96, 1);
  static const Color selactColor = Color.fromRGBO(66, 80, 96, 1);
  static const Color grayMix = Color.fromRGBO(151, 173, 182, 1);
  static const Color grey3 = Color.fromARGB(247, 248, 249, 1);
  static const Color dark = Color.fromRGBO(15, 18, 78, 1);
  static const Color grey1 = Color(0xFF00FFFFFF);
  static const Color gray2 = Color(0xFFB7C5F0);
  static const Color pureWhite = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFEDF0F2);
  static const Color backgroundColor = Color(0xFFE5E5E5);
  static const Color brandColor = Color(0xFF6282F2);
  //text
  static const Color headerColor = Color(0xFF000000);
  static const Color labelColor = Color(0xFF000000);
  static const Color SubHeaderColor = Color(0xFF000000);
  //butten
  static const Color butColor = Color(0xFF2A4A88);
  static const Color buttonGray = Color.fromRGBO(218, 218, 218, 1);

  static const Color bgColor = Color(0xFFF8F9FB);

  static const Color secondaryText = Color(0xFF8F97A0);
  static const Color mainBlue = Color(0xFF37929A);
  static const Color mainGreyBg = Color(0xFFF1F3F6);

  static const Color ratingColor = Color(0xFF76777E);
  static const Color discountBg = Color(0xFFF1F9FE);
  static const Color rose = Color(0xFFFFEEDF);
  static const Color dateBg = Color(0xFFF3FEFF);
}

class ColorAdapter {
  static Color getColorFromHex(String hexColor) {
    if (hexColor.length == 7) {
      hexColor = hexColor.replaceFirst('#', '');
      hexColor = "FF" + hexColor;
    } else {
      hexColor = 'FFFF8D13';
    }
    var integer = int.parse(hexColor, radix: 16);
    return Color(integer);
  }
}
