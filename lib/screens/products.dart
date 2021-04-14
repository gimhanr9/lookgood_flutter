import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: buildAppBar(),
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


      ],


    );
  }
}