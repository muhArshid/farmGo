import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  static const ID = "id";
  static const IMAGE = "image";
  static const IMAGEURL = "downloadUrl";
  static const PROFILEURL = "ProfileUrl";
  static const STATUS = "status";
  static const UPD = "uploadDate";
  static const UID = "userId";
  static const CON = "content";
  static const FAVLIST = "fav";

  String? id;
  String? image;
  String? downloadUrl;
  String? ProfileUrl;
  String? content;
  String? userId;
  bool? status;
  List<FavModel>? fav;
  PostModel(
      {this.id,
      this.status,
      this.image,
      this.downloadUrl,
      this.ProfileUrl,
      this.content,
      this.userId,
      this.fav});
  PostModel.fromMap(Map<String, dynamic> data) {
    id = data[ID];
    content = data[CON];
    image = data[IMAGE];
    downloadUrl = data[IMAGEURL];
    ProfileUrl = data[PROFILEURL];
    userId = data[UID];
    status = data[STATUS];
    fav = _convertFav(data[FAVLIST] ?? []);
  }
  Map<String, Object?> toJson() =>
      {ID: id, IMAGEURL: downloadUrl, CON: content};
  PostModel.fromSnapshot(DocumentSnapshot snapshot) {
    image = (snapshot.data() as Map<String, dynamic>)[IMAGE];
    downloadUrl = (snapshot.data() as Map<String, dynamic>)[IMAGEURL];
    ProfileUrl = (snapshot.data() as Map<String, dynamic>)[PROFILEURL];
    content = (snapshot.data() as Map<String, dynamic>)[CON];
    id = (snapshot.data() as Map<String, dynamic>)[ID];
    userId = (snapshot.data() as Map<String, dynamic>)[UID];
    fav = _convertFav((snapshot.data() as Map<String, dynamic>)[FAVLIST]);
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
