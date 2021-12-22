import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmapp/model/core/sub_category_item.dart';

class ItemModel {
  static const SUBCATEGORY = "items";

  List<SubCategoryItemModel>? item;
  ItemModel({this.item});

  ItemModel.fromSnapshot(DocumentSnapshot snapshot) {
    item = _convertSubCategoryItems(snapshot.data()![SUBCATEGORY] ?? []);
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

  List itemsToJson() => item!.map((item) => item.toJson()).toList();
}
