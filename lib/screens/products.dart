import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lookgood_flutter/components/categories/kids_categories.dart';
import 'package:lookgood_flutter/components/categories/mens_categories.dart';
import 'package:lookgood_flutter/components/categories/womens_categories.dart';
import 'package:lookgood_flutter/components/product_card.dart';
import 'package:lookgood_flutter/models/Product.dart';
import 'package:lookgood_flutter/screens/product_details.dart';
import 'package:lookgood_flutter/utils/database_helper.dart';


class Products extends StatefulWidget {

  final String category;

  const Products({Key key, @required this.category}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState(category:this.category);
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}


class _ProductsState extends State<Products> {
  final _debouncer = Debouncer(milliseconds: 500);
  final String category;
  final databaseHelper=new DatabaseHelper();
  final List<Product> products=[];
  List<Product> filteredProducts=[];

  _ProductsState({this.category});

  @override
  void initState() {
    super.initState();
    databaseHelper.getProducts(category).then((value){
      setState(() {
        products.clear();
        products.addAll(value);
        filteredProducts=products;
      });

    });
  }

  Widget buildProducts(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15.0),
              hintText: 'Filter by product name ',
            ),
            onChanged: (string) {
              _debouncer.run(() {
                setState(() {
                  filteredProducts = products
                      .where((p) => (p.name
                      .toLowerCase()
                      .contains(string.toLowerCase()) ))
                      .toList();
                });
              });
            },
          ),
        ),
        SizedBox(height: 20.0 / 2),

        Expanded(
          child: filteredProducts.length==0? Center(child: CircularProgressIndicator()):Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),

            child: GridView.builder(
                itemCount: filteredProducts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => ProductCard(
                  product: filteredProducts[index],
                  press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetails(
                          product: filteredProducts[index],
                        ),
                      )),
                )),
          ),
        ),
      ],
    );
  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: buildAppBar(),
      body:buildProducts(),
    );

  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.black,),
      onPressed: ()=> Navigator.pop(context),

      ),
      title: Text('Products'),


    );
  }
}
