import 'package:flutter/material.dart';

class Home extends StatelessWidget {
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
      leading: Icon(Icons.menu,color: Colors.black,),
      title: Text('Home'),
      actions: <Widget>[
        IconButton(
          icon:Icon(Icons.shopping_cart,color: Colors.black,),
          onPressed: () {},

        ),
        IconButton(
          icon:Icon(Icons.login,color: Colors.black,),
          onPressed: () {},

        ),
        IconButton(
          icon:Icon(Icons.shopping_cart,color: Colors.black,),
          onPressed: () {},

        ),

        IconButton(
          icon:Icon(Icons.logout,color: Colors.black,),
          onPressed: () {},

        ),
      ],


    );
  }
}
