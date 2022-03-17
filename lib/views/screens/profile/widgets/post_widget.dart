import 'package:farmapp/constants.dart';
import 'package:farmapp/constants/firebase.dart';
import 'package:farmapp/model/core/post_model.dart';
import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:farmapp/views/screens/profile/widgets/add_post.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:farmapp/views/screens/profile/widgets/show_post.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class PostWidgets extends StatefulWidget {
  PostWidgets({Key? key}) : super(key: key);

  @override
  State<PostWidgets> createState() => _PostWidgetsState();
}

class _PostWidgetsState extends State<PostWidgets> {
  final queryPost = firebaseFirestore
      .collection('posts')
      .orderBy('uploadDate')
      .limit(1)
      .withConverter<PostModel>(
          fromFirestore: (snapshot, _) => PostModel.fromMap(snapshot.data()!),
          toFirestore: (data, _) => data.toJson());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              color: AppColorCode.brandColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Explore'.tr,
                  style: AppFontMain(
                    color: AppColorCode.headerColor,
                    fontSize: 33.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  width: 17,
                ),
                InkWell(
                  onTap: () {
                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                      // Your Code Here
                      Get.to(() => AddPostScreen());
                    });
                  },
                  child: Icon(
                    Icons.add_box_outlined,
                    color: AppColorCode.brandColor,
                    size: 30,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        child: FirestoreListView<PostModel>(
          query: queryPost,
          pageSize: 3,
          itemBuilder: (context, snapshot) {
            final post = snapshot.data();
            return PostWidget(postModel: post);
          },
        ),
      ),
    ));
  }
}
