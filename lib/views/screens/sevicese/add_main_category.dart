import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/model/core/category_item.dart';
import 'package:farmapp/model/core/user.dart';
import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:farmapp/views/screens/sevicese/serch_item.dart';
import 'package:farmapp/views/screens/sevicese/widgets/single_category.dart';
import 'package:farmapp/views/screens/sevicese/widgets/single_item.dart';
import 'package:farmapp/views/widgets/button_icons_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AddFarmScreen extends StatefulWidget {
  final MainCategoryItemModel? category;
  const AddFarmScreen({Key? key, this.category}) : super(key: key);

  @override
  _AddFarmScreenState createState() => _AddFarmScreenState();
}

class _AddFarmScreenState extends State<AddFarmScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 10,
          bottom: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
//width: 100.w,
                height: 50.h,
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    image: new NetworkImage(widget.category!.image!),
                    fit: BoxFit.cover,
                  ),
                  border: Border(
                      bottom: BorderSide(
                          color: Color.fromRGBO(0, 83, 9, 1), width: 0.0)),
                  color: AppColorCode.gray2,
                  boxShadow: [
                    BoxShadow(
                      color: AppColorCode.brandColor,
                      blurRadius: 6.0,
                      spreadRadius: 3.0,
                      offset:
                          Offset(-2.0, 5.0), // shadow direction: bottom right
                    )
                  ],
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width, 150.0)),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Members',
                      style: AppFontMain(
                        color: AppColorCode.headerColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => SerchScreen(
                              category: widget.category,
                            ));
                      },
                      child: Row(
                        children: [
                          Text(
                            'more',
                            style: AppFontMain(
                              color: AppColorCode.headerColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios,
                              size: 10, color: Colors.black),
                          Icon(Icons.arrow_forward_ios,
                              size: 10, color: Colors.black),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              //         ListView(
              //   controller: scrollController,
              //   padding: EdgeInsets.all(12),
              //   children: [
              //     ...widget.usersProvider.users
              //         .map((user) => ListTile(
              //               title: Text(user.name),
              //               leading: CircleAvatar(
              //                 backgroundImage: NetworkImage(user.imageUrl),
              //               ),
              //             ))
              //         .toList(),
              //     if (widget.usersProvider.hasNext)
              //       Center(
              //         child: GestureDetector(
              //           onTap: widget.usersProvider.fetchNextUsers,
              //           child: Container(
              //             height: 25,
              //             width: 25,
              //             child: CircularProgressIndicator(),
              //           ),
              //         ),
              //       ),
              //   ],
              // ),
              Column(
                children: serviceController.users
                    .map((cartItem) => SingleItemWidget(category: cartItem))
                    .toList(),
              )
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: appBar(
            label: '',
          ),
        ),
        Positioned(
            top: 210,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  Text(
                    widget.category!.name!,
                    style: AppFontMain(
                      color: AppColorCode.brandColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Tottal-120',
                    style: AppFontMain(
                      color: AppColorCode.brandColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            )),
      ],
    )));
  }
}
