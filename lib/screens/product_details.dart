import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lookgood_flutter/components/buy_now.dart';
import 'package:lookgood_flutter/components/cart_counter.dart';
import 'package:lookgood_flutter/components/product_image_carousel.dart';
import 'package:lookgood_flutter/models/Product.dart';


class Body extends StatelessWidget {
  final Product product;

  const Body({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(
                    top: size.height * 0.12,
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
                          CartCounter(),
                          Container(
                            padding: EdgeInsets.all(8),
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              color: Color(0xFFFF6464),
                              shape: BoxShape.circle,
                            ),
                            child:IconButton(
                                icon: SvgPicture.asset(
                                  "assets/icons/heart.svg"
                                ),
                                onPressed: (){},//do something,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20.0 / 2),
                      BuyNow(product: product)
                    ],
                  ),
                ),
                ProductImageCarousel(product: product)
              ],
            ),
          )
        ],
      ),
    );
  }
}