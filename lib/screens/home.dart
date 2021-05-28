import 'package:flutter/material.dart';
import 'package:lookgood_flutter/components/categories/accessory_category.dart';
import 'package:lookgood_flutter/components/categories/kids_categories.dart';
import 'package:lookgood_flutter/components/categories/mens_categories.dart';
import 'package:lookgood_flutter/components/categories/womens_categories.dart';
import 'package:lookgood_flutter/components/product_card_home.dart';
import 'package:lookgood_flutter/models/Product.dart';
import 'package:lookgood_flutter/screens/contact_us.dart';
import 'package:lookgood_flutter/screens/favourites.dart';
import 'package:lookgood_flutter/screens/login_register.dart';
import 'package:lookgood_flutter/screens/product_details.dart';
import 'package:lookgood_flutter/screens/profile_screen.dart';
import 'package:lookgood_flutter/screens/purchases.dart';
import 'package:lookgood_flutter/utils/auth_service.dart';
import 'package:lookgood_flutter/utils/cart_size_config.dart';
import 'package:lookgood_flutter/utils/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cart_screen.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> {
  final auth=new AuthService();
  bool isLogged=false;
  List<Product> products=[];
  final databaseHelper=new DatabaseHelper();

  @override
  void initState() {
    super.initState();
    getFromSharedPreferences().then((value) {
      if(value){
        setState(() {
          isLogged=true;
        });
      }else{
        setState(() {
          isLogged=false;
        });
      }
    });

    databaseHelper.getLatestProducts().then((value){
      setState(() {
        products.clear();
        products.addAll(value);
      });

    });
  }

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
                      Colors.black12,
                      Colors.blue
                    ])
                ),
                child: Text('LookGOOD',style: TextStyle(color: Colors.white),)),

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
                      builder: (context) => MensCategories(),
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
                      builder: (context) => WomensCategories(),
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
                      builder: (context) => KidsCategories(),
                    ));

              },
            ),

            ListTile(
              title: Text('Accessories'),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccessoryCategories(),
                    ));

              },
            ),

            ListTile(
              title: Text('Purchases'),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PurchasesPage(),
                    ));

              },
            ),

            ListTile(
              title: Text('Contact Us'),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactUs(
                      ),
                    ));

              },
            ),

          ],
        ),
      ),

      body:SingleChildScrollView(
        clipBehavior: Clip.none,
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: getProportionateScreenWidth(25)),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      "assets/images/main_image.jpg",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: getProportionateScreenHeight(315),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: getProportionateScreenHeight(80)),
                        Text(
                          "LookGOOD",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(73),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 0.5),
                        ),
                        Text(
                          "Ultimate fashion destination",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),

                  ],
                ),
              ),

              SizedBox(height: 10,),

              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "LookGOOD",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getProportionateScreenWidth(16),
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                    height: 180,
                    child: ListView.builder(
                        itemCount: products.length,
                        scrollDirection: Axis.horizontal,

                        itemBuilder: (context, index) => ProductCardHome(
                          product: products[index],
                          press: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetails(
                                  product: products[index],
                                ),
                              )),
                        )



                    ),
                  ),


                ],
              ),

            ],
          ),
        ),
      ),
    );

  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.blue,
      elevation: 0,

      title: Text('Home',),

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
        !isLogged ?
        IconButton(
          icon:Icon(Icons.login,color: Colors.black,),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginRegister(),
                ));
          },

        ):Container(),



        isLogged?
        IconButton(
          icon:Icon(Icons.logout,color: Colors.black,),
          onPressed: () {
            auth.signOut(context);
            setState(() {

              addToSharedPreferences(false);
              isLogged=false;
            });

          },

        ):Container(),
      ],


    );
  }
  Future<void>addToSharedPreferences(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', value);
  }

  Future<bool>getFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool boolValue = prefs.getBool('isLoggedIn') ?? false;
    return boolValue;
  }
}
