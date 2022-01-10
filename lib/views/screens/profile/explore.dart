import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/controller/profile_controller.dart';
import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:farmapp/utils/AssetConstants.dart';
import 'package:farmapp/views/screens/profile/widgets/add_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
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
            body: Column(
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
                      InkWell(
                        onTap: () {
                          showBarModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                              color: Colors.white,
                              child: AddPostScreen(),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.add_box_outlined,
                          color: AppColorCode.brandColor,
                          size: 30,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        GetX<ProfileContoller>(
            init: Get.put<ProfileContoller>(ProfileContoller()),
            builder: (ProfileContoller ctr) {
              if (ctr.posts == null) {
                return Text('Loading');
              } else if (ctr.posts!.isEmpty) {
                return Text('Empty List');
              } else
                return Expanded(
                  child: ListView.builder(
                      itemCount: ctr.posts!.length,
                      itemBuilder: (context, index) {
                        final _postModel = ctr.posts![index];
                        var image = _postModel.image!;
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                  _postModel.content!,
                                  style: AppFontMain(
                                    color: AppColorCode.headerColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                FutureBuilder(
                                    future: serviceController.getImage(
                                        context, "post/$image"),
                                    builder: (context, AsyncSnapshot snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done)
                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          width: 80.w,
                                          height: 30.h,
                                          decoration: BoxDecoration(
                                            //   color: AppColorCode.brandColor,
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(10),
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: snapshot.data.image
                                                  as ImageProvider,
                                            ),
                                          ),
                                        );
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting)
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );

                                      return Container();
                                    }),
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
                );
            })
      ],
    )));
  }
}