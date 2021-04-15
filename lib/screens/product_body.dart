import 'package:flutter/material.dart';
import 'package:lookgood_flutter/components/categories/kids_categories.dart';
import 'package:lookgood_flutter/components/categories/mens_categories.dart';
import 'package:lookgood_flutter/components/categories/womens_categories.dart';



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
            "Women",
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),

          getCategory(category),


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
                        builder: (context) => DetailsScreen(
                          product: products[index],
                        ),
                      )),
                )),
          ),
        ),
      ],
    );
  }

  void getCategory(String category){
    if(category=="Men"){
      MensCategories();
    }else if(category=="Women"){
      WomensCategories();
    }else if(category=="Kids"){
      KidsCategories();
    }
  }
}