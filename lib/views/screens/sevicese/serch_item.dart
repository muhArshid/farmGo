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
  bool serchTab = false;
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
        left: serchTab ? 100 : 180,
        right: 0,
        child: serchTab
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  height: 5.h,
                  width: 23.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppColorCode.mainGreyBg,
                  ),
                  child: Center(
                    child: TextField(
                      style: TextStyle(color: AppColorCode.brandColor),
                      onChanged: (value) {
                        setState(() {
                          //filteredList.clear(); //for the next time that we search we want the list to be unfilterted
                          //    filteredList.addAll(autoList); //getting list to original state

//removing items that do not contain the entered Text
                          // filteredList.removeWhere((i) => i.contains(value.toString())==false);

//following is just a bool parameter to keep track of lists
                          //  searched=!searched;
                        });
                      },
                      controller: serviceController.editingController,
                      decoration: InputDecoration(
                        suffixStyle: TextStyle(color: Colors.red),
                        prefixIconColor: AppColorCode.brandColor,
                        border: InputBorder.none,
                        hoverColor: AppColorCode.brandColor,
                        fillColor: AppColorCode.brandColor,
                        labelText: "",
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColorCode.brandColor,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            color: AppColorCode.brandColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(width: 20),
                    // InkWell(
                    //   onTap: () {},
                    //   child: Container(
                    //     height: 5.h,
                    //     width: 23.w,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(14),
                    //       color: AppColorCode.mainGreyBg,
                    //     ),
                    //     child: Center(
                    //       child: Row(
                    //         children: [
                    //           Icon(
                    //             Icons.search,
                    //             color: AppColorCode.brandColor,
                    //             size: 20,
                    //           ),
                    //           InkWell(
                    //             onTap: () {
                    //               setState(() {
                    //                 serchTab = true;
                    //               });
                    //             },
                    //             child: Padding(
                    //               padding: const EdgeInsets.all(8.0),
                    //               child: Text(
                    //                 "Serch",
                    //                 style: AppFontMain(
                    //                   color: AppColorCode.headerColor,
                    //                   fontSize: 15,
                    //                   fontWeight: FontWeight.w400,
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
      ),
      Positioned(
          top: 60,
          left: 0,
          right: 10,
          bottom: 0,
          child: ListView(children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Members'.tr,
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
            serchTab
                ? Column(
                    children: serviceController.itemModelList.value!
                        .map((cartItem) => SingleItemWidget(category: cartItem))
                        .toList(),
                  )
                : Column(
                    children: serviceController.itemModelList.value!
                        .map((cartItem) => SingleItemWidget(category: cartItem))
                        .toList(),
                  )
          ]))
    ])));
  }
}
