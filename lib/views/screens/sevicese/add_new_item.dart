import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/constants/firebase.dart';
import 'package:farmapp/controller/service_condroler.dart';
import 'package:farmapp/model/core/category_item.dart';
import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:farmapp/utils/AssetConstants.dart';
import 'package:farmapp/utils/helper/date_format_helper.dart';
import 'package:farmapp/views/widgets/button_icons_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sizer/sizer.dart';

class AddNewScreen extends StatefulWidget {
  final MainCategoryItemModel? category;
  const AddNewScreen({Key? key, this.category}) : super(key: key);

  @override
  _AddNewScreenState createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {
  var setDefaultmainCat = true, setDefaultSubCat = true;
  var mainCat, subCat;
  final _formKey = GlobalKey<FormState>();
  late DateTime pickedDate;
  Future<void> _selectDateTo(BuildContext context) async {
    DateTime chooseDate = DateTime.now();

    pickedDate = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ))!;
    print(pickedDate);
    // ignore: unnecessary_null_comparison
    if (pickedDate != null && pickedDate != chooseDate)
      setState(() {
        serviceController.dob.text = DateFormatHelper.formatYearMonthDayServer(
            pickedDate.toIso8601String());
      });
  }

  @override
  void initState() {
    super.initState();
  }

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
          label: '',
        ),
      ),
      Positioned(
        top: 60,
        left: 0,
        right: 10,
        bottom: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: ListView(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Container(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColorCode.brandColor,
                          radius: 70,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage(AssetConstant.profiledemy),
                            radius: 60,
                          ),
                        ),
                        // Positioned(
                        //     right: 10,
                        //     bottom: 0,
                        //     top: 0,
                        //     child: Container(
                        //       height: 25,
                        //       width: 26,
                        //       decoration: BoxDecoration(
                        //           color: AppColorCode.brandColor,
                        //           borderRadius: BorderRadius.circular(40)),
                        //       child: IconButton(
                        //         onPressed: () {},
                        //         icon: const Icon(
                        //           Icons.add,
                        //           size: 15,
                        //         ),
                        //       ),
                        //     ))
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 40.w,
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          buildtextForm(
                            controller: serviceController.subCategoryName,
                            label: 'Name',
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Enter Name';
                              }
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          buildtextForm(
                            controller: serviceController.id,
                            label: 'Id',
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Enter  ID';
                              }
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: buildtextForm(
                              controller: serviceController.dob,
                              onTap: () {
                                _selectDateTo(context);
                              },
                              label: 'Dote Of Birth',
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Enter Email ID';
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            buildtextForm(
              controller: serviceController.dis,
              maxLines: 7,
              minLines: 7,
              label: 'Discription',
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Enter Email ID';
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Category',
              style: AppFontMain(
                color: AppColorCode.headerColor,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('mainCategory')
                    .orderBy('name')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: const CupertinoActivityIndicator(),
                    );
                  } else {
                    if (setDefaultmainCat) {
                      mainCat = snapshot.data!.docs[0].get('name');
                      debugPrint('setDefault make: $mainCat');
                    }
                    return Container(
                      width: 85.w,
                      child: DropdownButton(
                        style: AppFontMain(
                          color: AppColorCode.ratingColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                        value: mainCat,
                        icon: Container(
                          margin: EdgeInsets.only(top: 0.0, left: 178.0),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColorCode.ratingColor,
                          ),
                        ),
                        items: snapshot.data!.docs.map((items) {
                          return DropdownMenuItem(
                              value: items.get('name'),
                              child: Text(items.get('name')));
                        }).toList(),
                        onChanged: (item) {
                          setState(() {
                            mainCat = item;
                            serviceController.itemMainCat.text =
                                item.toString();
                            setDefaultmainCat = false;
                            setDefaultSubCat = true;
                          });
                        },
                      ),
                    );
                  }
                }),
            SizedBox(
              height: 10,
            ),
            Text(
              'Category',
              style: AppFontMain(
                color: AppColorCode.headerColor,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              width: 85.w,
              child: mainCat != null
                  ? StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('subCategory')
                          .where('parent_name', isEqualTo: mainCat)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          debugPrint('snapshot status: ${snapshot.error}');
                          return Container(
                            child: Text(
                                'snapshot empty carMake: $mainCat makeModel: $subCat'),
                          );
                        }
                        if (setDefaultSubCat) {
                          subCat = snapshot.data!.docs[0].get('name');
                          debugPrint('setDefault makeModel: $subCat');
                        }
                        return DropdownButton(
                          style: AppFontMain(
                            color: AppColorCode.ratingColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                          value: subCat,
                          icon: Container(
                            margin: EdgeInsets.only(top: 0.0, left: 178.0),
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColorCode.ratingColor,
                            ),
                          ),
                          items: snapshot.data!.docs.map((items) {
                            return DropdownMenuItem(
                                value: items.get('name'),
                                child: Text(items.get('name')));
                          }).toList(),
                          onChanged: (items) {
                            setState(() {
                              subCat = items;
                              serviceController.itemSubCat.text =
                                  items.toString();
                              setDefaultSubCat = false;
                            });
                          },
                        );
                      })
                  : Container(
                      child: Text(
                          'carMake null carMake: $mainCat makeModel: $subCat'),
                    ),
            ),
            SizedBox(
              height: 30,
            ),
            button(
              label: 'SUBMIT ',
              height: size.height * 0.07,
              width: size.width,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  serviceController
                      .addToSubCategory(widget.category!.id.toString());
                  // Get.offAll(() => MainHomeHolder());
                }
              },
            )
          ]),
        ),
      )
    ])));
  }
}
