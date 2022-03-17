import 'dart:io';
import 'package:farmapp/model/core/category_item.dart';
import 'package:farmapp/views/screens/home/main_home_holder.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmapp/constants/app_constants.dart';
import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/constants/firebase.dart';
import 'package:farmapp/model/core/sub_category_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';

class ServiceContoller extends GetxController {
  static ServiceContoller instance = Get.find();
  String usersItemCollection = "items";
  TextEditingController amount = TextEditingController();
  TextEditingController amountCondent = TextEditingController();
  TextEditingController categorName = TextEditingController();
  TextEditingController subCategoryName = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController itemMainCat = TextEditingController();
  TextEditingController itemSubCat = TextEditingController();
  TextEditingController dis = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController updateDis = TextEditingController();

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
    if (auth.currentUser!.uid != null) {
      mainCatList.bindStream(todoStream());
    }

    super.onReady();
  }

  void getMyData() {
    mainCatList.bindStream(todoStream());
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
        _data.add(MainCategoryItemModel.fromMap(
            element.data() as Map<String, dynamic>));
      });
      return _data;
      //
    });
  }

  bool isItemAlreadyAdded(String productName) =>
      userController.userModel.value.mainCategory!
          .where((item) => item.name == productName)
          .isNotEmpty;

  void addToCategory(String catogory, File imageFile, String fileName) async {
    try {
      String? downloadUrl;

      try {
        // Uploading the selected image with some custom meta data
        TaskSnapshot data = await storage
            .ref()
            .child('mainImage/$fileName')
            .putFile(
                imageFile,
                SettableMetadata(customMetadata: {
                  'uploaded_by': 'main_cat',
                  'description': 'cat_image'
                }));
        downloadUrl = await data.ref.getDownloadURL();
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
        "downloadUrl": downloadUrl,
        "expense": "0",
        "profite": "0",
        "losse": "0"
      }, id);
      Get.snackbar("Item added", "$catogory was added to your catogory");
      _clearControllers();
      Get.offAll(() => MainHomeHolder(currentIndex: 1));
    } catch (e) {
      Get.snackbar('Error'.tr, 'Cannot_add_item'.tr);
    }
  }

  void upateprofile(File imageFile, String fileName, String oldfile) async {
    try {
      String? downloadUrl;

      try {
        // Uploading the selected image with some custom meta data
        TaskSnapshot data =
            await storage.ref().child('profileImage/$fileName').putFile(
                imageFile,
                SettableMetadata(customMetadata: {
                  'uploaded_by': userController.userModel.value.id!,
                  'description': 'profile_image'
                }));
        downloadUrl = await data.ref.getDownloadURL();
        // Refresh the UI
      } on FirebaseException catch (error) {
        print(error);
      }
      firebaseFirestore.collection('users').doc(auth.currentUser!.uid).update(
        {
          'profile_image': downloadUrl,
        },
      ).then((_) {
        serviceController.deleteImageFromDB(oldfile);
        Get.snackbar("Upadated", "  Updated to Profile Image");
      }).catchError((error) => print('Update failed: $error'));
    } catch (e) {
      Get.snackbar('Error'.tr, 'Cannot_add_item'.tr);
      debugPrint(e.toString());
    }
  }

  Future<String> uploadImage(File file, String path) async {
    String? downloadUrl;

    try {
      // Uploading the selected image with some custom meta data
      TaskSnapshot data = await storage.ref().child(path).putFile(
          file,
          SettableMetadata(customMetadata: {
            'uploaded_by': userController.userModel.value.id!,
            'description': 'path'
          }));
      downloadUrl = await data.ref.getDownloadURL();
      // Refresh the UI
    } on FirebaseException catch (error) {
      print(error);
    }

    return downloadUrl!;
  }

  void updateName() {
    userController.userModel.value.name = name.text;
    firebaseFirestore.collection('users').doc(auth.currentUser!.uid).update(
      {
        'name': name.text,
      },
    ).then((_) {
      Get.snackbar('Upadated'.tr, 'Updated_Profile_Name'.tr);
      Get.offAll(() => MainHomeHolder(
            currentIndex: 1,
          ));
    }).catchError((error) => print('Update failed: $error'));
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
      var uuid = Uuid();
      var paymentId = uuid.v1();
      userController.updateUserPaymentSet({
        'paymentId': paymentId,
        'content': amountCondent.text,
        'amount': amount.text,
        'createdon': Timestamp.now(),
        'status': true,
      }, data.id!, paymentId);
      Get.snackbar('Upadated'.tr, 'was_Updated_arm'.tr);
      amount.clear();
      amountCondent.clear();
      Get.offAll(() => MainHomeHolder(
            currentIndex: 1,
          ));
    }).catchError((error) => print('Update failed: $error'));
  }

  void deleteMainCategory(MainCategoryItemModel category) {
    try {
      firebaseFirestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('MainCategory')
          .doc(category.id)
          .delete();
      Get.snackbar("Deleted", "Successfuly");
      deleteImageFromDB(category.downloadUrl!);
      _clearControllers();
      Get.offAll(MainHomeHolder(
        currentIndex: 1,
      ));
    } catch (e) {
      Get.snackbar('Error'.tr, "");
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
        final item = (snap.data() as Map<String, dynamic>)[ITEMS];

        return SubCategoryItemModel(
          name: item['name'],
          image: item['imageUrl'],
        );
      }).toList();

  Future fetchNextItemWithId(String id) async {
    _errorMessage = '';
    _isFetchingUsers = true;
    itemModelList.bindStream(getitemList(id));

    _isFetchingUsers = false;
  }

  TextEditingController editingController = TextEditingController();
  Future fetchNextItemWitName(String id) async {
    _errorMessage = '';
    _isFetchingUsers = true;
    itemModelList.bindStream(getitemList(id));

    _isFetchingUsers = false;
  }

  Future<void> deleteImageFromDB(String imageUrl) async {
    Reference photoRef = await FirebaseStorage.instance.refFromURL(imageUrl);
    await photoRef.delete().then((value) {});
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
        _data.add(SubCategoryItemModel.fromMap(
            element.data() as Map<String, dynamic>));
      });
      print('Total message fetched: ${_data.length}');
      return _data;
      //
    });
  }

  // Stream<List<SubCategoryItemModel>> getSerchitemList(String id) {
  //   return firebaseFirestore
  //       .collection('users')
  //       .doc(auth.currentUser!.uid)
  //       .collection('MainCategory')
  //       .doc(id)
  //       .collection('items').where(field)
  //       .snapshots()
  //       .map((QuerySnapshot querysnapshot) {
  //     List<SubCategoryItemModel> _data = [];
  //     querysnapshot.docs.forEach((element) {
  //       _data.add(SubCategoryItemModel.fromMap(
  //           element.data() as Map<String, dynamic>));
  //     });
  //     print('Total message fetched: ${_data.length}');
  //     return _data;
  //     //
  //   });
  // }

  void addToItem(String parentId, File imageFile, String fileName) async {
    try {
      String? downloadUrl;

      try {
        // Uploading the selected image with some custom meta data

        TaskSnapshot data = await storage.ref().child('item/$fileName').putFile(
            imageFile,
            SettableMetadata(customMetadata: {
              'uploaded_by': 'item',
              'description': 'item_image'
            }));
        print(data);
        // Refresh the UI
        downloadUrl = await data.ref.getDownloadURL();
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
        "image": 'item/$fileName',
        "downloadUrl": downloadUrl,
        "join_date": dateFormat
      }, parentId, itemId);
      Get.snackbar("Item added", " was added to your catogory");
      _clearAddCatControllers();
      Get.offAll(MainHomeHolder(
        currentIndex: 1,
      ));
      //   }
    } catch (e) {
      Get.snackbar("Error", "Cannot add this item");
      debugPrint(e.toString());
    }
  }

  void updateItem(String documentId, String id) {
    firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('MainCategory')
        .doc(documentId)
        .collection('items')
        .doc(id)
        .update(
      {
        'dis': updateDis.text,
      },
    ).then((_) {
      Get.snackbar("Upadated", "  Updated to Profile Image");
    }).catchError((error) => print('Update failed: $error'));
  }

  void deleteItem(String documentId, String id) {
    firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('MainCategory')
        .doc(documentId)
        .collection('items')
        .doc(id)
        .delete();
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

  Future<String> getImageUrl(BuildContext context, String image) async {
    String? m;
    await serviceController.loadFromStorage(context, image).then((downloadUrl) {
      m = downloadUrl.toString();
    });

    return m!;
  }

  Future<dynamic> loadFromStorage(BuildContext context, String image) async {
    try {
      var url =
          await FirebaseStorage.instance.ref().child(image).getDownloadURL();
      return url;
    } on Exception {
      print("Oops! The file was not found");
    }
  }
}
//mainImage/$image