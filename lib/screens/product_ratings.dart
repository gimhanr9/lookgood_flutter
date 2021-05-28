import 'package:flutter/material.dart';
import 'package:lookgood_flutter/components/rating_item.dart';
import 'package:lookgood_flutter/models/Rating.dart';
import 'package:lookgood_flutter/utils/database_helper.dart';


class RatingsPage extends StatefulWidget {

  final String productId;

  const RatingsPage({Key key, @required this.productId}) : super(key: key);

  @override
  _RatingsPageState createState() => _RatingsPageState(productId:this.productId);
}

class _RatingsPageState extends State<RatingsPage> {
  final databaseHelper=new DatabaseHelper();
  final List<Rating> ratings = [];
  final String productId;

  _RatingsPageState({this.productId});

  @override
  void initState() {
    super.initState();
    databaseHelper.getRatings(productId).then((value) {
      setState(() {
        ratings.clear();
        ratings.addAll(value);
      });


    });
  }

  Widget _buildRatingsList() {

    return
      ratings.length > 0 ? Container(
            child:  ListView.builder(
             itemCount: ratings.length,
             itemBuilder: (BuildContext context, int index) {
              return RatingItem(rating: ratings[index],);
            },
          )

      ): Center(child: Text('No Ratings for this product!'));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: buildAppBar(context),
      body: _buildRatingsList(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      elevation: 0,
      leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.black,),
        onPressed: ()=> Navigator.pop(context),

      ),
      title: Text('Ratings'),
    );
  }
}