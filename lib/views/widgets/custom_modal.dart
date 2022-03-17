import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final Color? bgColor;
  final String? title;
  final String? message;
  final String? positiveBtnText;
  final String? negativeBtnText;
  final Function? onPostivePressed;
  final Function? onNegativePressed;
  final double? circularBorderRadius;

  CustomAlertDialog({
    this.title,
    this.message,
    this.circularBorderRadius = 15.0,
    this.bgColor = Colors.white,
    this.positiveBtnText,
    this.negativeBtnText,
    this.onPostivePressed,
    this.onNegativePressed,
  })  : assert(bgColor != null),
        assert(circularBorderRadius != null);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null
          ? Text(
              title!,
              style: AppFontMain(
                color: AppColorCode.headerColor,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            )
          : null,
      content: message != null
          ? Text(
              message!,
              style: AppFontMain(
                color: AppColorCode.headerColor,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            )
          : null,
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circularBorderRadius!)),
      actions: <Widget>[
        negativeBtnText != null
            ? FlatButton(
                child: Text(
                  negativeBtnText!,
                  style: AppFontMain(
                    color: AppColorCode.headerColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                textColor: Theme.of(context).accentColor,
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onNegativePressed != null) {
                    onNegativePressed!();
                  }
                },
              )
            : Container(),
        positiveBtnText != null
            ? FlatButton(
                child: Text(
                  positiveBtnText!,
                  style: AppFontMain(
                    color: AppColorCode.headerColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                textColor: Theme.of(context).accentColor,
                onPressed: () {
                  if (onPostivePressed != null) {
                    onPostivePressed!();
                  }
                },
              )
            : Container(),
      ],
    );
  }
}
