import 'package:flutter/material.dart';

import 'package:lookgood_flutter/components/carousel_list.dart';
import 'package:lookgood_flutter/components/cart_counter.dart';



class ProductDetails extends StatelessWidget {
  final int id;

  const ProductDetails({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.chevron_left,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              CarouselProductsList(
                productsList: products[id].images,
                type: CarouselTypes.details,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),
                    /*Container(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: products[id].tags.length,
                        itemBuilder: (ctx, i) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Chip(
                              backgroundColor: Colors.black,
                              padding:
                              const EdgeInsets.symmetric(horizontal: 15.0),
                              label: Text(
                                "${products[id].tags[i]}",
                                style:
                                Theme.of(context).textTheme.button.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Spacer(),*/
                    Text(
                      "${products[id].title}",
                      style: Theme.of(context).textTheme.headline4.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text("${products[id].price}"),
                    Spacer(),
                    Text(
                      "Color:",
                      style: Theme.of(context).textTheme.headline5.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        product.description,
                        style: TextStyle(height: 1.5),
                      ),
                    ),

                    Spacer(),

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
                        child: IconButton(
                          icon: Icon(
                            Icons.favorite_border,

                          ),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),

                    Spacer(),


                  ],
                ),
              ),
              Container(
                height: 50,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 15),
                        height: double.infinity,
                        child: RaisedButton(
                          child: Text(
                            "ADD TO BAG",
                            style: Theme.of(context).textTheme.button.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {},
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 15),
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}