import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lookgood_flutter/models/Cart.dart';
import 'package:lookgood_flutter/models/Favourites.dart';
import 'package:lookgood_flutter/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:lookgood_flutter/models/Purchases.dart';
import 'package:lookgood_flutter/models/Rating.dart';
import 'package:lookgood_flutter/models/TotalRating.dart';
import 'package:lookgood_flutter/models/UserModel.dart';


class DatabaseHelper{
  final databaseRef = FirebaseDatabase.instance.reference();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int counterHelper;


  // Get all products and product related data to display to users.

  Future<List<Product>> getProducts(String category) async{
    List<Product> productList=[];
    await databaseRef.child("products").orderByChild("category").equalTo(category).once().then((DataSnapshot snapshot) async{
      if(snapshot.value!=null) {

        Map<String, dynamic> products = Map.from(snapshot.value);
        productList.clear();

        products.forEach((key, value) {
          productList.add(Product.fromMap(key, value));
        });
      }

    });


    return productList;

  }

  //Get the first 6 latest products from database to display to the user.

  Future<List<Product>> getLatestProducts() async{
    List<Product> productList=[];
    await databaseRef.child("products").limitToFirst(6).once().then((DataSnapshot snapshot) async{
      if(snapshot.value!=null) {

        Map<String, dynamic> products = Map.from(snapshot.value);
        productList.clear();

        products.forEach((key, value) {
          productList.add(Product.fromMap(key, value));
        });
      }

    });


    return productList;

  }

  // Get all product images to display as a list for a particular product.

  Future<List<String>> getImages(String id) async{
    List<String> imageList=[];

    await databaseRef.child("images").child(id).once().then((DataSnapshot snapshot) async{
      print('Image Data came');


      List<String> images = new List<String>.from(snapshot.value);
      imageList.clear();
      images.forEach((element) {
        imageList.add(element);
      });

    });

    return imageList;

  }



  // Get all cart items to display to user.

  Future<List<Cart>> getCartItems() async{
    List<Cart> cartList=[];

    User user=FirebaseAuth.instance.currentUser;

    await databaseRef.child("cart").child(user.uid).once().then((DataSnapshot snapshot) async{

      if(snapshot.value!=null) {


        Map<String, dynamic> cartItems = Map.from(snapshot.value);
        cartList.clear();

        cartItems.forEach((key, value) {
          cartList.add(Cart.fromMap(key, value));
        });
      }

    });

    return cartList;

  }


  // Get all favorites to display to user.

  Future<List<Favourites>> getFavorites() async{
    List<Favourites> favorites=[];

    User user=FirebaseAuth.instance.currentUser;

    await databaseRef.child("favourites").child(user.uid).once().then((DataSnapshot snapshot) async{

      if(snapshot.value!=null) {


        Map<String, dynamic> favoriteItems = Map.from(snapshot.value);
        favorites.clear();

        favoriteItems.forEach((key, value) {
          favorites.add(Favourites.fromMap(key, value));
        });
      }

    });

    return favorites;

  }

  //add to favorites

  Future<void> addToFavorite({BuildContext context,String productId, String image, String name, String title, double price}) async{
    User user=FirebaseAuth.instance.currentUser;
    Favourites favourites=Favourites();
    favourites=Favourites(imageUrl: image,productName: name,productTitle: title,price:price);

    await databaseRef.child("favourites").child(user.uid).child(productId).set(favourites.toMap(favourites));
    ScaffoldMessenger.of(context).showSnackBar(
      DatabaseHelper.customSnackBar(
        content: "Added to favorites",
      ),
    );

  }
  //function to check if a given product id is already a favorite for the current user.
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

  //add to cart function adds the data under cart node.
  Future<void> addToCart({BuildContext context,String productId, String image, String name, String size, int quantity, double price}) async{
    User user=FirebaseAuth.instance.currentUser;
    Cart cart=Cart();
    cart=Cart(productId:productId, imageUrl:image, productName:name, size:size, quantity:quantity, price:price);
    String key=databaseRef.push().key;

    await databaseRef.child("cart").child(user.uid).child(key).set(cart.toMap(cart));
    ScaffoldMessenger.of(context).showSnackBar(
      DatabaseHelper.customSnackBar(
        content: "Added to cart",
      ),
    );

  }

  //if the user swipes the cart item to dismiss it and then undoes the deletion this method is called.

