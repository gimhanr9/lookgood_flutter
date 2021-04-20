import 'package:flutter/material.dart';
import 'package:lookgood_flutter/components/categories/kids_categories.dart';
import 'package:lookgood_flutter/components/categories/mens_categories.dart';
import 'package:lookgood_flutter/components/categories/womens_categories.dart';
import 'package:lookgood_flutter/screens/product_details.dart';



class ProductBody extends StatelessWidget {

  final String category;

  const ProductBody({Key key, this.category}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
          child: Padding(
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