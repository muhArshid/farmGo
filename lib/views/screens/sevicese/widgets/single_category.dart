import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/model/core/category_item.dart';
import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:farmapp/views/screens/sevicese/add_main_category.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SingleCategoryWidget extends StatelessWidget {
  final MainCategoryItemModel? category;
  const SingleCategoryWidget({Key? key, this.category}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var image = category!.image!;

    return InkWell(
      onTap: () async {
        await serviceController.fetchNextItems(category!.id!);
        Get.to(() => AddFarmScreen(
              category: category,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            FutureBuilder(
                future: serviceController.getImage(context, "mainImage/$image"),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done)
                    return Container(
                      height: MediaQuery.of(context).size.height / 4,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: snapshot.data.image as ImageProvider,
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(.5),
                                offset: Offset(3, 2),
                                blurRadius: 7)
                          ]),
                    );

                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(
                      child: CircularProgressIndicator(),
                    );

                  return Container();
                }),
            Center(
              child: new Positioned(
                top: 150,
                left: 150.0,
                bottom: 110.0,
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
