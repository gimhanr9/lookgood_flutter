
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lookgood_flutter/models/UserModel.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final databaseRef = FirebaseDatabase.instance.reference();


  Stream<User> get authStateChanges => _auth.authStateChanges();


  // sign in with email and password.
  Future<User> signInWithEmailAndPassword(BuildContext context,String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return user;
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        AuthService.customSnackBar(
          content: error.toString(),
        ),
      );
      return null;
    }
  }


  // register with email and password
  Future<User> registerWithEmailAndPassword(BuildContext context,UserModel userModel) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: userModel.email, password: userModel.password);
      User user = result.user;

      await databaseRef.child("users").child(user.uid).set(userModel.toMap(userModel));
      return user;
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        AuthService.customSnackBar(
          content: error.toString(),
        ),
      );
      return null;
    }
  }

  // sign out
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        AuthService.customSnackBar(
          content: error.toString(),
        ),
      );
    }
  }

  Future<List<UserModel>> getUserDetails() async{
    User user=FirebaseAuth.instance.currentUser;
    List<UserModel> userList=[];

    await databaseRef.child("users").child(user.uid).once().then((DataSnapshot snapshot) async{

      if(snapshot.value!=null) {


        Map<dynamic, dynamic> userDetails = snapshot.value;
        userList.clear();
        UserModel userModel=UserModel(email: userDetails["email"],name: userDetails["name"], address: userDetails["address"],
        phone: userDetails["phone"]);
        userList.add(userModel);
      }


    });
    return userList;

  }

  Future<void> updateUser({BuildContext context, String name, String address, String phone}) async{
    User user=FirebaseAuth.instance.currentUser;
    UserModel userModel=UserModel(email: user.email,name: name,address: address,phone: phone);

    await databaseRef.child("users").child(user.uid).set(userModel.toMap(userModel));
    ScaffoldMessenger.of(context).showSnackBar(
      AuthService.customSnackBar(
        content: "User details updated!",
      ),
    );

  }

  Future<bool>passwordReset(String email)async{

    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      await _auth.sendPasswordResetEmail(email: email);
      return true;

    }catch(error){
      return false;
    }

  }

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