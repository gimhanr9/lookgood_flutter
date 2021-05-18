import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lookgood_flutter/components/cart_item.dart';
import 'package:lookgood_flutter/models/Cart.dart';
import 'package:lookgood_flutter/utils/database_helper.dart';

import '../utils/cart_size_config.dart';


class CartBody extends StatefulWidget {



  @override
  _CartBodyState createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {

  final databaseHelper=new DatabaseHelper();
  final List<Cart> cartItems=[];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(cartItems[index].productId.toString()),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {
              setState(() {
                cartItems.removeAt(index);
              });
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
                  //SvgPicture.asset("assets/icons/Trash.svg"),
                ],
              ),
            ),
            child: CartItem(cart: cartItems[index]),
          ),
        ),
      ),
    );
  }
}