import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:farmapp/utils/helper/StyleConfig.dart';
import 'package:farmapp/views/widgets/button_icons_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Appbar extends StatefulWidget implements PreferredSizeWidget {
  final String? screenTitle;
  final BuildContext? currentContext;
  Appbar({Key? key, @required this.screenTitle, @required this.currentContext})
      : super(key: key);

  @override
  _AppbarState createState() => _AppbarState();
  Size get preferredSize => const Size.fromHeight(100);
}

class _AppbarState extends State<Appbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      //  backgroundColor: widget.color,
      elevation: 0,
      leading: backButtonCherv(widget.currentContext ?? context),
      title: Text(
        widget.screenTitle ?? 's',
        style: AppFontMain(
            color: AppColorCode.buttunColorDark,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            fontSize: 15),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  CustomAppBar(this.cTcontext, this.text, this.color);
  final BuildContext cTcontext;
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: color,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                backButtonCherv(cTcontext),
                SizedBox(width: 10),
                Text(
                  text,
                  style: AppFontMain(
                      fontFamily: 'Poppins',
                      color: AppColorCode.buttunColorDark,
                      fontWeight: FontWeight.w700,
                      fontSize: 15),
                )
              ],
            ),
            //if (shareUrl != null) IconsWidget.share(() {})
          ],
        ),
      ),
    );
  }
}

Widget buildAppBar({
  BuildContext? context,
  String? label,
  Function()? onTapIconOne,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 0),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                onTap: onTapIconOne,
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      child: Center(
                          child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      )),
                      decoration: BoxDecoration(
                          gradient: StyleConfig.brandGradient(),
                          borderRadius: BorderRadius.circular(25)),
                      height: MediaQuery.of(context!).size.height * .065,
                      width: MediaQuery.of(context).size.width * .13,
                    )),
              ),
              SizedBox(width: 10),
              Text(
                label!,
                style: AppFontMain(
                    fontFamily: 'Poppins',
                    color: AppColorCode.buttunColorDark,
                    fontWeight: FontWeight.w700,
                    fontSize: 15),
              )
            ],
          ),
          //if (shareUrl != null) IconsWidget.share(() {})
        ],
      ),
    ),
  );
}
