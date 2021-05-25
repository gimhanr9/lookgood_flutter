import 'package:flutter/material.dart';
import 'package:lookgood_flutter/models/Product.dart';
import 'package:lookgood_flutter/utils/database_helper.dart';

class BuyNow extends StatefulWidget {
  final Product product;
  const BuyNow({
    Key key,
    @required this.product,
  }) : super(key: key);



  @override
  _BuyNowState createState() => _BuyNowState(product:this.product);
}


class _BuyNowState extends State<BuyNow> {
  final Product product;
  final databaseHelper=DatabaseHelper();

  _BuyNowState({this.product});



  @override
  Widget build(BuildContext context) {
    return Padding(
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
              icon: Icon(Icons.add_shopping_cart_outlined,
                color: Colors.black,
              ),
              onPressed: () {



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
                  primary: Colors.blue,
                ),

                onPressed: () {},
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
    );
  }
}