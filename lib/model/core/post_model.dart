import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmapp/model/core/cart_item.dart';
import 'package:farmapp/model/core/category_item.dart';
import 'package:farmapp/model/core/sub_category_item.dart';

class PostModel {
  static const ID = "id";
  static const IMAGE = "image";
  static const STATUS = "status";
  static const UPD = "uploadDate";
  static const UID = "userId";
  static const CON = "content";
  static const FAVLIST = "fav";

  String? id;
  String? image;
  String? content;
  String? userId;
  bool? status;
  List<FavModel>? fav;
  PostModel(
      {this.id, this.status, this.image, this.content, this.userId, this.fav});
  PostModel.fromMap(Map<String, dynamic> data) {
    id = data[ID];
    content = data[CON];
    image = data[IMAGE];
    userId = data[UID];
    status = data[STATUS];
    fav = _convertFav(data[FAVLIST] ?? []);
  }
  PostModel.fromSnapshot(DocumentSnapshot snapshot) {
    image = snapshot.data()![IMAGE];
    content = snapshot.data()![CON];
    id = snapshot.data()![ID];
    userId = snapshot.data()![UID];
    fav = _convertFav(snapshot.data()![FAVLIST] ?? []);
  }
  List<FavModel> _convertFav(List cartFomDb) {
    List<FavModel> _result = [];
    if (cartFomDb.length > 0) {
      cartFomDb.forEach((element) {
        _result.add(FavModel.fromMap(element));
      });
    }
    return _result;
  }

  List cartItemsToJson() => fav!.map((item) => item.toJson()).toList();
}

class FavModel {
  static const ID = "id";

  String? id;

  FavModel({
    this.id,
  });

  FavModel.fromMap(Map<String, dynamic> data) {
    id = data[ID];
  }

  Map toJson() => {
        ID: id,
      };
}
