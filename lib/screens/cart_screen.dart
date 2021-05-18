import 'package:flutter/material.dart';
import 'package:lookgood_flutter/components/cart_body.dart';

import 'package:lookgood_flutter/components/cart_checkout.dart';
import 'package:lookgood_flutter/components/cart_item.dart';
import 'package:lookgood_flutter/models/Cart.dart';
import '../utils/cart_size_config.dart';

import 'package:lookgood_flutter/utils/database_helper.dart';

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


  Widget buildCart(){
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20.0)),
      child: ListView.builder(

        itemCount: cartItems.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(cartItems[index].productId.toString()),

            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {
              final Cart deletedCart=cartItems[index];
              setState(() {
                cartItems.removeAt(index);

              });
              databaseHelper.deleteCartItem(context, cartItems[index].productId.toString());
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                  SnackBar(
                    content: Text('Deleted item from cart!'),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        databaseHelper.addToCart(productId: deletedCart.productId,image: deletedCart.imageUrl,name: deletedCart.productName,
                            size: deletedCart.size,quantity: deletedCart.quantity,price: deletedCart.price);
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
    );
  }
  @override
  Widget build(BuildContext context) {
    databaseHelper.getCartItems().then((value){
      cartItems.addAll(value);

    });

    return Scaffold(
      appBar: buildAppBar(context),
      body: buildCart(),
      bottomNavigationBar: CheckoutCard(),
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
}