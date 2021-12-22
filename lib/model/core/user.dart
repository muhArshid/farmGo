import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmapp/model/core/cart_item.dart';
import 'package:farmapp/model/core/category_item.dart';
import 'package:farmapp/model/core/sub_category_item.dart';

class UserModel {
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const CART = "cart";
  static const MAINCATEGORY = "MainCategory";
  static const SUBCATEGORY = "subCategory";

  String? id;
  String? name;
  String? email;
  List<CartItemModel>? cart;
  List<MainCategoryItemModel>? mainCategory;
  List<SubCategoryItemModel>? subCategory;
  UserModel({this.id, this.name, this.email, this.cart, this.mainCategory});

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    name = snapshot.data()![NAME];
    email = snapshot.data()![EMAIL];
    id = snapshot.data()![ID];
    cart = _convertCartItems(snapshot.data()![CART] ?? []);
    mainCategory =
        _convertMainCategoryItems(snapshot.data()![MAINCATEGORY] ?? []);
    subCategory = _convertSubCategoryItems(snapshot.data()![SUBCATEGORY] ?? []);
  }
  List<CartItemModel> _convertCartItems(List cartFomDb) {
    List<CartItemModel> _result = [];
    if (cartFomDb.length > 0) {
      cartFomDb.forEach((element) {
        _result.add(CartItemModel.fromMap(element));
      });
    }
    return _result;
  }

  List<MainCategoryItemModel> _convertMainCategoryItems(List cartFomDb) {
    List<MainCategoryItemModel> _result = [];
    if (cartFomDb.length > 0) {
      cartFomDb.forEach((element) {
        _result.add(MainCategoryItemModel.fromMap(element));
      });
    }
    return _result;
  }

  List<SubCategoryItemModel> _convertSubCategoryItems(List cartFomDb) {
    List<SubCategoryItemModel> _result = [];
    if (cartFomDb.length > 0) {
      cartFomDb.forEach((element) {
        _result.add(SubCategoryItemModel.fromMap(element));
      });
    }
    return _result;
  }

  List cartItemsToJson() => cart!.map((item) => item.toJson()).toList();
  List mainCategoryItemsToJson() =>
      mainCategory!.map((item) => item.toJson()).toList();
  List subCategoryItemsToJson() =>
      mainCategory!.map((item) => item.toJson()).toList();
}
