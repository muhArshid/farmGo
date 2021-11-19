import 'dart:ui';
import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:farmapp/utils/AssetConstants.dart';
import 'package:farmapp/views/screens/sevicese/add_main_category.dart';
import 'package:farmapp/views/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSchedule = true;
  @override
  Widget build(BuildContext context) {
    Widget categoryItem() {
      return InkWell(
        onTap: () {
          Get.to(() => AddFarmScreen());
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: AppColorCode.brandColor),
          height: 100,
          width: 50,
          child: Center(child: Text('data')),
        ),
      );
    }

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
          SizedBox(width: 20),
          Row(
            children: [
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    SizedBox(width: 5),
                    SvgPicture.asset(AssetConstant.profile_inactive),
                  ],
                ),
              ),
              SizedBox(width: 10),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    SizedBox(width: 5),
                    SvgPicture.asset(AssetConstant.profile_inactive),
                  ],
                ),
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
              padding: const EdgeInsets.all(8.0),
              child: titleBar(),
            ),
            SizedBox(height: 30),
            //   categoryItem(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: StaggeredGridView.countBuilder(
                //   controller: _scrollController,
                //  padding: const EdgeInsets.only(left: 10, right: 10),
                crossAxisCount: 2,
                crossAxisSpacing: 14.0,
                mainAxisSpacing: 14.0,
                itemCount: 13,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
                itemBuilder: (context, index) {
                  // currentIndex = index;
                  return categoryItem();
                },
              ),
            ),
            SizedBox(height: 20),

            Container(
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
                      itemBuilder: (context, index) {
                        return new Card(
                            child: new Container(
                          width: 80.0,
                          child: new Text('Hello'),
                          alignment: Alignment.center,
                        ));
                      },
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ]),
        ),
      ),
    );
  }
}
