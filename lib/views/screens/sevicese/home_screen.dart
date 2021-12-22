import 'dart:ui';
import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:farmapp/views/screens/home/user.dart';
import 'package:farmapp/views/screens/product/home/home.dart';
import 'package:farmapp/views/screens/sevicese/add_main_category.dart';
import 'package:farmapp/views/screens/sevicese/to_do_list.dart';
import 'package:farmapp/views/screens/sevicese/widgets/add_category.dart';
import 'package:farmapp/views/screens/sevicese/widgets/category.dart';
import 'package:farmapp/views/screens/sevicese/widgets/single_category.dart';
import 'package:farmapp/views/widgets/button_icons_widgets.dart';
import 'package:farmapp/views/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSchedule = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Widget titleBar() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Category',
            style: AppFontMain(
              color: AppColorCode.headerColor,
              fontSize: 33,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(width: 10),
          Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          width: 2,
                          color: AppColorCode.brandColor,
                        )),
                    child: Icon(
                      Icons.person_outline_sharp,
                      color: AppColorCode.brandColor,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          width: 2,
                          color: AppColorCode.brandColor,
                        )),
                    child: Icon(
                      Icons.notifications,
                      color: AppColorCode.brandColor,
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      );
    }

    return SafeArea(
      child: Scaffold(
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.white,
          ),
          child: drawer(context),
        ),
        body: Center(
          child: ListView(children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: titleBar(),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    icon: Icon(Icons.add_box),
                    onPressed: () {
                      showBarModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          color: Colors.white,
                          child: AddMainCategorys(),
                        ),
                      );
                    }),
                SizedBox(width: 10),
              ],
            ),
            //   categoryItem(),

            SizedBox(height: 10),
            Obx(() => Column(
                  children: userController.userModel.value.mainCategory!
                      .map((cartItem) =>
                          SingleCategoryWidget(category: cartItem))
                      .toList(),
                )),
            InkWell(
              onTap: () {
                Get.to(() => ToDoListScreen());
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColorCode.pureWhite,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Activities',
                      style: AppFontMain(
                        color: AppColorCode.SubHeaderColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10),
                    new Container(
                      height: 100.0,
                      child: new ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: new Container(
                              decoration: BoxDecoration(
                                color: AppColorCode.bgGreyColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 40.w,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Icon(
                                      Icons.ac_unit_outlined,
                                      color: AppColorCode.black,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Activities',
                                      style: AppFontMain(
                                        color: AppColorCode.SubHeaderColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: button(
                label: 'products',
                height: size.height * 0.07,
                width: size.width,
                onTap: () {
                  Get.to(ProductScreen());
                },
              ),
            ),
            SizedBox(height: 30),
          ]),
        ),
      ),
    );
  }
}
