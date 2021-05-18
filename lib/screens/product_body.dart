import 'package:flutter/material.dart';
import 'package:lookgood_flutter/components/categories/kids_categories.dart';
import 'package:lookgood_flutter/components/categories/mens_categories.dart';
import 'package:lookgood_flutter/components/categories/womens_categories.dart';
import 'package:lookgood_flutter/components/product_card.dart';
import 'package:lookgood_flutter/models/Product.dart';
import 'package:lookgood_flutter/screens/product_details.dart';
import 'package:lookgood_flutter/utils/database_helper.dart';


class ProductBody extends StatefulWidget {

final String category;

const ProductBody({Key key, @required this.category}) : super(key: key);

  @override
  _ProductBodyState createState() => _ProductBodyState(category:this.category);
}

class _ProductBodyState extends State<ProductBody> {

  String category;
  _ProductBodyState({this.category});

  final databaseHelper=new DatabaseHelper();
  final List<Product> products=[];



  @override
  Widget build(BuildContext context) {
    databaseHelper.getProducts(category).then((value){
      products.addAll(value);

    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            category=="Men" ? "Men" : category=="Women" ? "Women" : "Kids",
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),

          category=="Men" ? MensCategories() : category=="Women" ? WomensCategories() : KidsCategories(),




        Expanded(
          child: products.length==0? Center(child: CircularProgressIndicator()):Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),

            child: GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => ProductCard(
                  product: products[index],
                  press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetails(
                          product: products[index],
                        ),
                      )),
                )),
          ),
        ),
      ],
    );
  }


}