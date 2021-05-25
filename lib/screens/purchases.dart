import 'package:flutter/material.dart';
import 'package:lookgood_flutter/models/Purchases.dart';
import 'package:lookgood_flutter/utils/cart_size_config.dart';
import 'package:lookgood_flutter/utils/database_helper.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:intl/intl.dart';

import 'login_register.dart';

class PurchasesPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _PurchasesPageState();
  }
}

class _PurchasesPageState extends State<PurchasesPage> {
  final databaseHelper=new DatabaseHelper();
  final List<Purchases> purchases = [];
  bool isLogged;

  @override
  void initState() {
    super.initState();
    databaseHelper.isLoggedIn().then((value) {
      if(value){
        isLogged=true;
        databaseHelper.getPurchases().then((value){
          setState(() {
            purchases.clear();
            purchases.addAll(value);
          });


        });
      }else{
        setState(() {
          isLogged=false;
        });

      }
    });
  }


  Widget _buildPurchasesList() {

    return isLogged==null?Center(child: CircularProgressIndicator()):!isLogged?
    Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Please Login!',),
            ElevatedButton(
              child: Text('Login'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginRegister(

                      ),
                    ));
              },
            )
          ],
        ),
      ),
    ):
    purchases.length > 0
        ? Container(
         child:  ListView.builder(
          itemCount: purchases.length,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              children: [
                SizedBox(
                  width: 88,
                  child: AspectRatio(
                    aspectRatio: 0.88,
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Image.network(purchases[index].imageUrl),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      purchases[index].productName,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      maxLines: 2,
                    ),

                    SizedBox(height: 10),
                    Text.rich(
                      TextSpan(
                        text: "Rs.${purchases[index].price}"+"- ${purchases[index].size}",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Color(0xFFFF7643)),
                        children: [
                          TextSpan(
                              text: " -${purchases[index].quantity} item(s)",
                              style: Theme.of(context).textTheme.bodyText1),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      child: purchases[index].isRated==true?Text('Edit review'):Text('Write review'),
                      style: TextButton.styleFrom(
                        primary: Colors.blue,
                        textStyle: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 12,

                        ),

                      ),
                      onPressed: () {
                        _showRatingAppDialog(purchases[index]);
                      },
                    )

                  ],
                )
              ],
            );
          },
        )

    ): Center(child: Text('No Purchases'));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: buildAppBar(context),
      body: _buildPurchasesList(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.black,),
        onPressed: ()=> Navigator.pop(context),

      ),
      title: Text('Purchases'),
    );
  }

  void _showRatingAppDialog(Purchases purchases) {
    final _ratingDialog = RatingDialog(
      ratingColor: Colors.amber,
      title: 'Rate your purchase',
      message: 'Rate this product to help other customers to decide on their purchases!',
      image: Image.asset("assets/images/star.png",
        height: 100,),
      submitButton: 'Submit',
      //onCancelled: () => print('cancelled'),
      onSubmitted: (response) {

        if (response.comment.length>10) {
          var dt = DateTime.now();
          var newFormat = DateFormat("yy-MM-dd");
          String date = newFormat.format(dt);
          databaseHelper.submitRating(purchases.id, purchases.productId, response.comment, purchases.size, date,
              response.rating.toDouble());
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(
              SnackBar(
                content: Text('Please describe your feedback in at least 10 letters!'),
                ));
        }
      },
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _ratingDialog,
    );
  }
}