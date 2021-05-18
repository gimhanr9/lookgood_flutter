
import 'package:flutter/material.dart';
import 'package:lookgood_flutter/models/Favourites.dart';

class FavoriteCard extends StatelessWidget {
  final Favourites favourites;

  FavoriteCard({this.favourites});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(favourites.imageUrl),
            ),
            title: Text(favourites.productName),
            subtitle: Text(favourites.productTitle),
            trailing: Text(favourites.price.toString()),
          )
        ],
      ),
    );
  }
}