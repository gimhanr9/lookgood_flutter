import 'package:flutter/material.dart';
import 'package:lookgood_flutter/screens/products.dart';



class AccessoryCategories extends StatefulWidget {
  @override
  _AccessoryCategoriesState createState() => _AccessoryCategoriesState();
}

class _AccessoryCategoriesState extends State<AccessoryCategories> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:buildAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child:Column(
          children:<Widget> [

            Container(
              height: 115.0,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 50.0,
                    child: Container(
                      width: 290.0,
                      height: 115.0,
                      child: Card(
                        color: Colors.black12,

                        child: Padding(

                          padding: const EdgeInsets.only(
                            top: 8.0,
                            bottom: 8.0,
                            left: 64.0,
                          ),

                          child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text("Handbags",

                                  style: Theme.of(context).textTheme.headline5),
                              TextButton(
                                child: Text('View Listings'),
                                style: TextButton.styleFrom(
                                  primary: Colors.blue,
                                  textStyle: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 14,

                                  ),

                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Products(category: "Handbag"

                                        ),
                                      ));
                                },
                              )

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(top: 7.5,
                    child: Container(
                      width: 100.0,
                      height: 100.0,

                      decoration: BoxDecoration(

                        shape: BoxShape.circle,
                        image: DecorationImage(

                          fit: BoxFit.cover,

                          image: AssetImage(
                              "assets/images/handbag.png"),
                        ),
                      ),
                    ),),
                ],
              ),
            ),

            SizedBox(
              height: 20,
            ),

            Container(
              height: 115.0,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 50.0,
                    child: Container(
                      width: 290.0,
                      height: 115.0,
                      child: Card(
                        color: Colors.teal,

                        child: Padding(

                          padding: const EdgeInsets.only(
                            top: 8.0,
                            bottom: 8.0,
                            left: 64.0,
                          ),

                          child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text("Watches",

                                  style: Theme.of(context).textTheme.headline5),
                              TextButton(
                                child: Text('View Listings'),
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  textStyle: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 14,

                                  ),

                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Products(category: "Watches"

                                        ),
                                      ));
                                },
                              )

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(top: 7.5,
                    child: Container(
                      width: 100.0,
                      height: 100.0,

                      decoration: BoxDecoration(

                        shape: BoxShape.circle,
                        image: DecorationImage(

                          fit: BoxFit.cover,

                          image: AssetImage(
                              "assets/images/watch.png"),
                        ),
                      ),
                    ),),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),

            Container(
              height: 115.0,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 50.0,
                    child: Container(
                      width: 290.0,
                      height: 115.0,
                      child: Card(
                        color: Colors.deepOrangeAccent,

                        child: Padding(

                          padding: const EdgeInsets.only(
                            top: 8.0,
                            bottom: 8.0,
                            left: 64.0,
                          ),

                          child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text("Sunglasses",

                                  style: Theme.of(context).textTheme.headline5),
                              TextButton(
                                child: Text('View Listings'),
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  textStyle: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 14,

                                  ),

                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Products(category: "Sunglasses"

                                        ),
                                      ));
                                },
                              )

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(top: 7.5,
                    child: Container(
                      width: 100.0,
                      height: 100.0,

                      decoration: BoxDecoration(

                        shape: BoxShape.circle,
                        image: DecorationImage(

                          fit: BoxFit.cover,

                          image: AssetImage(
                              "assets/images/sunglasses.png"),
                        ),
                      ),
                    ),),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.black,),
        onPressed: ()=> Navigator.pop(context),

      ),
      title: Text('Accessories'),


    );
  }


}