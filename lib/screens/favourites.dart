import 'package:flutter/material.dart';
import 'package:lookgood_flutter/components/favourite_card.dart';
import 'package:lookgood_flutter/models/Favourites.dart';
import 'package:lookgood_flutter/utils/database_helper.dart';

import 'login_register.dart';

class FavoritesPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _FavoritesPageState();
  }
}

class _FavoritesPageState extends State<FavoritesPage> {
  final databaseHelper=new DatabaseHelper();
  final List<Favourites> favorites = [];
  bool isLogged;

  @override
  void initState() {
    super.initState();
    databaseHelper.isLoggedIn().then((value) {
      if(value){
        isLogged=true;
        databaseHelper.getFavorites().then((value){
          setState(() {
            favorites.clear();
            favorites.addAll(value);
          });


        });
      }else{
        setState(() {
          isLogged=false;
        });

      }
    });
  }

  Widget _buildFavoritesList() {

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
    favorites.length > 0
    ? Container(
      child:  ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            onDismissed: (DismissDirection direction) {
              final Favourites deletedItem=favorites[index];
              databaseHelper.deleteFavorite(context, favorites[index].productId.toString());
              setState(() {
                favorites.removeAt(index);
              });


              ScaffoldMessenger.of(context)
                  .showSnackBar(
                  SnackBar(
                    content: Text('Deleted item from favorites!'),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        databaseHelper.addToFavorite(productId: deletedItem.productId,image: deletedItem.imageUrl,
                            name: deletedItem.productName, title: deletedItem.productTitle, price: deletedItem.price);
                        setState(() {
                          favorites.insert(index, deletedItem);
                        });
                      },
                    ),));

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
            direction: DismissDirection.startToEnd,
          );
        },
      )

    ): Center(child: Text('No favorites'));
  }

  @override
  Widget build(BuildContext context) {

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