import 'package:farmapp/model/core/sub_category_item.dart';
import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:farmapp/views/screens/sevicese/widgets/single_item_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

class SingleItemWidget extends StatelessWidget {
  final SubCategoryItemModel? category;

  const SingleItemWidget({Key? key, this.category}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: () {
          showBarModalBottomSheet(
            context: context,
            builder: (context) => Container(
              color: Colors.white,
              child: SingleItemView(
                category: category,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: AppColorCode.pureWhite),
          height: 7.h,
          width: 90.w,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    category!.name!,
                    style: AppFontMain(
                      color: AppColorCode.SubHeaderColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    category!.tag_id!,
                    style: AppFontMain(
                      color: AppColorCode.SubHeaderColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    category!.item_sub!,
                    style: AppFontMain(
                      color: AppColorCode.SubHeaderColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
