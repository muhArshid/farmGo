class CartItemModel {
  static const ID = "id";
  static const IMAGE = "image";
  static const NAME = "name";
  static const QUANTITY = "quantity";
  static const COST = "cost";
  static const PRICE = "price";
  static const PRODUCT_ID = "productId";

  String? id;
  String? image;
  String? name;
  num? quantity;
  String? cost;
  String? productId;
  String? price;

  CartItemModel(
      {this.productId,
      this.id,
      this.image,
      this.name,
      this.quantity,
      this.cost});

  CartItemModel.fromMap(Map<String, dynamic> data) {
    id = data[ID];
    image = data[IMAGE];
    name = data[NAME];
    quantity = data[QUANTITY];
    cost = data[COST];
    productId = data[PRODUCT_ID];
    price = data[PRICE];
  }

  Map toJson() => {
        ID: id,
        PRODUCT_ID: productId,
        IMAGE: image,
        NAME: name,
        QUANTITY: quantity,
        COST: price! * quantity!.toInt(),
        PRICE: price
      };
}
