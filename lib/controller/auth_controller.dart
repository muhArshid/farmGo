import 'package:farmapp/constants/app_constants.dart';
import 'package:farmapp/constants/firebase.dart';
import 'package:farmapp/model/core/user.dart';
import 'package:farmapp/views/screens/auth/login_screen.dart';
import 'package:farmapp/views/screens/home/main_home_holder.dart';
import 'package:farmapp/views/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  late Rx<User?> firebaseUser;
  RxBool isLoggedIn = false.obs;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String usersCollection = "users";
  String usersItemsCollection = "items";
  String usersmainCatCollection = "MainCategory";
  String usersmainCatPayMentCollection = "Payment";
  String postCatCollection = "posts";
  Rx<UserModel> userModel = UserModel().obs;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => (SplashScreen()));
    } else {
      userModel.bindStream(listenToUser());
      Get.offAll(() => MainHomeHolder(
            currentIndex: 1,
          ));
    }
  }

  Future<bool> signIn() async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      print(userCredential);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return false;
      } else if (e.code == 'wrong-password') {
        return false;
      }
      return false;
    }
  }

  Future<bool> signUp() async {
    //   showLoading();
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        String _userId = result.user!.uid;
        _addUserToFirestore(_userId);
        _addUserIemToFirestore(_userId);
        _clearControllers();
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar('Sign_Up_Failed'.tr, e.toString());
      Get.back();
      return false;
    }
  }

  void signOut() async {
    await auth.signOut();
  }

  _addUserToFirestore(String userId) {
    firebaseFirestore.collection(usersCollection).doc(userId).set({
      "name": name.text.trim(),
      "id": userId,
      "email": email.text.trim(),
      "profile_image":
          'https://firebasestorage.googleapis.com/v0/b/gothic-list-230105.appspot.com/o/app%2Fdemy2.png?alt=media&token=50c6d030-a5eb-4f8a-912b-0cd246488086',
      "cart": [],
    });
  }

  _addUserIemToFirestore(String userId) {
    firebaseFirestore
        .collection(usersItemsCollection)
        .doc(userId)
        .set({"subCatid": userId, "items": []});
  }

  _clearControllers() {
    name.clear();
    email.clear();
    password.clear();
  }

  updateUserData(Map<String, dynamic> data) {
    logger.i("UPDATED");
    firebaseFirestore
        .collection(usersCollection)
        .doc(firebaseUser.value!.uid)
        .update(data);
  }

  updatePostData(Map<String, dynamic> data, String id) {
    logger.i("UPDATED");
    firebaseFirestore.collection(postCatCollection).doc(id).update(data);
  }

  addPostData(Map<String, dynamic> data, String id) {
    logger.i("UPDATED");
    firebaseFirestore.collection(postCatCollection).doc(id).set(data);
  }

  updateUserMainCatWithId(Map<String, dynamic> data, String id) {
    logger.i("UPDATED");
    firebaseFirestore
        .collection(usersCollection)
        .doc(firebaseUser.value!.uid)
        .collection(usersmainCatCollection)
        .doc(id)
        .set(data);
  }

  updateUserItemWithId(Map<String, dynamic> data, String id, String itemId) {
    logger.i("UPDATED");
    firebaseFirestore
        .collection(usersCollection)
        .doc(firebaseUser.value!.uid)
        .collection(usersmainCatCollection)
        .doc(id)
        .collection(usersItemsCollection)
        .doc(itemId)
        .set(data);
  }

  updateUserDataSet(Map<String, dynamic> data, String id) {
    logger.i("UPDATED");
    firebaseFirestore
        .collection(usersCollection)
        .doc(firebaseUser.value!.uid)
        .collection(usersmainCatCollection)
        .doc(id)
        .set(data);
  }

  updateUserPaymentSet(Map<String, dynamic> data, String id, String paymentId) {
    logger.i("UPDATED");
    firebaseFirestore
        .collection(usersCollection)
        .doc(firebaseUser.value!.uid)
        .collection(usersmainCatCollection)
        .doc(id)
        .collection(usersmainCatPayMentCollection)
        .doc(paymentId)
        .set(data);
  }

  Stream<UserModel> listenToUser() => firebaseFirestore
      .collection(usersCollection)
      .doc(firebaseUser.value!.uid)
      .snapshots()
      .map((snapshot) => UserModel.fromSnapshot(snapshot));
}
