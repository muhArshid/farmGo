class MainCategoryItemModel {
  static const ID = "id";
  static const IMAGE = "image";
  static const NAME = "name";
  static const EX = "expense";
  static const PRO = "profite";
  static const LOS = "losse";
  String? id;
  String? image;
  String? name;
  String? expense;
  String? profite;
  String? losse;
  MainCategoryItemModel(
      {this.id, this.image, this.name, this.expense, this.profite, this.losse});

  MainCategoryItemModel.fromMap(Map<String, dynamic> data) {
    id = data[ID];
    image = data[IMAGE];
    name = data[NAME];
    expense = data[EX];
    profite = data[PRO];
    losse = data[LOS];
  }

  Map toJson() => {
        ID: id,
        IMAGE: image,
        NAME: name,
        EX: expense,
        PRO: profite,
        LOS: losse,
      };
}
