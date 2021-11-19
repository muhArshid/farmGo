import 'package:farmapp/utils/AppColorCode.dart';
import 'package:flutter/material.dart';

Widget gradientWrap({@required Widget? child}) {
  return ShaderMask(
      shaderCallback: (bounds) => RadialGradient(
            center: Alignment.center,
            radius: .1,
            colors: <Color>[
              AppColorCode.brandColor,
              AppColorCode.brandGradient1
            ],
            tileMode: TileMode.mirror,
          ).createShader(bounds),
      child: child);
}

class StyleConfig {
  static LinearGradient brandGradient() => LinearGradient(
      colors: [AppColorCode.brandColor, AppColorCode.brandGradient1],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
  static LinearGradient brandGradientNull() => LinearGradient(
      colors: [Colors.white, Colors.white],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
  static LinearGradient brandGradientLiteGrey() => LinearGradient(
      colors: [AppColorCode.grey3, AppColorCode.grey3],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
  static LinearGradient brandGradientGrey() => LinearGradient(
      colors: [AppColorCode.darkGrey, AppColorCode.darkGrey],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
  static LinearGradient brandGradientGreyLite() => LinearGradient(
      colors: [AppColorCode.litetGrey, AppColorCode.litetGrey],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
  static BoxShadow boxShadow() => BoxShadow(
        color: AppColorCode.shadow,
        blurRadius: 2.0, // soften the shadow
        spreadRadius: 1.0, //extend the shadow

        offset: Offset(
          0, // Move to right 10  horizontally
          0, // Move to bottom 10 Vertically
        ),
      );
}
