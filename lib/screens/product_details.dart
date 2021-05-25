import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lookgood_flutter/components/image_swipe.dart';
import 'package:lookgood_flutter/components/title_rating.dart';
import 'package:lookgood_flutter/models/Cart.dart';
import 'package:lookgood_flutter/models/Product.dart';
import 'package:lookgood_flutter/models/Purchases.dart';
import 'package:lookgood_flutter/screens/product_ratings.dart';
import 'package:lookgood_flutter/utils/database_helper.dart';

import 'confirm_purchase.dart';
import 'login_register.dart';


class ProductDetails extends StatefulWidget {

  final Product product;

  const ProductDetails({Key key, @required this.product}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState(product:this.product);
}

class _ProductDetailsState extends State<ProductDetails> {
  final Product product;
  final databaseHelper=new DatabaseHelper();
  bool isFavorite=false;
  bool isLogged=false;
  bool isInCart;
  int numOfItems = 1;
  List<String> sizeList=[];
  Map<String,int> quantity={'': 0};
  String dropdownvalue = '';

  _ProductDetailsState({this.product});

  @override
  void initState() {
    super.initState();
    databaseHelper.isLoggedIn().then((value) {
      if(value) {
        isLogged =true;
      }else{
        isLogged=false;
      }
    });

    databaseHelper.isFavorite(product.id).then((value) {
      if(value){
        setState(() {
          isFavorite=true;

        });

      }else{
        setState(() {
          isFavorite=false;

        });

      }
    });
  }


  @override
  Widget build(BuildContext context) {



    sizeList.clear();
    if(product.small>0){
      sizeList.add("small");
      quantity["small"]=product.small;
    }
    if(product.medium>0){
      sizeList.add("medium");
      quantity["medium"]=product.medium;
    }
    if(product.large>0){
      sizeList.add("large");
      quantity["large"]=product.large;
    }
    if(product.xlarge>0){
      sizeList.add("xlarge");
      quantity["xlarge"]=product.xlarge;
    }
    if(product.xxl>0){
      sizeList.add("xxl");
      quantity["xxl"]=product.xxl;
    }


    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context),



      body:SingleChildScrollView(
        child: Column(
          children: <Widget>[
            LimitedBox(

              child: Stack(
                children: <Widget>[



                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.04),
                    padding: EdgeInsets.only(

                      left: 20.0,
                      right: 20.0,
                    ),
                    // height: 500,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        ImageSwipe(id: product.id,),
                        SizedBox(height: 20.0 / 2),
                        TitleRating(id: product.id,name: product.name,brand:product.brand,price: product.price,),

                      SizedBox(height: 20.0 / 2),


                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  DropdownButton(
                                    value: dropdownvalue,
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    items:sizeList.map((size) {
                                      return DropdownMenuItem(
                                          value: size,
                                          child: Text(size)
                                      );
                                    }
                                    ).toList(),
                                    onChanged: (String newValue){
                                      setState(() {
                                        dropdownvalue = newValue;
                                      });
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "${quantity[dropdownvalue]} items remaining" ,
                                    style: Theme.of(context).textTheme.bodyText1,
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    children: <Widget>[
                                      TextButton(
                                        child: Text('Read reviews'),
                                        style: TextButton.styleFrom(
                                          primary: Colors.blue,
                                          textStyle: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 14,

                                          ),

                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => RatingsPage(productId: product.id

                                                ),
                                              ));
                                        },
                                      )

                                    ],
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),



                        SizedBox(height: 20.0 / 2),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(
                            product.description,
                            style: TextStyle(height: 1.5),
                          ),
                        ),
                        SizedBox(height: 20.0 / 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[

                            Row(
                              children: <Widget>[
                                buildOutlinedButton(
                                  icon: Icons.remove,
                                  press: () {
                                    if (numOfItems > 1) {
                                      setState(() {
                                        numOfItems--;
                                      });
                                    }
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0 / 2),
                                  child: Text(
                                    // if our item is less  then 10 then  it shows 01 02 like that
                                    numOfItems.toString().padLeft(2, "0"),
                                    style: Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                                buildOutlinedButton(
                                    icon: Icons.add,
                                    press: () {
                                      setState(() {
                                        numOfItems++;
                                      });
                                    }),
                              ],
                            ),



                              IconButton(
                                icon: Icon(isFavorite?Icons.favorite:Icons.favorite_border,
                                  color: Colors.red,
                                ),
                                onPressed: (){
                                  if(isLogged) {
                                    if (isFavorite) {
                                      databaseHelper.deleteFavorite(
                                          context, product.id);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                          SnackBar(
                                            content: Text('Removed from favorites!'),
                                            ));
                                      setState(() {
                                        isFavorite = false;
                                      });

                                    } else {
                                      databaseHelper.addToFavorite(context: context,
                                          productId: product.id,
                                          image: product.imageUrl,
                                          name: product.name,
                                          title: product.title,
                                          price: product.price);
                                      setState(() {
                                        isFavorite=true;
                                      });


                                    }
                                  }else{
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                        SnackBar(
                                          content: Text('Please login to continue!'),
                                          ));
                                  }

                                },//do something,
                              ),



                          ],
                        ),
                        SizedBox(height: 20.0 / 2),



                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: 20.0),
                                height: 50,
                                width: 58,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                                child: IconButton(
                                  icon: Icon(

                                    Icons.add_shopping_cart_sharp,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                    if(isLogged) {
                                      Cart cart = Cart(productId: product.id,
                                          imageUrl: product.imageUrl,
                                          productName: product.name,
                                          size: dropdownvalue,
                                          quantity: numOfItems,
                                          price: product.price * numOfItems);
                                      databaseHelper.isInCart(context, cart);
                                    }else{
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LoginRegister(

                                            ),
                                          ));

                                    }

                                  },
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18)),
                                      backgroundColor: Colors.blue,
                                      primary: Colors.white
                                    ),

                                    onPressed: () {
                                      if(isLogged){
                                        List<Purchases> purchaseList=[];
                                        purchaseList.clear();
                                        Purchases purchases=Purchases(productId: product.id,imageUrl: product.imageUrl,
                                            productName: product.name,size: dropdownvalue,quantity: numOfItems,
                                            price: product.price,isRated: false);
                                        purchaseList.add(purchases);

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ConfirmPurchase(
                                                purchaseList: purchaseList, condition: "direct",
                                              ),
                                            ));
                                      }else{

                                      }
                                    },
                                    child: Text(
                                      "Buy  Now".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //ProductImageCarousel(product: product)

                      ],
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.black,),
        onPressed: ()=> Navigator.pop(context),
      ),
    );
  }

  SizedBox buildOutlinedButton({IconData icon, Function press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13))),

        onPressed: press,
        child: Icon(icon),
      ),
    );
  }
}