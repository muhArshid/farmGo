import 'package:farmapp/controller/notification_controller.dart';
import 'package:farmapp/views/widgets/button_icons_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            body: Stack(children: [
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: appBar(
          label: 'Notification'.tr,
        ),
      ),
      Positioned(
          top: 60,
          left: 0,
          right: 10,
          bottom: 0,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(children: [
                GetX<NotificationController>(
                    init: Get.put<NotificationController>(
                        NotificationController()),
                    builder: (NotificationController ctr) {
                      if (ctr.data == null) {
                        return Text('Loading'.tr);
                      } else if (ctr.data!.isEmpty) {
                        return Text('Empty_List'.tr);
                      } else
                        return Expanded(
                          child: ListView.builder(
                              itemCount: ctr.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                final _data = ctr.data![index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Container(
                                    height: 10.h,
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black26,
                                    ),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Text(
                                            _data.mainTittle ?? '',
                                            style: TextStyle(
                                              fontSize: Get.textTheme.headline6!
                                                  .fontSize,
                                            ),
                                          ),
                                          Text(
                                            _data.subTittle ?? '',
                                            style: TextStyle(
                                              fontSize: Get.textTheme.subtitle1!
                                                  .fontSize,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        );
                    })
              ])))
    ])));
  }
}