  Future<void> addToCartAgain({String id, String productId, String image, String name, String size, int quantity, double price}) async{
    User user=FirebaseAuth.instance.currentUser;
    Cart cart=Cart();
    cart=Cart(productId:productId, imageUrl:image, productName:name, size:size, quantity:quantity, price:price);

    await databaseRef.child("cart").child(user.uid).child(id).set(cart.toMap(cart));

  }

  //function to check if a given product id and the same size variant of that product id is already in cart.
  Future<void> isInCart(BuildContext context,Cart cart) async{
    bool isAvailable=false;

    User user=FirebaseAuth.instance.currentUser;

    await databaseRef.child("cart").child(user.uid).once().then((DataSnapshot snapshot) async{
      if(snapshot.value!=null) {


        Map<String, dynamic> cartItems = Map.from(snapshot.value);


        cartItems.forEach((key, value) {
          Map<dynamic, dynamic> mapData=value;
          if(cart.productId==mapData["productId"] && cart.size==mapData["size"]){

            isAvailable=true;
          }

        });

        if(isAvailable){
          ScaffoldMessenger.of(context).showSnackBar(
            DatabaseHelper.customSnackBar(
              content: "Item already in cart!",
            ),
          );
        }else{
          addToCart(context: context,productId: cart.productId,image: cart.imageUrl,name: cart.productName,size: cart.size,quantity: cart.quantity,price: cart.price);
        }


      }else{
        addToCart(context: context,productId: cart.productId,image: cart.imageUrl,name: cart.productName,size: cart.size,quantity: cart.quantity,price: cart.price);

      }

    });

  }

  //delete cart item.

  Future<void> deleteCartItem(BuildContext context,String id) async{

    User user=FirebaseAuth.instance.currentUser;
    await databaseRef.child("cart").child(user.uid).child(id).remove();

  }

  //delete favorite item.
  Future<void> deleteFavorite(BuildContext context,String id) async{
    User user=FirebaseAuth.instance.currentUser;
    await databaseRef.child("favourites").child(user.uid).child(id).remove();

  }

  //get the total ratings out of 5 for a particular product id.

  Future<TotalRating> getTotalRatings(String productId) async{
    TotalRating ratings;

    counterHelper=0;

    await databaseRef.child("ratings").child(productId).once().then((DataSnapshot snapshot) async{

      if(snapshot.value!=null) {
        int counter=0;
        double total=0.0;
        double totalRating=0.0;

        Map<String, dynamic> ratingItems = Map.from(snapshot.value);

        ratingItems.forEach((key, value) {
          Map<dynamic, dynamic> mapData=value;
          double rating=mapData["ratingValue"].toDouble();
          total=total+rating;
          counter++;
        });
        counterHelper=counter;
        totalRating=total/counter;

        ratings=TotalRating(counter: counterHelper,totalRating: totalRating);
      }else{
        ratings=TotalRating(counter: counterHelper,totalRating: 0.0);

      }

    });

    return ratings;

  }

  //get the list of all purchases of current user.
  Future<List<Purchases>> getPurchases() async{
    List<Purchases> purchaseList=[];

    User user=FirebaseAuth.instance.currentUser;

    await databaseRef.child("purchases").child(user.uid).once().then((DataSnapshot snapshot) async{

      if(snapshot.value!=null) {


        Map<String, dynamic> purchases = Map.from(snapshot.value);
        purchaseList.clear();

        purchases.forEach((key, value) {
          purchaseList.add(Purchases.fromMap(key, value));
        });
      }

    });

    return purchaseList;

  }
  //get a list of all ratings for a particular product.

  Future<List<Rating>> getRatings(String productId) async{
    List<Rating> ratingList=[];


    await databaseRef.child("ratings").child(productId).once().then((DataSnapshot snapshot) async{

      if(snapshot.value!=null) {


        Map<String, dynamic> ratings = Map.from(snapshot.value);
        ratingList.clear();

        ratings.forEach((key, value) {
          ratingList.add(Rating.fromMap(key, productId, value));
        });
      }

    });

    return ratingList;

  }

  //add a rating to database.

