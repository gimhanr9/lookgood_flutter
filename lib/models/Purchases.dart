
class Purchases{
  String id,productId,imageUrl,productName,size;
  int quantity;
  double price;
  bool isRated;

  Purchases({
    this.id,
    this.productId,
    this.imageUrl,
    this.productName,
    this.size,
    this.quantity,
    this.price,
    this.isRated});

  Map toMap(Purchases purchases) {
    var data = Map<String, dynamic>();

    data["productId"] = purchases.productId;
    data["imageUrl"] = purchases.imageUrl;
    data["productName"] = purchases.productName;
    data["size"] = purchases.size;
    data["quantity"] = purchases.quantity;
    data["price"] = purchases.price;
    data["isRated"] = purchases.isRated;

    return data;
  }

  Purchases.fromMap(key,Map<dynamic, dynamic> mapData) {
    this.id = key;
    this.productId = mapData["productId"];
    this.imageUrl=mapData["imageUrl"];
    this.productName = mapData["productName"];
    this.size = mapData["size"];
    this.quantity = mapData["quantity"];
    this.price = mapData["price"].toDouble();
    this.isRated = mapData["isRated"];
  }

}