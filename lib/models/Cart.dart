import 'package:flutter/material.dart';

class Cart{
String id,productId,imageUrl,productName,size;
int quantity;
double price;

Cart({this.id, this.productId, this.imageUrl, this.productName, this.size,
      this.quantity, this.price});


Map toMap(Cart cart) {
      var data = Map<String, dynamic>();
      data["productId"] = cart.productId;
      data["imageUrl"] = cart.imageUrl;
      data["productName"] = cart.productName;
      data["size"] = cart.size;
      data["quantity"] = cart.quantity;
      data["price"] = cart.price;

      return data;
}

Cart.fromMap(key,Map<dynamic, dynamic> mapData) {
      this.id = key;
      this.productId = mapData["productId"];
      this.imageUrl = mapData["imageUrl"];
      this.productName = mapData["productName"];
      this.size = mapData["size"];
      this.quantity = mapData["quantity"];
      this.price = mapData["price"].toDouble();

}


}