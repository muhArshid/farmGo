class MainCategoryItemModel {
  static const ID = "id";
  static const IMAGE = "image";
  static const NAME = "name";

  String? id;
  String? image;
  String? name;

  MainCategoryItemModel({this.id, this.image, this.name});

  MainCategoryItemModel.fromMap(Map<String, dynamic> data) {
    id = data[ID];
    image = data[IMAGE];
    name = data[NAME];
  }

  Map toJson() => {
        ID: id,
        IMAGE: image,
        NAME: name,
      };
}
