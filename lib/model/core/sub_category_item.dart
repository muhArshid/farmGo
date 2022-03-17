class SubCategoryItemModel {
  static const ID = "id";
  static const TAGID = "tag_id";
  static const PARENTID = "parentId";
  static const DOB = "date_of_birth";
  static const IMAGEURL = "downloadUrl";
  static const IMAGE = "image";
  static const NAME = "name";
  static const IMAIN = "item_main";
  static const ISUB = "item_sub";
  static const DIS = "dis";
  static const JOINDATE = "join_date";
  String? id;
  String? tag_id;
  String? parentId;
  String? date_of_birth;
  String? image;
  String? downloadUrl;
  String? name;
  String? item_main;
  String? item_sub;
  String? dis;
  String? join_date;

  SubCategoryItemModel(
      {this.id,
      this.tag_id,
      this.parentId,
      this.date_of_birth,
      this.image,
      this.downloadUrl,
      this.name,
      this.item_main,
      this.item_sub,
      this.dis,
      this.join_date});

  SubCategoryItemModel.fromMap(Map<String, dynamic> data) {
    id = data[ID];
    tag_id = data[TAGID];
    parentId = data[PARENTID];
    date_of_birth = data[DOB];
    image = data[IMAGE];
    downloadUrl = data[IMAGEURL];
    name = data[NAME];
    item_main = data[IMAIN];
    item_sub = data[ISUB];
    dis = data[DIS];
    join_date = data[JOINDATE];
  }

  Map toJson() => {
        ID: id,
        TAGID: tag_id,
        DOB: date_of_birth,
        IMAGE: image,
        NAME: name,
        IMAIN: item_main,
        ISUB: item_sub,
        IMAGE: image,
        IMAGEURL: downloadUrl,
        DIS: dis,
        JOINDATE: join_date,
      };
}
