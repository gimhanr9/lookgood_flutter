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


class _ProductsState extends State<Products> {
  final String category;
  final databaseHelper=new DatabaseHelper();
  final List<Product> products=[];

  _ProductsState({this.category});

  Widget buildProducts(){
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
  
  @override
  Widget build(BuildContext context) {
    databaseHelper.getProducts(category).then((value){
      setState(() {
        products.clear();
        products.addAll(value);
      });

    });


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
      actions: <Widget>[
        IconButton(
          icon:Icon(Icons.search,color: Colors.black,),
          onPressed: () => Navigator.pop(context),

        ),

        SizedBox(width: 10.0)


      ],


    );
  }
}