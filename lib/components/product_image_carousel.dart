import 'package:flutter/material.dart';
import 'package:lookgood_flutter/components/carousel_list.dart';
import 'package:lookgood_flutter/models/Product.dart';
import 'package:lookgood_flutter/utils/database_helper.dart';


class ProductImageCarousel extends StatelessWidget {
  final databaseHelper=new DatabaseHelper();

  final List<String> images=[];


  ProductImageCarousel({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;


  @override
  Widget build(BuildContext context) {
    databaseHelper.getImages(product.id).then((value){
      images.addAll(value);


    });
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          CarouselList(
            imagesList: images,
            type: CarouselTypes.details,
          ),
        ],
      ),
    );
  }
}