import 'package:flutter/material.dart';
import 'package:lookgood_flutter/components/cart_item.dart';
import 'package:lookgood_flutter/models/Cart.dart';
import 'package:lookgood_flutter/models/Purchases.dart';
import 'package:lookgood_flutter/screens/confirm_purchase.dart';
import '../utils/cart_size_config.dart';

import 'package:lookgood_flutter/utils/database_helper.dart';

import 'login_register.dart';

class CartScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _CartScreenState();
  }
}

class _CartScreenState extends State<CartScreen> {
  final databaseHelper=new DatabaseHelper();
  final List<Cart> cartItems=[];
  final Cart deletedCart=Cart();
  bool isLogged;
  double total=0.0;

  @override
  void initState() {
    super.initState();
    databaseHelper.isLoggedIn().then((value) {
      if(value){
        isLogged=true;
        databaseHelper.getCartItems().then((value){
          setState(() {
            cartItems.clear();
            cartItems.addAll(value);
            calculateTotal();
          });


        });
      }else{
        setState(() {
          isLogged=false;
        });

      }
    });
  }



  Widget buildCart(){
    return isLogged==null?Center(child: CircularProgressIndicator()):!isLogged?
    Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Please Login!',),
            ElevatedButton(
              child: Text('Login'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginRegister(

                      ),
                    ));
              },
            )
          ],
        ),
      ),
    ):cartItems.length>0

      ?Padding(
        padding:
        EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20.0)),
        child: ListView.builder(

          itemCount: cartItems.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Dismissible(
              key: UniqueKey(),

              direction: DismissDirection.startToEnd,
              onDismissed: (direction) {
                final Cart deletedCart=cartItems[index];
                databaseHelper.deleteCartItem(context, cartItems[index].id.toString());
                setState(() {
                  cartItems.removeAt(index);
                  calculateTotal();

                });
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                    SnackBar(
                      content: Text('Deleted item from cart!'),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          databaseHelper.addToCartAgain(id: deletedCart.id, productId: deletedCart.productId,image: deletedCart.imageUrl,name: deletedCart.productName,
                              size: deletedCart.size,quantity: deletedCart.quantity,price: deletedCart.price);

                          setState(() {
                            cartItems.insert(index, deletedCart);
                            calculateTotal();
                          });
                        },
                      ),));


              },
              background: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFFFE6E6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Spacer(),
                    Icon(Icons.delete_sharp,color: Colors.red,),
                  ],
                ),
              ),
              child: CartItem(cart: cartItems[index]),
            ),
          ),
        ),
      ): Center(child: Text('No items in cart!'));
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: buildAppBar(context),
      body: buildCart(),
      bottomNavigationBar: buildBottomNav(),
    );
  }

  Container buildBottomNav() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15.0),
        horizontal: getProportionateScreenWidth(30.0),
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(

                    children: [
                      TextSpan(
                        text: "Rs.$total",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    width: getProportionateScreenWidth(190.0),
                    child: TextButton(
                      child: Text('Checkout'),

                      style: TextButton.styleFrom(
                        textStyle: TextStyle(
                          fontSize: getProportionateScreenWidth(18.0),
                          color: Colors.white,
                        ),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                      ),
                      onPressed: () {
                        List<Purchases> purchases=[];
                        for(int i=0;i<cartItems.length;i++){
                          purchases.add(new Purchases(productId: cartItems[i].productId,imageUrl: cartItems[i].imageUrl,
                          productName: cartItems[i].productName,size: cartItems[i].size,quantity: cartItems[i].quantity,
                          price: cartItems[i].price,isRated: false));
                        }
                        if(purchases.length>0){
                          Navigator
                              .of(context)
                              .pushReplacement(MaterialPageRoute(builder: (BuildContext context) => ConfirmPurchase(
                            purchaseList: purchases, condition: "cart",
                          ),));

                        }

                      },
                    )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Cart",
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }

  void calculateTotal(){
    double tot=0.0;
    for(int i=0;i<cartItems.length;i++){
      tot=tot+cartItems[i].price;
    }

    total=tot;
  }
}