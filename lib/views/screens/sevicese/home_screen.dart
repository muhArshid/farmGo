import 'dart:ui';
import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/controller/notification_controller.dart';
import 'package:farmapp/controller/service_condroler.dart';
import 'package:farmapp/controller/to_do_list.dart';
import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:farmapp/utils/AssetConstants.dart';
import 'package:farmapp/views/screens/notification/notification.dart';
import 'package:farmapp/views/screens/product/home/home.dart';
import 'package:farmapp/views/screens/sevicese/to_do_list.dart';
import 'package:farmapp/views/screens/sevicese/widgets/add_category.dart';
import 'package:farmapp/views/screens/sevicese/widgets/single_category.dart';
import 'package:farmapp/views/widgets/button_icons_widgets.dart';
import 'package:farmapp/views/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';
import 'package:badges/badges.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSchedule = true;
  ServiceContoller ctr = Get.put(ServiceContoller());
  @override
  void initState() {
    // TODO: implement initState
    ctr.getMyData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Widget titleBar() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AssetConstant.appName,
            style: AppFontMain(
              color: AppColorCode.headerColor,
              fontSize: 33,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(width: 10),
          InkWell(
            onTap: () {
              Get.to(() => NotificationScreen());
            },
            child: Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GetX<NotificationController>(
                        init: Get.put<NotificationController>(
                            NotificationController()),
                        builder: (NotificationController ctr) {
                          return Badge(
                            position: BadgePosition.topEnd(top: 0, end: 3),
                            animationDuration: Duration(milliseconds: 300),
                            animationType: BadgeAnimationType.slide,
                            badgeContent: Center(
                              child: Text(
                                ctr.data!.length
                                    .toString(), //   proCtr.cartList.length.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    width: 2,
                                    color: AppColorCode.brandColor,
                                  )),
                              child: Icon(
                                Icons.notification_important_outlined,
                                color: AppColorCode.brandColor,
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ],
            ),
          )
        ],
      );
    }

    final orientation = MediaQuery.of(context).orientation;
    return SafeArea(
      child: Scaffold(
        //     drawer: Theme(
        //       data: Theme.of(context).copyWith(
        //         canvasColor: Colors.white,
        //       ),
        //  //     child: drawer(context),
        //     ),
        body: ListView(children: [
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
                  icon: Icon(
                    Icons.add_box,
                    color: AppColorCode.brandColor,
                  ),
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
          Container(
            child: GetX<ServiceContoller>(
              init: Get.put<ServiceContoller>(ServiceContoller()),
              builder: (ServiceContoller serController) {
                final Color color = Colors.primaries[
                    serController.mainCat!.length % Colors.primaries.length];
                var legth = serController.mainCat!.length / 2;
                if (serController.mainCat == null) {
                  return Text('Loading');
                } else if (serController.mainCat!.isEmpty) {
                  return InkWell(
                    onTap: () {
                      showBarModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          color: Colors.white,
                          child: AddMainCategorys(),
                        ),
                      );
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
                                    image: AssetImage(AssetConstant.addLogo),
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
                            top: 150,
                            left: 150.0,
                            bottom: 110.0,
                            child: Container(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: AppColorCode.pureWhite,
                                      size: 38,
                                    ),
                                    Text(
                                      'Add'.tr,
                                      style: AppFontMain(
                                        color: AppColorCode.pureWhite,
                                        fontSize: 33,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                } else
                  return Container(
                    height: 30.h * legth.toDouble() + 30.h,
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: serController.mainCat!.length + 1,
                      itemBuilder: (BuildContext context, int index) =>
                          serController.mainCat!.length == index
                              ? InkWell(
                                  onTap: () {
                                    showBarModalBottomSheet(
                                      context: context,
                                      builder: (context) => Container(
                                        color: Colors.white,
                                        child: AddMainCategorys(),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              4,
                                          decoration: BoxDecoration(
                                              color: color.withOpacity(0.3),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: AssetImage(
                                                    AssetConstant.addLogo),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                    color:
                                                        color.withOpacity(0.3),
                                                    offset: Offset(3, 2),
                                                    blurRadius: 7)
                                              ]),
                                        ),
                                        Positioned(
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.add,
                                                  color: AppColorCode.pureWhite,
                                                  size: 38,
                                                ),
                                                Text(
                                                  'Add'.tr,
                                                  style: AppFontMain(
                                                    color:
                                                        AppColorCode.pureWhite,
                                                    fontSize: 33,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : SingleCategoryWidget(
                                  category: serController.mainCat![index],
                                  itemNo: index,
                                ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              (orientation == Orientation.portrait) ? 2 : 3),
                    ),
                  );
              },
            ),
          ),
          SizedBox(height: 10),
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
                    'Today_Activities'.tr,
                    style: AppFontMain(
                      color: AppColorCode.SubHeaderColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),
                  GetX<TodoController>(
                      init: Get.put<TodoController>(TodoController()),
                      builder: (TodoController todoController) {
                        return Center(
                          child: new Container(
                            height: 100.0,
                            child: (todoController.todays!.length != 0)
                                ? ListView.builder(
                                    itemCount: todoController.todays!.length,
                                    itemBuilder: (context, index) {
                                      final _todoModel =
                                          todoController.todays![index];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: new Container(
                                          decoration: BoxDecoration(
                                            color: AppColorCode.bgGreyColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          width: 40.w,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Icon(
                                                  Icons.date_range_outlined,
                                                  color: AppColorCode.black,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    _todoModel.content!,
                                                    style: AppFontMain(
                                                      color: AppColorCode
                                                          .SubHeaderColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    scrollDirection: Axis.horizontal,
                                  )
                                : Center(
                                    child: Text(
                                      'Today_Found'.tr,
                                      style: AppFontMain(
                                        color: AppColorCode.SubHeaderColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: button(
              label: 'checking'.tr,
              height: size.height * 0.07,
              width: size.width,
              onTap: () {
                // userController.signOut();
                Get.toNamed("red");
              },
            ),
          ),
          SizedBox(height: 30),
        ]),
      ),
    );
  }
}
