class MainCategoryItemModel {
  static const ID = "id";
  static const IMAGE = "image";
  static const IMAGEURL = "downloadUrl";
  static const NAME = "name";
  static const EX = "expense";
  static const PRO = "profite";
  static const LOS = "losse";
  String? id;
  String? image;
  String? downloadUrl;
  String? name;
  String? expense;
  String? profite;
  String? losse;
  MainCategoryItemModel(
      {this.id,
      this.image,
      this.downloadUrl,
      this.name,
      this.expense,
      this.profite,
      this.losse});

  MainCategoryItemModel.fromMap(Map<String, dynamic> data) {
    id = data[ID];
    image = data[IMAGE];
    downloadUrl = data[IMAGEURL];
    name = data[NAME];
    expense = data[EX];
    profite = data[PRO];
    losse = data[LOS];
  }

  Map toJson() => {
        ID: id,
        IMAGE: image,
        IMAGEURL: downloadUrl,
        NAME: name,
        EX: expense,
        PRO: profite,
        LOS: losse,
      };
}
