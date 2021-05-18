import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lookgood_flutter/models/Cart.dart';
import 'package:lookgood_flutter/models/Favourites.dart';
import 'package:lookgood_flutter/models/Product.dart';
import 'package:flutter/material.dart';


class DatabaseHelper{
  final databaseRef = FirebaseDatabase.instance.reference();
  final FirebaseAuth _auth = FirebaseAuth.instance;


  // Get all products and product related data to display to users.

  Future<List<Product>> getProducts(String category) async{
    List<Product> productList=[];
    await databaseRef.child("products").orderByChild("category").equalTo(category).once().then((DataSnapshot snapshot) async{

      Map<String, dynamic> products = Map.from( snapshot.value );
      productList.clear();

      products.values.forEach( (value) {
        productList.add(
          //here you'll not use fromSnapshot to parse data,
          //i thing you got why we're not using fromSnapshot
            Product.fromMap(Map.from(value))
        );
      });

      /*snapshot.value.foreach((key,childSnapshot){
        productList.add(Product.fromMap(key,Map.from(childSnapshot)));
      });*/

      /*Map<String, dynamic> products = snapshot.value;

      products.forEach((key, values) {
        productList.add(Product.fromMap(key,values));
      });*/

    });

    return productList;

  }

  // Get all product images to display as a list for a particular product.

  Future<List<String>> getImages(String id) async{
    List<String> images=[];

    await databaseRef.child("images").child(id).once().then((DataSnapshot snapshot) async{

      Map<dynamic, dynamic> imageList = snapshot.value;
      imageList.forEach((key, values) {
        images.add(values);
      });

    });

    return images;

  }



  // Get all cart items to display to user.

  Future<List<Cart>> getCartItems() async{
    List<Cart> cartList=[];

    User user=FirebaseAuth.instance.currentUser;

    await databaseRef.child("cart").child(user.uid).once().then((DataSnapshot snapshot) async{

      Map<dynamic, dynamic> cartItems = snapshot.value;
      cartItems.forEach((key, values) {
        cartList.add(Cart.fromMap(values));
      });

    });

    return cartList;

  }


  // Get all favorites to display to user.

  Future<List<Favourites>> getFavorites() async{
    List<Favourites> favorites=[];

    User user=FirebaseAuth.instance.currentUser;

    await databaseRef.child("favourites").child(user.uid).once().then((DataSnapshot snapshot) async{

      Map<dynamic, dynamic> favoriteItems = snapshot.value;
      favoriteItems.forEach((key, values) {
        favorites.add(Favourites.fromMap(values));
      });

    });

    return favorites;

  }

  Future<void> addToFavorite({String productId, String image, String name, String title, double price}) async{
    User user=FirebaseAuth.instance.currentUser;
    Favourites favourites=Favourites();
    favourites=Favourites(imageUrl: image,productName: name,productTitle: title,price:price);

    await databaseRef.child("favourites").child(user.uid).child(productId).set(favourites.toMap(favourites));

  }

  Future<bool> isFavorite(String productId) async{
    bool isAvailable=false;

    User user=FirebaseAuth.instance.currentUser;

    await databaseRef.child("favourites").child(user.uid).child(productId).once().then((DataSnapshot snapshot) async{
      if(snapshot.value!=null){
        isAvailable=true;
      }else{
        isAvailable=false;
      }

    });
    return isAvailable;

  }

  Future<void> addToCart({String productId, String image, String name, String size, int quantity, double price}) async{
    User user=FirebaseAuth.instance.currentUser;
    Cart cart=Cart();
    cart=Cart(productId:productId, imageUrl:image, productName:name, size:size, quantity:quantity, price:price);
    String key=databaseRef.push().key;

    await databaseRef.child("cart").child(user.uid).child(key).set(cart.toMap(cart));

  }

  Future<bool> isInCart(String productId, String size) async{
    bool isAvailable=false;

    User user=FirebaseAuth.instance.currentUser;

    await databaseRef.child("cart").child(user.uid).once().then((DataSnapshot snapshot) async{
      if(snapshot.value!=null){

        isAvailable=true;
      }else{
        isAvailable=false;
      }

    });
    return isAvailable;

  }


  Future<void> deleteCartItem(BuildContext context,String id) async{

    User user=FirebaseAuth.instance.currentUser;
    await databaseRef.child("cart").child(user.uid).child(id).remove().then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        DatabaseHelper.customSnackBar(
          content: "Successfully deleted from cart!",
        ),
      );


      /*
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black,
          content: Text(
            "Deleted from cart!",
            style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
          ),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              addToCart(productId: cart.productId,image: cart.imageUrl,name: cart.productName,size: cart.size,quantity: cart.quantity,price: cart.price);
            },
          ),
        ),

      );*/
    });
  }

  Future<bool> deleteFavorite(BuildContext context,String id) async{
    bool deleted=false;
    User user=FirebaseAuth.instance.currentUser;
    await databaseRef.child("favourites").child(user.uid).child(id).remove().then((value) {
      deleted=true;

      ScaffoldMessenger.of(context).showSnackBar(
        DatabaseHelper.customSnackBar(
          content: "Successfully deleted from favorites!",
        ),
      );

      /*ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.black,
            content: Text(
              "Deleted from favorites!",
              style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
            ),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                addToFavorite(productId: favourites.productId,image: favourites.imageUrl,name: favourites.productName,title: favourites.productTitle,
                price: favourites.price);
              },
            ),
          ),

      );*/
    });
    return deleted;
  }


  static SnackBar customSnackBar({String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }



}