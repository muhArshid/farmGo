import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/constants/firebase.dart';
import 'package:farmapp/model/core/post_model.dart';
import 'package:farmapp/views/screens/profile/explore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ProfileContoller extends GetxController {
  static ProfileContoller instance = Get.find();
  Rxn<List<PostModel>> postModel = Rxn<List<PostModel>>([]);
  List<PostModel>? get posts => postModel.value;
  String postCollection = "posts";

  void onReady() {
    postModel.bindStream(postStream());
    super.onReady();
  }

  TextEditingController cotentName = TextEditingController();
  TextEditingController postMainCat = TextEditingController();

  static Stream<List<PostModel>> postStream() {
    return firebaseFirestore
        .collection('posts')
        .snapshots()
        .map((QuerySnapshot querysnapshot) {
      List<PostModel> _data = [];
      querysnapshot.docs.forEach((element) {
        _data.add(PostModel.fromMap(element.data()));
      });
      print('Total message fetched: ${_data.length}');
      return _data;
      //
    });
  }

  void addToPost(File imageFile, String fileName) async {
    try {
      try {
        // Uploading the selected image with some custom meta data
        await storage.ref().child('post/$fileName').putFile(
            imageFile,
            SettableMetadata(customMetadata: {
              'uploaded_by': userController.firebaseUser.value!.uid,
              'description': 'post_image'
            }));

        // Refresh the UI
      } on FirebaseException catch (error) {
        print(error);
      }
      var uuid = Uuid();
      String id = uuid.v1();
      var now = new DateTime.now();
      var formatter = new DateFormat('yyyy-MM-dd');
      String formattedDate = formatter.format(now);
      userController.addPostData({
        "id": id,
        "content": profileController.cotentName.text,
        "mainCat": profileController.postMainCat.text,
        "image": fileName,
        "userId": userController.firebaseUser.value!.uid,
        "fav": [],
        "status": true,
        "uploadDate": formattedDate
      }, id);
      Get.snackbar("Post added", "  added to your post");
      Get.to(ExploreScreen());
    } catch (e) {
      Get.snackbar("Error", "Cannot add this item");
      debugPrint(e.toString());
    }
  }
}
