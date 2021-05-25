
import 'package:flutter/material.dart';

class UserModel{
String email,password,name,address,phone;

UserModel({this.email, this.password, this.name, this.address, this.phone});

Map toMap(UserModel user) {
  var data = Map<String, dynamic>();

  data["email"] = user.email;
  data["name"] = user.name;
  data["address"] = user.address;
  data["phone"] = user.phone;

  return data;
}

UserModel.fromMap(Map<String, dynamic> mapData) {
  this.email = mapData["email"];
  this.name = mapData["name"];
  this.address = mapData["address"];
  this.phone = mapData["phone"];
}
}