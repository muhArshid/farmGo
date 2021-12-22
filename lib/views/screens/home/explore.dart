import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:farmapp/utils/AssetConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: ListView(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Explore',
                    style: AppFontMain(
                      color: AppColorCode.headerColor,
                      fontSize: 33.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: AppColorCode.brandColor,
                        size: 30,
                      ),
                      SizedBox(
                        width: 17,
                      ),
                      Icon(
                        Icons.add_box_outlined,
                        color: AppColorCode.brandColor,
                        size: 30,
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 1000,
          child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: 10.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                        color: AppColorCode.pureWhite,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage(AssetConstant.profiledemy),
                              radius: 30,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Sam alex',
                                  style: AppFontMain(
                                    color: AppColorCode.headerColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Heading details',
                                  style: AppFontMain(
                                    color: AppColorCode.headerColor,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mi toVr,faro sagittis,far',
                          style: AppFontMain(
                            color: AppColorCode.headerColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: 80.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                              color: AppColorCode.brandColor,
                              borderRadius:
                                  BorderRadiusDirectional.circular(10)),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.favorite_border,
                              color: AppColorCode.brandColor,
                              size: 30,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Icon(
                              Icons.messenger_outline_outlined,
                              color: AppColorCode.brandColor,
                              size: 30,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Icon(
                              Icons.file_upload_outlined,
                              color: AppColorCode.brandColor,
                              size: 30,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
        )
      ],
    )));
  }
}
