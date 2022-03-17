import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/model/core/category_item.dart';
import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:farmapp/views/screens/sevicese/add_main_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleCategoryWidget extends StatelessWidget {
  final MainCategoryItemModel? category;
  final int? itemNo;
  const SingleCategoryWidget({Key? key, this.category, this.itemNo})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var image = category!.image!;
    final Color color = Colors.primaries[itemNo! % Colors.primaries.length];
    return InkWell(
      onTap: () async {
        await serviceController.fetchNextItemWithId(category!.id!);
        Get.to(() => AddFarmScreen(
              category: category,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Positioned(
              child: Container(
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                    color: color.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(category!.downloadUrl!),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: color.withOpacity(0.3),
                          offset: Offset(3, 2),
                          blurRadius: 7)
                    ]),
              ),
            ),
            Positioned(
              child: Center(
                child: Text(
                  category!.name!,
                  style: AppFontMain(
                    color: AppColorCode.pureWhite,
                    fontSize: 33,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
