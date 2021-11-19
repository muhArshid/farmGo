import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:farmapp/utils/AssetConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

Widget drawerCard(
    {required String label, required String icon, Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Column(
      children: [
        SizedBox(height: 15),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(icon),
            SizedBox(width: 20),
            Text(
              'label',
              style: AppFontMain(
                color: AppColorCode.primaryText,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
      ],
    ),
  );
}

Widget drawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.only(left: 25, top: 30),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 10),
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 33,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'aerhi',
                  style: AppFontMain(
                    color: AppColorCode.primaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          ],
        ),
        SizedBox(height: 40),
        drawerCard(
          label: 'Home',
          icon: AssetConstant.profile,
          onTap: () {
            //Get.offAll(() => MainHomeHolder(currentIndex: 0));
          },
        ),
        drawerCard(
          label: 'Profile',
          icon: AssetConstant.profile,
          onTap: () {
            //   Get.offAll(() => MainHomeHolder(currentIndex: 2));
          },
        ),
        Divider(),
        SizedBox(height: 15),
        drawerCard(
          label: 'Dashbord',
          icon: AssetConstant.profile,
          onTap: () {
            Get.back();
            //   Get.to(() => MyBookings());
          },
        ),
        drawerCard(label: 'About Us', icon: AssetConstant.profile),
        drawerCard(label: 'FAQs', icon: AssetConstant.profile),
      ],
    ),
  );
}
