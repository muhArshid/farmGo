import 'dart:io';
import 'package:farmapp/model/core/FamilyData.dart';
import 'package:farmapp/model/core/sub_category_item.dart';
import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:farmapp/utils/Utils.dart';
import 'package:farmapp/views/screens/home/main_home_holder.dart';
import 'package:farmapp/views/screens/sevicese/treeView.dart';
import 'package:farmapp/views/screens/sevicese/widgets/PopUps/NewRecord.dart';
import 'package:farmapp/views/widgets/custom_modal.dart';
import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/views/widgets/button_icons_widgets.dart';
import 'package:farmapp/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class SingleItemView extends StatefulWidget {
  final SubCategoryItemModel? category;
  const SingleItemView({Key? key, this.category}) : super(key: key);
  @override
  State<SingleItemView> createState() => _SingleItemViewState();
}

class _SingleItemViewState extends State<SingleItemView> {
  bool isLoading = true;
  String? fileName;
  File? imageFile;

  @override
  void initState() {
    // TODO: implement initState
    serviceController.updateDis.text = widget.category!.dis!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var image = widget.category!.image!;
    return Stack(
      children: [
        ListView(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => Home());
                  },
                  child: CustomText(
                    text: widget.category!.name!,
                    size: 24,
                    weight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        //   Get.back();
                      },
                      child: Text(
                        'Cancel',
                        style: AppFontMain(
                          color: AppColorCode.brandColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        var name = widget.category!.name;
                        var dialog = CustomAlertDialog(
                            title: "Delete  $name",
                            message: "Are you sure, do you want to Delete ?",
                            onPostivePressed: () {
                              serviceController.deleteItem(
                                  widget.category!.parentId!,
                                  widget.category!.id!);
                              if (mounted) {
                                //      Get.offAll(MainHomeHolder(currentIndex: 1));
                              }
                            },
                            positiveBtnText: 'Yes',
                            negativeBtnText: 'No');
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => dialog);
                      },
                      child: Icon(
                        Icons.delete_sharp,
                        color: AppColorCode.redColor,
                        size: 30,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(widget.category!.downloadUrl!),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(.5),
                        offset: Offset(3, 2),
                        blurRadius: 7)
                  ]),
            ),
            SizedBox(
              height: 10,
            ),
            buildtextForm(
              controller: serviceController.updateDis,
              maxLines: 7,
              minLines: 5,
              label: 'Description',
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Enter category';
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            rowText("Tag Id", widget.category!.tag_id!),
            rowText("DOB", widget.category!.date_of_birth!),
            rowText("Main Category", widget.category!.item_main!),
            rowText("Sub Category", widget.category!.item_sub!),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: button(
                  label: 'Update '.toUpperCase(),
                  height: 30,
                  width: 20,
                  onTap: () {
                    serviceController.updateItem(
                        widget.category!.parentId!, widget.category!.id!);
                    if (mounted) {
                      //     Get.back();
                    }
                  }),
            ),
          ],
        ),
      ],
    );
  }

  Widget rowText(String text1, String text2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomText(
            text: text1,
            size: 14,
            weight: FontWeight.bold,
          ),
          CustomText(
            text: text2,
            size: 12,
            weight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
