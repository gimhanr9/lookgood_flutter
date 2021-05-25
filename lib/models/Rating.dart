
class Rating{
  String ratingId,productId,purchaseId,name,ratingText,size,date;
  double ratingValue;

  Rating({
    this.ratingId,
    this.productId,
    this.purchaseId,
    this.name,
    this.ratingText,
    this.size,
    this.date,
    this.ratingValue});

  Map toMap(Rating rating) {
    var data = Map<String, dynamic>();

    data["purchaseId"] = rating.purchaseId;
    data["name"] = rating.name;
    data["ratingText"] = rating.ratingText;
    data["size"] = rating.size;
    data["date"] = rating.date;
    data["ratingValue"] = rating.ratingValue;

    return data;
  }

  Rating.fromMap(key,productId,Map<dynamic, dynamic> mapData) {
    this.ratingId = key;
    this.productId = productId;
    this.purchaseId=mapData["purchaseId"];
    this.name = mapData["name"];
    this.ratingText = mapData["ratingText"];
    this.size = mapData["size"];
    this.date = mapData["date"];
    this.ratingValue = mapData["ratingValue"].toDouble();
  }

}