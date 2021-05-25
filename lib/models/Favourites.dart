

class Favourites {
  String productId,imageUrl,productName,productTitle;
  double price;

  Favourites({this.imageUrl, this.productName,
      this.productTitle, this.price, this.productId});

  Map toMap(Favourites favourite) {
    var data = Map<String, dynamic>();

    data["imageUrl"] = favourite.imageUrl;
    data["productName"] = favourite.productName;
    data["productTitle"] = favourite.productTitle;
    data["price"] = favourite.price;

    return data;
  }

  Favourites.fromMap(key,Map<dynamic, dynamic> mapData) {
    this.imageUrl = mapData["imageUrl"];
    this.productId = key;
    this.productName = mapData["productName"];
    this.productTitle = mapData["productTitle"];
    this.price = mapData["price"].toDouble();

  }




}