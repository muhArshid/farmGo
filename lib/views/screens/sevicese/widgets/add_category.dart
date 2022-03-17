import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/views/widgets/button_icons_widgets.dart';
import 'package:farmapp/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:firebase_picture_uploader/firebase_picture_uploader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class AddMainCategorys extends StatefulWidget {
  @override
  State<AddMainCategorys> createState() => _AddMainCategorysState();
}

class _AddMainCategorysState extends State<AddMainCategorys> {
  List<UploadJob>? _profilePictures = [];
  FirebaseStorage storage = FirebaseStorage.instance;

  void profilePictureCallback(
      {List<UploadJob>? uploadJobs, bool? pictureUploadProcessing}) {
    _profilePictures = uploadJobs;
  }

  bool isLoading = true;
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

  // Retriew the uploaded images
  // This function is called when the app launches for the first time or when an image is uploaded or deleted
  Future<List<Map<String, dynamic>>> _loadImages() async {
    List<Map<String, dynamic>> files = [];

    final ListResult result = await storage.ref().list();
    final List<Reference> allFiles = result.items;

    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      final FullMetadata fileMeta = await file.getMetadata();
      files.add({
        "url": fileUrl,
        "path": file.fullPath,
        "uploaded_by": fileMeta.customMetadata?['uploaded_by'] ?? 'Nobody',
        "description":
            fileMeta.customMetadata?['description'] ?? 'No description'
      });
    });

    return files;
  }

  // Delete the selected image
  // This function is called when a trash icon is pressed
  Future<void> _delete(String ref) async {
    await storage.ref(ref).delete();
    // Rebuild the UI
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        ListView(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: CustomText(
                text: 'Add_Farm'.tr,
                size: 24,
                weight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            buildtextForm(
              controller: serviceController.categorName,
              label: 'Name'.tr,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Enter_Name'.tr;
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () => _upload('camera'),
                    icon: Icon(Icons.camera),
                    label: Text('Camera'.tr)),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () => _upload('gallery'),
                    icon: Icon(Icons.library_add),
                    label: Text('Gallery'.tr)),
              ],
            ),
            imageFile != null
                ? Container(
                    width: 30.w,
                    height: 40.h,
                    child: Image.file(imageFile!, fit: BoxFit.fill),
                    decoration: BoxDecoration(
                        borderRadius: new BorderRadius.circular(15)))
                : Center(
                    child: CustomText(
                      text: 'Please_select_image'.tr,
                      size: 14,
                      weight: FontWeight.bold,
                    ),
                  ),
            SizedBox(
              height: 20,
            ),
            isLoading
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: button(
                      label: 'SUBMIT'.tr,
                      height: 30,
                      width: 20,
                      onTap: () {
                        if (imageFile != null) {
                          setState(() {
                            isLoading = false;
                          });
                          //  showLoading();
                          serviceController.addToCategory(
                              serviceController.categorName.text,
                              imageFile!,
                              fileName!);
                        } else {
                          Get.snackbar("Please_select_image".tr, "");
                        }
                      },
                    ),
                  )
                : loadingButton(
                    label: ' ',
                    height: size.height * 0.07,
                    width: size.width,
                    onTap: () {},
                  )
          ],
        ),
      ],
    );
  }
}
