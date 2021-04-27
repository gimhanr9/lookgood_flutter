import 'package:flutter/material.dart';

class Favourites {
  final String id,productId,imageUrl,productName,productTitle;
  final double price;

  Favourites({this.id, this.productId, this.imageUrl, this.productName,
      this.productTitle, this.price});
}