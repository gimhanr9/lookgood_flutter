import 'package:flutter/material.dart';
import 'package:lookgood_flutter/screens/favourites.dart';
import 'package:lookgood_flutter/screens/login_register.dart';
import 'package:lookgood_flutter/screens/products.dart';
import 'package:lookgood_flutter/screens/profile_screen.dart';
import 'package:lookgood_flutter/utils/cart_size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cart_screen.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    CartSizeConfig().init(context);

    return Scaffold(

      appBar: buildAppBar(),

      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
                  Colors.deepOrange,
                  Colors.orangeAccent
                ])
              ),
              child: Text('Header')),

             ListTile(
               title: Text('Home'),

               onTap: (){
                 Navigator.of(context).pop();
               },
             ),

            ListTile(
              title: Text('Account'),

              onTap: (){
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                      ),
                    ));

              },
            ),

            Divider(
              height: 1,
              thickness: 1,
            ),


            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Categories',
              ),
            ),

            ListTile(
              title: Text('Favorites'),

              onTap: (){
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoritesPage(
                      ),
                    ));

              },
            ),

            ListTile(
              title: Text('Gents'),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Products(category: 'Mens Top',),
                    ));

              },
            ),

            ListTile(
              title: Text('Ladies'),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Products(category: 'Women',),
                    ));

              },
            ),

            ListTile(
              title: Text('Kids'),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Products(category: 'Kids',),
                    ));

              },
            ),
            ListTile(
              title: Text('Contact Us'),
            ),








          ],
        ),
      ),
    );

  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      //leading: Icon(Icons.menu,color: Colors.black,),
      title: Text('Home'),
      actions: <Widget>[
        IconButton(
          icon:Icon(Icons.shopping_cart_outlined,color: Colors.black,),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ));
          },

        ),
        //getFromSharedPreferences() ?
        IconButton(
          icon:Icon(Icons.login,color: Colors.black,),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginRegister(),
                ));
          },

        ),//:Container(),



        IconButton(
          icon:Icon(Icons.logout,color: Colors.black,),
          onPressed: () {},

        )
      ],


    );
  }

  getFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool boolValue = prefs.getBool('isLoggedIn') ?? false;
    return boolValue;
  }
}
