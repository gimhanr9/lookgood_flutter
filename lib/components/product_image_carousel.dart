import 'package:flutter/material.dart';
import 'package:lookgood_flutter/components/carousel_list.dart';
import 'package:lookgood_flutter/models/Product.dart';


class ProductImageCarousel extends StatelessWidget {

  const ProductImageCarousel({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          CarouselList(
            productsList: products[id].images,
            type: CarouselTypes.details,
          ),
        ],
      ),
    );
  }
}