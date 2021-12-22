import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/controller/service_condroler.dart';
import 'package:farmapp/model/core/category_item.dart';
import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:farmapp/views/screens/sevicese/add_main_category.dart';
import 'package:farmapp/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SingleCategoryWidget extends StatelessWidget {
  final MainCategoryItemModel? category;
  const SingleCategoryWidget({Key? key, this.category}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        //     await serviceController.getitemlist(category!.id.toString());
        await serviceController.fetchNextUsers();
        Get.to(() => AddFarmScreen(
              category: category,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Container(
              height: 20.h,
              width: 90.w,
              decoration: BoxDecoration(
                  image: new DecorationImage(
                    image: new NetworkImage(category!.image!),
                    fit: BoxFit.cover,
                  ),
                  // child: Image.network(
                  //   category!.image!,
                  //   width: double.infinity,
                  // )
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(.5),
                        offset: Offset(3, 2),
                        blurRadius: 7)
                  ]),
            ),
            new Center(
              child: new Text(
                category!.name!,
                style: AppFontMain(
                  color: AppColorCode.brandColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
