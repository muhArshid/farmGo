import 'dart:io';
import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:farmapp/utils/helper/showLoading.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/views/widgets/button_icons_widgets.dart';
import 'package:farmapp/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:firebase_picture_uploader/firebase_picture_uploader.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class AddPostScreen extends StatefulWidget {
  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  List<UploadJob>? _profilePictures = [];
  FirebaseStorage storage = FirebaseStorage.instance;
  var setDefaultmainCat = true, setDefaultSubCat = true;
  final _formKey = GlobalKey<FormState>();
  var mainCat;
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            children: [
              SizedBox(
                height: 10,
              ),
              Center(
                child: CustomText(
                  text: "Add Post ",
                  size: 24,
                  weight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              buildtextForm(
                controller: profileController.cotentName,
                label: 'Description',
                maxLines: 5,
                minLines: 5,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Enter Description';
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Item Category',
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
                        //  mainCat = snapshot.data!.docs[0].get('name');
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
                              profileController.postMainCat.text =
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                      onPressed: () => _upload('camera'),
                      icon: Icon(Icons.camera),
                      label: Text('camera')),
                  ElevatedButton.icon(
                      onPressed: () => _upload('gallery'),
                      icon: Icon(Icons.library_add),
                      label: Text('Gallery')),
                ],
              ),
              imageFile != null
                  ? Container(
                      width: 30.w,
                      height: 40.h,
                      child: Image.file(imageFile!, fit: BoxFit.fill),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                      ))
                  : Center(
                      child: CustomText(
                        text: "Please select image",
                        size: 14,
                        weight: FontWeight.bold,
                      ),
                    ),
              SizedBox(
                height: 20,
              ),
              isLoading
                  ? button(
                      label: 'SUBMIT ',
                      height: 30,
                      width: 20,
                      onTap: () {
                        if (imageFile != null) {
                          if (_formKey.currentState!.validate()) {
                            showLoading();
                            profileController.addToPost(imageFile!, fileName!);
                          }
                        } else {
                          Get.snackbar("Please select Post Category", "");
                        }
                      },
                    )
                  : Container()
            ],
          ),
        ),
      ],
    );
  }
}
