import 'package:farmapp/model/core/post_model.dart';
import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:farmapp/views/screens/profile/widgets/edit_post.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class MyPostWidget extends StatelessWidget {
  const MyPostWidget({Key? key, this.postModel}) : super(key: key);
  final PostModel? postModel;

  @override
  Widget build(BuildContext context) {
    var image = postModel!.image!;
    return InkWell(
      onTap: () {
        showBarModalBottomSheet(
          context: context,
          builder: (context) => Container(
            color: Colors.white,
            child: EditPostWidget(postModel: postModel),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: 10.w,
          //    height: 60.h,
          decoration: BoxDecoration(
              color: AppColorCode.pureWhite,
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Text(
                postModel!.content!,
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
                  //   color: AppColorCode.brandColor,
                  borderRadius: BorderRadiusDirectional.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(postModel!.downloadUrl!)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  //     Icon(
                  //       Icons.favorite_border,
                  //       color: AppColorCode.brandColor,
                  //       size: 30,
                  //     ),
                  //     SizedBox(
                  //       width: 15,
                  //     ),
                  //     Icon(
                  //       Icons.messenger_outline_outlined,
                  //       color: AppColorCode.brandColor,
                  //       size: 30,
                  //     ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Edit'.tr,
                    style: AppFontMain(
                      color: AppColorCode.brandColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
