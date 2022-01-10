import 'dart:io';
import 'package:farmapp/model/core/category_item.dart';
import 'package:farmapp/views/screens/home/main_home_holder.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmapp/constants/app_constants.dart';
import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/constants/firebase.dart';
import 'package:farmapp/controller/auth_controller.dart';
import 'package:farmapp/model/core/item.dart';
import 'package:farmapp/model/core/sub_category_item.dart';
import 'package:farmapp/views/screens/sevicese/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ServiceContoller extends GetxController {
  static ServiceContoller instance = Get.find();
  String usersItemCollection = "items";
  TextEditingController amount = TextEditingController();
  TextEditingController categorName = TextEditingController();
  TextEditingController subCategoryName = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController itemMainCat = TextEditingController();
  TextEditingController itemSubCat = TextEditingController();
  TextEditingController dis = TextEditingController();
  UserController _authController = Get.put(UserController());
  Rx<SubCategoryItemModel> itemModel = SubCategoryItemModel().obs;
  Rxn<List<SubCategoryItemModel>> itemModelList =
      Rxn<List<SubCategoryItemModel>>([]);
  MainCategoryItemModel? item;
  Rx<MainCategoryItemModel> mainCatModel = MainCategoryItemModel().obs;
  Rxn<List<MainCategoryItemModel>> mainCatList =
      Rxn<List<MainCategoryItemModel>>([]);
  List<MainCategoryItemModel>? get mainCat => mainCatList.value;
  String usersItemsCollection = "items";
  dynamic isloading = true.obs;
  RxInt alredyAmount = 0.obs;

  void change(String amount) => alredyAmount.value = int.parse(amount);

  void onReady() {
    mainCatList.bindStream(todoStream());
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

  static Stream<List<MainCategoryItemModel>> todoStream() {
    return firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('MainCategory')
        .snapshots()
        .map((QuerySnapshot querysnapshot) {
      List<MainCategoryItemModel> _data = [];
      querysnapshot.docs.forEach((element) {
        _data.add(MainCategoryItemModel.fromMap(element.data()));
      });
      print('Total message fetched: ${_data.length}');
      return _data;
      //
    });
  }

  bool isItemAlreadyAdded(String productName) =>
      userController.userModel.value.mainCategory!
          .where((item) => item.name == productName)
          .isNotEmpty;

  bool _isItemAlreadySubAdded(String productName) =>
      userController.userModel.value.cart!
          .where((item) => item.productId == productName)
          .isNotEmpty;
  void addToCategory(String catogory, File imageFile, String fileName) async {
    try {
      try {
        // Uploading the selected image with some custom meta data
        await storage.ref().child('mainImage/$fileName').putFile(
            imageFile,
            SettableMetadata(customMetadata: {
              'uploaded_by': 'main_cat',
              'description': 'cat_image'
            }));

        // Refresh the UI
      } on FirebaseException catch (error) {
        print(error);
      }
      var uuid = Uuid();
      String id = uuid.v1();
      userController.updateUserMainCatWithId({
        "id": id,
        "name": catogory,
        "image": fileName,
        "expense": "0",
        "profite": "0",
        "losse": "0"
      }, id);
      Get.snackbar("Item added", "$catogory was added to your catogory");
      _clearControllers();
      Get.to(HomeScreen());
    } catch (e) {
      Get.snackbar("Error", "Cannot add this item");
      debugPrint(e.toString());
    }
  }

  void updateToCategory(MainCategoryItemModel data, String textName) {
    var value = int.parse(amount.text);
    var sum = alredyAmount.value + value;
    firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('MainCategory')
        .doc(data.id)
        .update(
      {
        textName: sum.toString(),
      },
    ).then((_) {
      amount.clear();
      Get.offAll(() => MainHomeHolder());
    }).catchError((error) => print('Update failed: $error'));
  }

  void deleteMainCategory(String documentId) {
    try {
      firebaseFirestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('MainCategory')
          .doc(documentId)
          .delete();
      Get.snackbar("Deleted", "Succfuly");
      _clearControllers();
      Get.offAll(HomeScreen());
    } catch (e) {
      Get.snackbar("Error", "Cannot add this item");
      debugPrint(e.toString());
    }
  }

  void updateToCategorys(MainCategoryItemModel data, String textName) {
    item = data;
    update();
    if (textName == 'expense') {
      item!.expense = amount.text;
      update();
    }
    userController.updateUserData({
      "MainCategory": FieldValue.arrayUnion([item!.toJson()])
    });
  }

  final _usersSnapshot = <DocumentSnapshot>[];
  String _errorMessage = '';
  int documentLimit = 15;
  bool _hasNext = true;
  bool _isFetchingUsers = false;

  String get errorMessage => _errorMessage;

  bool get hasNext => _hasNext;
  static const ITEMS = "items";
  List<SubCategoryItemModel> get items => _usersSnapshot.map((snap) {
        final item = snap.data()![ITEMS] ?? [];

        return SubCategoryItemModel(
          name: item['name'],
          image: item['imageUrl'],
        );
      }).toList();

  Future fetchNextItems(String id) async {
    // if (_isFetchingUsers) return;

    _errorMessage = '';
    _isFetchingUsers = true;
    itemModelList.bindStream(getitemList(id));
    // try {
    //   final snap = await FirebaseApi.getUsers(
    //     id,
    //     documentLimit,
    //     startAfter: _usersSnapshot.isNotEmpty ? _usersSnapshot.last : null,
    //   );
    //   _usersSnapshot.addAll(snap.docs);

    //   if (snap.docs.length < documentLimit) _hasNext = false;
    //   update();
    // } catch (error) {
    //   _errorMessage = error.toString();
    //   update();
    // }

    _isFetchingUsers = false;
  }

  // getitemlist(String id) {
  //   firebaseFirestore
  //       .collection(usersItemCollection)
  //       .doc(id)
  //       .snapshots()
  //       .map((snapshot) => ItemModel.fromSnapshot(snapshot));
  // }

  // Stream<SubCategoryItemModel> getitemeList(String id) => firebaseFirestore
  //     .collection('users')
  //     .doc(auth.currentUser!.uid)
  //     .collection('MainCategory')
  //     .doc(id)
  //     .collection('items')
  //     .doc(id)
  //     .snapshots()
  //     .map((snapshot) => SubCategoryItemModel.fromSnapshot(snapshot));
  Stream<List<SubCategoryItemModel>> getitemList(String id) {
    return firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('MainCategory')
        .doc(id)
        .collection('items')
        .snapshots()
        .map((QuerySnapshot querysnapshot) {
      List<SubCategoryItemModel> _data = [];
      querysnapshot.docs.forEach((element) {
        _data.add(SubCategoryItemModel.fromMap(element.data()));
      });
      print('Total message fetched: ${_data.length}');
      return _data;
      //
    });
  }

  void addToItem(String parentId, File imageFile, String fileName) async {
    try {
      try {
        // Uploading the selected image with some custom meta data
        await storage.ref().child('mainImage/$fileName').putFile(
            imageFile,
            SettableMetadata(customMetadata: {
              'uploaded_by': 'item',
              'description': 'item_image'
            }));

        // Refresh the UI
      } on FirebaseException catch (error) {
        print(error);
      }
      DateTime date = DateTime.now();
      String dateFormat = DateFormat('dd-MM-yyyy hh:mm').format(date);
      var uuid = Uuid();
      var itemId = uuid.v1();
      userController.updateUserItemWithId({
        "id": itemId,
        "tag_id": id.text,
        "parentId": parentId,
        "name": subCategoryName.text,
        "date_of_birth": dob.text,
        "item_main": itemMainCat.text,
        "item_sub": itemSubCat.text,
        "dis": dis.text,
        "image": fileName,
        "join_date": dateFormat
      }, parentId, itemId);
      Get.snackbar("Item added", " was added to your catogory");
      _clearAddCatControllers();
      Get.offAll(HomeScreen());
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

  Future<Widget> getImage(BuildContext context, String image) async {
    Image? m;
    await serviceController.loadFromStorage(context, image).then((downloadUrl) {
      m = Image.network(
        downloadUrl.toString(),
        fit: BoxFit.scaleDown,
      );
    });

    return m!;
  }

  Future<dynamic> loadFromStorage(BuildContext context, String image) async {
    var url =
        await FirebaseStorage.instance.ref().child(image).getDownloadURL();
    return url;
  }
}
//mainImage/$image