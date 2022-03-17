import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/controller/app_controller.dart';
import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:farmapp/utils/helper/StyleConfig.dart';
import 'package:farmapp/views/widgets/button_icons_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  AppController mainCtr = Get.find();

  String? langtypeid;

  int? langId;
  bool checkboxSelected = false;
  bool switchSelected = false;
  bool radioSelected = false;
  bool iconSelected = false;
  String dropdownValue = 'One';
  @override
  void initState() {
    langtypeid = mainCtr.langId;

    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  bool isEdit = false;
  bool isNameEdit = false;
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
            label: 'Settings'.tr,
          ),
        ),
        Positioned(
            top: 60,
            left: 0,
            right: 10,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: GetBuilder<AppController>(builder: (ct) {
                return Column(children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Text(
                          'Name' + ':',
                          style: AppFontMain(
                            color: AppColorCode.headerColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 1,
                        ),
                        isNameEdit
                            ? SizedBox(
                                height: 5.h,
                                width: 25.h,
                                child: buildCustextForm(
                                  label: 'Name',
                                  controller: serviceController.name,
                                  validator: (val) {
                                    if (val!.isEmpty) return 'Required';
                                  },
                                ),
                              )
                            : Text(
                                userController.userModel.value.name!,
                                style: AppFontMain(
                                  color: AppColorCode.darkGrey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isNameEdit = true;
                            });
                          },
                          child: !isNameEdit
                              ? Icon(
                                  Icons.edit,
                                  color: AppColorCode.brandColor,
                                )
                              : Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isNameEdit = false;
                                        });
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: AppColorCode.brandColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isNameEdit = false;
                                          serviceController.updateName();
                                        });
                                      },
                                      child: Icon(
                                        Icons.security_update_good_sharp,
                                        color: AppColorCode.brandColor,
                                      ),
                                    ),
                                  ],
                                ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      //
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),

                      boxShadow: [StyleConfig.boxShadow()],
                    ),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
                        // labelText: widget.title,
                        border: InputBorder.none,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: AppColorCode.buttunColorLate,
                          ),
                          hint: ct.language == null
                              ? Text('Language'.tr,
                                  style: AppFontMain(
                                      color: AppColorCode.darkGrey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15))
                              : Text(
                                  ct.language!,
                                  style: AppFontMain(
                                    color: AppColorCode.darkGrey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: new TextStyle(color: Colors.black),
                          items: appController.languageList.map(
                            (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              );
                            },
                          ).toList(),
                          validator: (value) =>
                              langId == null ? 'Please_gender'.tr : null,
                          decoration: InputDecoration(
                            errorStyle:
                                TextStyle(color: AppColorCode.buttunColorDark),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.grey)),
                            enabledBorder: InputBorder.none,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          onChanged: (val) {
                            setState(
                              () {
                                langId =
                                    appController.languageList.indexOf(val);
                                appController.updatelang(langId!);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(14),
                  //     boxShadow: [StyleConfig.boxShadow()],
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.all(12.0),
                  //         child: Text(
                  //           'app_notification'.tr,
                  //           style: AppFontMain(
                  //               color: AppColorCode.buttunColorDark,
                  //               fontWeight: FontWeight.bold,
                  //               letterSpacing: 1,
                  //               fontSize: 14),
                  //         ),
                  //       ),
                  //       SizedBox(height: 32),
                  //       // e (
                  //       //   onChanged: (value) {
                  //       //     setState(() {
                  //       //       switchSelected = value;
                  //       //     });
                  //       //   },
                  //       //   value: switchSelected,
                  //       //   activeColor:
                  //       //       AppColorCode.buttunColorLate.withOpacity(0.6),
                  //       //   blurRadius: 4,
                  //       // ),
                  //     ],
                  //   ),
                  // )
                ]);
              }),
            ))
      ]),
    ));
  }
}
