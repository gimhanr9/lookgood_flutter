import 'package:flutter/material.dart';
import 'package:lookgood_flutter/utils/database_helper.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class TitleRating extends StatefulWidget {
  final double price;
  final String name,brand,id;

  const TitleRating({Key key, @required this.id,@required this.name,@required this.brand,@required this.price}) : super(key: key);

  @override
  _TitleRatingState createState() => _TitleRatingState(id:this.id,name: this.name,brand:this.brand,price: this.price);
}

class _TitleRatingState extends State<TitleRating> {
  int numOfReviews=0;
  bool isRate=false;
  double rating,newRating=1.0,price;
  final String name,brand,id;
  final databaseHelper=new DatabaseHelper();

  _TitleRatingState({this.id,this.name,this.brand,this.price});

  @override
  void initState() {
    super.initState();
    databaseHelper.getTotalRatings(id).then((value) {

      setState(() {
        numOfReviews=value.counter;
        rating=value.totalRating;
        newRating=rating;
        isRate=true;

      });
    });

  }



  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name +"-" +brand,
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 10),
                Row(

                  children: <Widget>[

                    SmoothStarRating(
                      borderColor: Colors.yellow,
                      isReadOnly: true,
                      rating: 0.0,
                      starCount: 5,
                      spacing: 0.0,
                      color: Colors.yellow,
                      allowHalfRating: true,
                    ),
                    SizedBox(width: 10),
                    Text("$numOfReviews reviews"),
                  ],
                ),
              ],
            ),
          ),
          priceTag(context, price: price),
        ],
      ),
    );
  }

  ClipPath priceTag(BuildContext context, {double price}) {
    String price1=price.toInt().toString();
    return ClipPath(
      clipper: PricerCliper(),
      child: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.symmetric(vertical: 15),
        height: 66,
        width: 65,
        color: Colors.green,
        child: Text(
          "Rs. $price1",
          style: Theme.of(context)
              .textTheme
              .subtitle2
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

class PricerCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double ignoreHeight = 20;
    path.lineTo(0, size.height - ignoreHeight);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, size.height - ignoreHeight);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}