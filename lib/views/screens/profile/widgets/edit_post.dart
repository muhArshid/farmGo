import 'dart:io';

import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/model/core/post_model.dart';
import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/views/widgets/button_icons_widgets.dart';
import 'package:farmapp/views/widgets/custom_modal.dart';
import 'package:farmapp/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:path/path.dart' as path;

class EditPostWidget extends StatefulWidget {
  EditPostWidget({Key? key, this.postModel}) : super(key: key);
  final PostModel? postModel;

  @override
  State<EditPostWidget> createState() => _EditPostWidgetState();
}

class _EditPostWidgetState extends State<EditPostWidget> {
  String? fileName;
  File? imageFile;
  Future<void> _upload(String inputSource) async {
    final picker = ImagePicker();
    PickedFile? pickedImage;
    try {
      pickedImage = await picker.getImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);

      fileName = path.basename(pickedImage!.path);
      setState(() {
        imageFile = File(pickedImage!.path);
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    profileController.cotentName.text = widget.postModel!.content.toString();
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Center(
              child: CustomText(
                text: 'Edit_Post'.tr,
                size: 24,
                weight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    var dialog = CustomAlertDialog(
                        title: 'Delete'.tr,
                        message: 'want_delete'.tr,
                        onPostivePressed: () {
                          profileController.deletePost(widget.postModel!);
                          Get.back();
                        },
                        positiveBtnText: 'Yes'.tr,
                        negativeBtnText: 'No'.tr);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => dialog);
                  },
                  child: Icon(
                    Icons.delete,
                    color: AppColorCode.redColor,
                  ),
                )
              ],
            ),
            buildtextForm(
              controller: profileController.cotentName,
              label: 'Description'.tr,
              maxLines: 5,
              minLines: 5,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Enter_Description';
                }
              },
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: 80.w,
              height: 30.h,
              decoration: BoxDecoration(
                //   color: AppColorCode.brandColor,
                borderRadius: BorderRadiusDirectional.circular(10),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(widget.postModel!.downloadUrl!)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                    onPressed: () => _upload('camera'),
                    icon: Icon(Icons.camera),
                    label: Text('Camera'.tr)),
                ElevatedButton.icon(
                    onPressed: () => _upload('gallery'),
                    icon: Icon(Icons.library_add),
                    label: Text('Gallery'.tr)),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            button(
                label: 'SUBMIT'.tr,
                height: 5.h,
                width: 20.w,
                onTap: () {
                  Get.back();
                })
          ],
        ),
      ),
    ));
  }
}
