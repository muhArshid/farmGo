import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/constants/firebase.dart';
import 'package:farmapp/model/core/post_model.dart';
import 'package:farmapp/service/API/genaral_api.dart';
import 'package:farmapp/views/screens/home/main_home_holder.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ProfileContoller extends GetxController {
  static ProfileContoller instance = Get.find();
  Rxn<List<PostModel>> postModel = Rxn<List<PostModel>>([]);
  List<PostModel>? get posts => postModel.value;
  Rxn<List<PostModel>> mypostModel = Rxn<List<PostModel>>([]);
  List<PostModel>? get myPosts => mypostModel.value;
  String postCollection = "posts";

  void onReady() {
    postModel.bindStream(postStream(2));
    mypostModel.bindStream(mypostStream());
    super.onReady();
  }

  addData(int limit) {
    postModel.bindStream(postStream(limit));
  }

  TextEditingController cotentName = TextEditingController();
  TextEditingController postMainCat = TextEditingController();

  DocumentSnapshot?
      lastDocument; // flag for last document from where next 10 records to b
  Stream<List<PostModel>> postStream(int limit) {
    List<PostModel> _data = [];
    if (posts!.isEmpty) {
      return firebaseFirestore
          .collection('posts')
          .orderBy('uploadDate')
          .limit(limit)
          .snapshots()
          .map((QuerySnapshot querysnapshot) {
        querysnapshot.docs.forEach((element) {
          _data.add(PostModel.fromMap(element.data() as Map<String, dynamic>));
          lastDocument = querysnapshot.docs[querysnapshot.docs.length - 1];
        });
        print('Total message fetched: ${_data.length}');
        return _data;
        //
      });
    } else {
      return firebaseFirestore
          .collection('posts')
          .orderBy('uploadDate')
          .startAfterDocument(lastDocument!)
          .limit(limit)
          .snapshots()
          .map((QuerySnapshot querysnapshot) {
        List<PostModel> data = [];
        querysnapshot.docs.forEach((element) {
          lastDocument = querysnapshot.docs[querysnapshot.docs.length - 1];
          data.add(PostModel.fromMap(element.data() as Map<String, dynamic>));
        });
        print('Total message fetched: ${_data.length}');
        return _data + data;
        //
      });
    }
  }

  void deletePost(PostModel data) {
    try {
      firebaseFirestore
          .collection('posts')
          .doc(auth.currentUser!.uid)
          .collection('MainCategory')
          .doc(data.id)
          .delete();
      Get.snackbar("Deleted", "Succfuly");
      //  _clearControllers();
      serviceController.deleteImageFromDB(data.downloadUrl!);
      Get.offAll(MainHomeHolder(
        currentIndex: 1,
      ));
    } catch (e) {
      Get.snackbar("Error", "Cannot add this item");
      debugPrint(e.toString());
    }
  }

  RxBool? apiLoading = true.obs;
  void getMyPost() {
    //  mypostModel.bindStream(mypostStream());
  }

  Stream<List<PostModel>> mypostStream() {
    return firebaseFirestore
        .collection('posts')
        .where("userId", isEqualTo: userController.userModel.value.id)
        .snapshots()
        .map((QuerySnapshot querysnapshot) {
      List<PostModel> _data = [];
      querysnapshot.docs.forEach((element) {
        _data.add(PostModel.fromMap(element.data() as Map<String, dynamic>));
      });
      print('Total message fetched: ${_data.length}');
      apiLoading = false.obs;
      return _data;
      //
    });
  }

  void addToPost(File imageFile, String fileName) async {
    try {
      String? downloadUrl;
      try {
        // Uploading the selected image with some custom meta data
        TaskSnapshot data = await storage.ref().child('post/$fileName').putFile(
            imageFile,
            SettableMetadata(customMetadata: {
              'uploaded_by': userController.firebaseUser.value!.uid,
              'description': 'post_image'
            }));
        print(data);
        downloadUrl = await data.ref.getDownloadURL();
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
        "downloadUrl": downloadUrl,
        "ProfileUrl": userController.userModel.value.profileImage,
        "userId": userController.firebaseUser.value!.uid,
        "fav": [],
        "status": true,
        "uploadDate": formattedDate
      }, id);
      Get.snackbar("Post added", "  added to your post");
      profileController.cotentName.clear();
      profileController.postMainCat.clear();
      Get.to(MainHomeHolder(
        currentIndex: 2,
      ));
    } catch (e) {
      Get.snackbar("Error", "Cannot add this item");
      debugPrint(e.toString());
    }
  }

  updateStatus(bool isDone, documentId) {
    firebaseFirestore
        .collection('post')
        .doc(auth.currentUser!.uid)
        .collection('todos')
        .doc(documentId)
        .update(
      {
        'isDone': isDone,
      },
    );
  }

  void addFavToPost(String id) {
    try {
      userController.updatePostData({
        "fav": FieldValue.arrayUnion([
          {"id": userController.userModel.value.id}
        ])
      }, id);
    } catch (e) {
      Get.snackbar('Error'.tr, 'Cannot_add_item'.tr);
      debugPrint(e.toString());
    }
  }

  void removeFavList(FavModel? fav, String id) {
    try {
      userController.updatePostData({
        "fav": FieldValue.arrayRemove([fav!.toJson()])
      }, id);
    } catch (e) {
      //    Get.snackbar("Error", "Cannot remove this item");
      //debugPrint(e.message);
    }
  }
}
