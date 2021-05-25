

class Product{
  String imageUrl,id,name,title,description,category,brand;
  double price;
  int small,medium,large,xlarge, xxl;

  Product({
      this.imageUrl,
      this.id,
      this.name,
      this.title,
      this.description,
      this.category,
      this.brand,
      this.price,
      this.small,
      this.medium,
      this.large,
      this.xlarge,
      this.xxl});

  Map toMap(Product product) {
    var data = Map<String, dynamic>();

    data["imageUrl"] = product.imageUrl;
    data["name"] = product.name;
    data["title"] = product.title;
    data["description"] = product.description;
    data["category"] = product.category;
    data["brand"] = product.brand;
    data["price"] = product.price;
    data["small"] = product.small;
    data["medium"] = product.medium;
    data["large"] = product.large;
    data["xlarge"] = product.xlarge;
    data["xxl"] = product.xxl;


    return data;
  }

  Product.fromMap(key,Map<dynamic, dynamic> mapData) {
    this.imageUrl = mapData["imageUrl"];
    this.id = key;
    this.name = mapData["name"];
    this.title = mapData["title"];
    this.description = mapData["description"];
    this.category = mapData["category"];
    this.brand = mapData["brand"];
    this.price = mapData["price"].toDouble();
    this.small = mapData["small"];
    this.medium = mapData["medium"];
    this.large = mapData["large"];
    this.xlarge = mapData["xlarge"];
    this.xxl = mapData["xxl"];
  }

}

