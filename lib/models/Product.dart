import 'package:flutter/material.dart';

class Product{
  final String imageUrl,id,name,title,description,category,brand;
  final double price;
  final int small,medium,large,xlarge, xxl;

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
}

