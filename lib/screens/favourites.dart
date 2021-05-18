import 'package:flutter/material.dart';
import 'package:lookgood_flutter/components/favourite_card.dart';
import 'package:lookgood_flutter/models/Favourites.dart';
import 'package:lookgood_flutter/utils/database_helper.dart';

class FavoritesPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _FavoritesPageState();
  }
}

class _FavoritesPageState extends State<FavoritesPage> {
  final databaseHelper=new DatabaseHelper();
  final List<Favourites> favorites = [];

  Widget _buildFavoritesList() {
    databaseHelper.getFavorites().then((value){
      favorites.addAll(value);

    });
    return Container(
      child: favorites.length > 0
          ? ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            onDismissed: (DismissDirection direction) {
              setState(() {
                favorites.removeAt(index);
              });
            },
            secondaryBackground: Container(
              child: Center(
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              color: Colors.red,
            ),
            background: Container(),
            child: FavoriteCard(favourites: favorites[index]),
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
          );
        },
      )
          : Center(child: Text('No Items')),
    );
  }

  @override
  Widget build(BuildContext context) {
    databaseHelper.getFavorites().then((value){
      setState(() {
        favorites.addAll(value);
      });

    });
    return Scaffold(
      appBar: buildAppBar(context),
      body: _buildFavoritesList(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.black,),
        onPressed: ()=> Navigator.pop(context),

      ),
      title: Text('Favorites'),
    );
  }
}