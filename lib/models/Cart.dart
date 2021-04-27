import 'package:flutter/material.dart';

class Cart{
final String id,productId,imageUrl,productName,size;
final  int quantity;
final double price;

Cart({this.id, this.productId, this.imageUrl, this.productName, this.size,
      this.quantity, this.price});
}