  Future<void>submitRating(String purchaseId,String productId,String ratingText,String size,String date,double ratingValue) async{
    User user=FirebaseAuth.instance.currentUser;
    if(user!=null){
      await databaseRef.child("users").child(user.uid).once().then((DataSnapshot snapshot) async{

        if(snapshot.value!=null) {


          Map<dynamic, dynamic> userDetails = snapshot.value;

          UserModel userModel=UserModel(email: userDetails["email"],name: userDetails["name"], address: userDetails["address"],
              phone: userDetails["phone"]);

          Rating rating=Rating(purchaseId: purchaseId,name: userModel.name,ratingText: ratingText,size: size,date: date,ratingValue: ratingValue);
          writeRatingToDB(rating, productId);
          updatePurchase(purchaseId);


        }


      });
    }


  }


  Future<void>updatePurchase(String purchaseId) async{
    User user=FirebaseAuth.instance.currentUser;
    if(user!=null){
      await databaseRef.child("purchases").child(user.uid).child(purchaseId).update({
        'rated':true
      });
    }

  }

  Future<void>writeRatingToDB(Rating rating, String productId) async{

    if(productId!=null){
      String key=databaseRef.push().key;
      await databaseRef.child("ratings").child(productId).child(key).set(rating.toMap(rating));

    }


  }

  //check stocks, update them and call write purchase method to record the purchase for the current registered user

  Future<bool>purchase(List<Purchases> purchaseItem, String condition) async{
    for(int i=0;i<purchaseItem.length;i++){
      String productId=purchaseItem[i].productId;
      String size=purchaseItem[i].size;
      int quantity=purchaseItem[i].quantity;

      List<Product> productList=[];
      await databaseRef.child("products").child(productId).child(size).once().then((DataSnapshot snapshot) async{
        if(snapshot.value!=null) {
          int dbQuantity=snapshot.value;

          if(dbQuantity>quantity){
            int newQuantity=dbQuantity-quantity;
            updateStocks(productId,size,newQuantity);
            writePurchase(purchaseItem[i]);

          }
        }

      });

    }
    if(condition =="cart") {
      deleteCart();
    }
    return true;

  }

  //check stocks, update them and call write purchase method to record the purchase for a guest user
  Future<bool>purchaseGuest(List<Purchases> purchaseItem, UserModel userModel) async{
    for(int i=0;i<purchaseItem.length;i++){
      String productId=purchaseItem[i].productId;
      String size=purchaseItem[i].size;
      int quantity=purchaseItem[i].quantity;

      List<Product> productList=[];
      await databaseRef.child("products").child(productId).child(size).once().then((DataSnapshot snapshot) async{
        if(snapshot.value!=null) {
          int dbQuantity=snapshot.value;

          if(dbQuantity>quantity){
            int newQuantity=dbQuantity-quantity;
            updateStocks(productId,size,newQuantity);
            writeTransaction(purchaseItem[i],userModel);

          }
        }

      });

    }
    return true;
  }

  Future<void>updateStocks(String productId,String size,int quantity) async{

    await databaseRef.child("products").child(productId).update({
      size:quantity
    });

  }

  //record purchase for registered user.
  Future<void>writePurchase(Purchases purchases) async{
    String userId;
    User user=FirebaseAuth.instance.currentUser;
    String key=databaseRef.push().key;

    if (user != null) {
      userId = user.uid;
    } else {
      userId = "Guest" + key;
    }

    await databaseRef.child("purchases").child(userId).child(key).set(purchases.toMap(purchases));

  }


  //record a purchase for guest user.
  Future<void>writeTransaction(Purchases purchases,UserModel userModel) async{
    String userId;
    String key=databaseRef.push().key;

    userId = "Guest" + key;

    await databaseRef.child("purchases").child(userId).child(key).set(purchases.toMap(purchases)).then((value) {
      writeGuest(userId, key, userModel);

    });

  }
  //record a guest purchase

  Future<void>writeGuest(String userId,String key,UserModel userModel) async{

    await databaseRef.child("guestpurchases").child(userId).child(key).set(userModel.toMap(userModel));

  }

  //delete all cart items once they are purchased.

  Future<void>deleteCart() async{

    User user=FirebaseAuth.instance.currentUser;

    await databaseRef.child("cart").child(user.uid).remove();

  }




  //function to check if the user is logged in.

  Future<bool> isLoggedIn() async{
    User user=FirebaseAuth.instance.currentUser;

    if(user!=null){
      return true;
    }else{
      return false;
    }

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