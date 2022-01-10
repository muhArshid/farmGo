import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/controller/service_condroler.dart';
import 'package:farmapp/model/core/category_item.dart';
import 'package:farmapp/model/core/user.dart';
import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:farmapp/views/screens/sevicese/add_new_item.dart';
import 'package:farmapp/views/screens/sevicese/widgets/single_item.dart';
import 'package:farmapp/views/widgets/button_icons_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SerchScreen extends StatefulWidget {
  final MainCategoryItemModel? category;
  const SerchScreen({Key? key, this.category}) : super(key: key);

  @override
  _SerchScreenState createState() => _SerchScreenState();
}

class _SerchScreenState extends State<SerchScreen> {
  bool viewSerch = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Stack(children: [
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: appBar(
          label: '',
        ),
      ),
      Positioned(
        top: 0,
        left: 180,
        right: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => AddNewScreen(
                        category: widget.category,
                      ));
                },
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppColorCode.mainGreyBg,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: AppColorCode.mainBlue,
                      size: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 5.h,
                  width: 20.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppColorCode.mainGreyBg,
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: AppColorCode.mainBlue,
                          size: 20,
                        ),
                        Text(
                          "Serch",
                          style: AppFontMain(
                            color: AppColorCode.headerColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Positioned(
          top: 60,
          left: 0,
          right: 10,
          bottom: 0,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Members',
                style: AppFontMain(
                  color: AppColorCode.headerColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            if (serviceController.itemModelList.value != null)
              Column(
                children: serviceController.itemModelList.value!
                    .map((cartItem) => SingleItemWidget(category: cartItem))
                    .toList(),
              )
          ]))
    ])));
  }
}
