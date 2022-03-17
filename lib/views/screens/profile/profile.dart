import 'dart:io';
import 'package:farmapp/views/screens/profile/settings.dart';
import 'package:path/path.dart' as path;
import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/controller/profile_controller.dart';
import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:farmapp/views/screens/profile/widgets/show_my_post.dart';
import 'package:farmapp/views/widgets/custom_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileContoller ctr = Get.put(ProfileContoller());
  final GlobalKey _menuKey = new GlobalKey();
  String? fileName;
  File? imageFile;
  bool isloading = false;
  bool isEdit = false;
  bool isNameEdit = false;
  @override
  void initState() {
    // TODO: implement initState
    ctr.getMyPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileContoller>(builder: (ct) {
      return Scaffold(
          body: ListView(
        children: [
          Container(
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    child: userController.userModel.value.profileImage != null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 70,
                                backgroundImage: imageFile == null
                                    ? NetworkImage(userController
                                        .userModel.value.profileImage!)
                                    : FileImage(imageFile!) as ImageProvider,
                                backgroundColor: AppColorCode.pureWhite,
                              ),
                              Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColorCode.brandColor,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: PopupMenuButton(
                                        key: _menuKey,
                                        itemBuilder: (_) =>
                                            <PopupMenuItem<String>>[
                                              new PopupMenuItem<String>(
                                                  child: Text('Gallery'.tr),
                                                  value: 'g'),
                                              new PopupMenuItem<String>(
                                                  child: Text('Camera'.tr),
                                                  value: 'c'),
                                            ],
                                        onSelected: (val) async {
                                          final picker = ImagePicker();
                                          PickedFile? pickedImage;
                                          pickedImage = await picker.getImage(
                                              source: val == 'c'
                                                  ? ImageSource.camera
                                                  : ImageSource.gallery,
                                              maxWidth: 1920);

                                          fileName =
                                              path.basename(pickedImage!.path);
                                          imageFile = File(pickedImage.path);

                                          serviceController.upateprofile(
                                              imageFile!,
                                              fileName!,
                                              userController.userModel.value
                                                  .profileImage!);

                                          setState(() {
                                            isEdit = true;
                                          });
                                        },
                                        child: Text(
                                          'Change_Profile'.tr,
                                          style: AppFontMain(
                                            color: AppColorCode.pureWhite,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        )),
                                  ),
                                ),
                              )
                            ],
                          )
                        : CircularProgressIndicator.adaptive(),
                    height: 30.h,
                    width: 100.w,
                    decoration: BoxDecoration(color: AppColorCode.brandColor),
                  ),
                ),
                Positioned(
                    right: 10,
                    bottom: 150,
                    left: 320,
                    top: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          var dialog = CustomAlertDialog(
                              title: 'Logout'.tr,
                              message: 'want_logout'.tr,
                              onPostivePressed: () {
                                userController.signOut();
                              },
                              positiveBtnText: 'Yes'.tr,
                              negativeBtnText: 'No'.tr);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => dialog);
                        },
                        child: Icon(
                          Icons.logout_outlined,
                          color: AppColorCode.pureWhite,
                          size: 25,
                        ),
                      ),
                    )),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My_Posts'.tr,
                  style: AppFontMain(
                    color: AppColorCode.headerColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => SettingScreen());
                  },
                  child: Icon(
                    Icons.settings,
                    color: AppColorCode.brandColor,
                    size: 25,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // if (ctr.apiLoading!.value)
          //   Center(child: CircularProgressIndicator.adaptive()),
          Container(
              height: ct.myPosts!.length * 300,
              width: 100.w,
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: ct.myPosts!.length,
                  itemBuilder: (context, index) {
                    return MyPostWidget(postModel: ct.myPosts![index]);
                  })),
        ],
      ));
    });
  }
}
