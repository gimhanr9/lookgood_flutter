import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lookgood_flutter/models/Rating.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


class RatingItem extends StatelessWidget {
  const RatingItem({
    Key key,
    @required this.rating,
  }) : super(key: key);

  final Rating rating;

  @override
  Widget build(BuildContext context) {
    return Card(
      child:Row(
        children: [

          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                rating.name + " - "+rating.date,
                style: TextStyle(color: Colors.black, fontSize: 14),
                maxLines: 2,
              ),

              SizedBox(height: 10),
              SmoothStarRating(
                borderColor: Colors.yellow,
                isReadOnly: true,
                size: 15,
                spacing: 0.0,
                rating: rating.ratingValue,
                starCount: 5,
                color: Colors.yellow,
                allowHalfRating: true,
              ),
              SizedBox(width: 10),

              Text.rich(
                TextSpan(
                  text: "${rating.size}",
                  style: TextStyle(
                      fontSize: 12, color: Color(0xFFFF7643)),
                ),
              ),
              SizedBox(height: 10),
              Text(
                rating.ratingText,
                style: TextStyle(color: Colors.black, fontSize: 12),
                maxLines: 2,
              ),

            ],
          ),


        ],
      ),
    );
  }
}