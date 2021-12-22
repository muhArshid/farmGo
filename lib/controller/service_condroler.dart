import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmapp/constants.dart';
import 'package:farmapp/constants/app_constants.dart';
import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/controller/auth_controller.dart';
import 'package:farmapp/model/core/category_item.dart';
import 'package:farmapp/model/core/item.dart';
import 'package:farmapp/model/core/product.dart';
import 'package:farmapp/model/core/sub_category_item.dart';
import 'package:farmapp/model/core/user.dart';
import 'package:farmapp/service/API/genaral_api.dart';
import 'package:farmapp/views/screens/sevicese/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ServiceContoller extends GetxController {
  static ServiceContoller instance = Get.find();
  String usersItemCollection = "items";
  TextEditingController categorName = TextEditingController();
  TextEditingController subCategoryName = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController itemMainCat = TextEditingController();
  TextEditingController itemSubCat = TextEditingController();
  TextEditingController dis = TextEditingController();
  UserController _authController = Get.put(UserController());
  Rx<ItemModel> itemModel = ItemModel().obs;
  String usersItemsCollection = "items";
  void onReady() {
    super.onReady();
  }

  _clearControllers() {
    categorName.clear();
  }

  _clearAddCatControllers() {
    categorName.clear();
    subCategoryName.clear();
    id.clear();
    dob.clear();
    dis.clear();
  }

  bool _isItemAlreadyAdded(String productName) =>
      userController.userModel.value.cart!
          .where((item) => item.productId == productName)
          .isNotEmpty;
  bool _isItemAlreadySubAdded(String productName) =>
      userController.userModel.value.cart!
          .where((item) => item.productId == productName)
          .isNotEmpty;
  void addToCategory(String catogory) {
    try {
      if (_isItemAlreadyAdded(catogory)) {
        Get.snackbar("Check your cart", "$catogory is already added");
      } else {
        var uuid = Uuid();
        String id = uuid.v1();
        userController.updateUserData({
          "MainCategory": FieldValue.arrayUnion([
            {
              "id": id,
              "name": catogory,
              "image":
                  "https://firebasestorage.googleapis.com/v0/b/gothic-list-230105.appspot.com/o/1.jpeg?alt=media&token=45cc91a6-e064-4d78-9177-a55686034d2c"
            }
          ])
        });
        _addItemToFirestore(id);
        Get.snackbar("Item added", "$catogory was added to your catogory");
        _clearControllers();
        Get.to(HomeScreen());
      }
    } catch (e) {
      Get.snackbar("Error", "Cannot add this item");
      debugPrint(e.toString());
    }
  }

  final _usersSnapshot = <DocumentSnapshot>[];
  String _errorMessage = '';
  int documentLimit = 15;
  bool _hasNext = true;
  bool _isFetchingUsers = false;

  String get errorMessage => _errorMessage;

  bool get hasNext => _hasNext;
  static const ITEMS = "items";
  List<SubCategoryItemModel> get users => _usersSnapshot.map((snap) {
        final user = snap.data()![ITEMS] ?? [];

        return SubCategoryItemModel(
          name: user['name'],
          image: user['imageUrl'],
        );
      }).toList();

  Future fetchNextUsers() async {
    if (_isFetchingUsers) return;

    _errorMessage = '';
    _isFetchingUsers = true;

    try {
      final snap = await FirebaseApi.getUsers(
        documentLimit,
        startAfter: _usersSnapshot.isNotEmpty ? _usersSnapshot.last : null,
      );
      _usersSnapshot.addAll(snap.docs);

      if (snap.docs.length < documentLimit) _hasNext = false;
      update();
    } catch (error) {
      _errorMessage = error.toString();
      update();
    }

    _isFetchingUsers = false;
  }

  getitemlist(String id) {
    firebaseFirestore
        .collection(usersItemCollection)
        .doc(id)
        .snapshots()
        .map((snapshot) => ItemModel.fromSnapshot(snapshot));
  }

  Stream<ItemModel> getItemList(String id) => firebaseFirestore
      .collection(usersItemCollection)
      .doc(id)
      .snapshots()
      .map((snapshot) => ItemModel.fromSnapshot(snapshot));
  void addToSubCategory(String parentId) {
    try {
      // if (_isItemAlreadySubAdded(catogory)) {
      //   Get.snackbar("Check your cart", "$catogory is already added");
      // } else {
      DateTime date = DateTime.now();
      String dateFormat = DateFormat('dd-MM-yyyy hh:mm').format(date);
      var uuid = Uuid();
      updateItemsUserData({
        "items": FieldValue.arrayUnion([
          {
            "id": uuid.v1(),
            "tag_id": id.text,
            "parentId": parentId,
            "name": subCategoryName.text,
            "date_of_birth": dob.text,
            "item_main": itemMainCat.text,
            "item_sub": itemSubCat.text,
            "dis": dis.text,
            "image":
                "https://firebasestorage.googleapis.com/v0/b/gothic-list-230105.appspot.com/o/1.jpeg?alt=media&token=45cc91a6-e064-4d78-9177-a55686034d2c",
            "join_date": dateFormat
          }
        ])
      }, parentId);
      Get.snackbar("Item added", " was added to your catogory");
      _clearAddCatControllers();
      Get.to(HomeScreen());
      //   }
    } catch (e) {
      Get.snackbar("Error", "Cannot add this item");
      debugPrint(e.toString());
    }
  }

  updateItemsUserData(Map<String, dynamic> data, String id) {
    logger.i("UPDATED");
    firebaseFirestore.collection(usersItemsCollection).doc(id).update(data);
  }

  _addItemToFirestore(String parentId) {
    firebaseFirestore.collection(usersItemsCollection).doc(parentId).set({
      "items": [],
    });
  }
}
