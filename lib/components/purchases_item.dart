import 'package:flutter/material.dart';
import 'package:lookgood_flutter/models/Purchases.dart';


import '../utils/cart_size_config.dart';

class PurchasesItem extends StatelessWidget {
  const PurchasesItem({
    Key key,
    @required this.purchases,
  }) : super(key: key);

  final Purchases purchases;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(purchases.imageUrl),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              purchases.productName,
              style: TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),

            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: "Rs.${purchases.price}"+"- ${purchases.size}",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Color(0xFFFF7643)),
                children: [
                  TextSpan(
                      text: " -${purchases.quantity} item(s)",
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            ),
            SizedBox(height: 10),

          ],
        )
      ],
    );
  }
}