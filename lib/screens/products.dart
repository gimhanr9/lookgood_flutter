import 'package:flutter/material.dart';
import 'package:lookgood_flutter/screens/product_body.dart';

class Products extends StatelessWidget {
  final String category;

  Products({Key key, @required this.category}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: buildAppBar(),
      body:ProductBody(),
    );

  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Icon(Icons.arrow_back,color: Colors.black,),
      title: Text('Products'),
      actions: <Widget>[
        IconButton(
          icon:Icon(Icons.search,color: Colors.black,),
          onPressed: () {},

        ),
        SizedBox(width: 20.0 / 2)


      ],


    );
  }
}