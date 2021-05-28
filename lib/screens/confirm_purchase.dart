import 'package:flutter/material.dart';
import 'package:lookgood_flutter/models/Purchases.dart';
import 'package:lookgood_flutter/models/UserModel.dart';
import 'package:lookgood_flutter/screens/profile_screen.dart';
import 'package:lookgood_flutter/screens/success_screen.dart';
import 'package:lookgood_flutter/utils/auth_service.dart';
import 'package:lookgood_flutter/utils/database_helper.dart';


class ConfirmPurchase extends StatefulWidget {
  final List<Purchases> purchaseList;
  final String condition;
  ConfirmPurchase({Key key,@required this.purchaseList,@required this.condition}) : super(key: key);

  @override
  _ConfirmPurchaseState createState() => _ConfirmPurchaseState(purchaseList: this.purchaseList,condition: this.condition);
}

class _ConfirmPurchaseState extends State<ConfirmPurchase> {
  final auth=new AuthService();
  final databaseHelper=new DatabaseHelper();
  List<UserModel> userList=[];
  List<Purchases> purchaseList=[];
  bool isLogged;
  String condition;

  _ConfirmPurchaseState({this.purchaseList,this.condition});

  @override
  void initState() {
    super.initState();
    auth.getUserDetails().then((value) {
      setState(() {
        userList.clear();
        userList.addAll(value);
      });

    });
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
        appBar: buildAppBar(),
        body: confirmView()
    );
  }
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.blue,
      elevation: 0,
      leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.black,),
        onPressed: ()=> Navigator.pop(context),

      ),
      title: Text('Confirm Purchase'),

    );
  }

  Widget confirmView() {
    return userList.length==0 ?Center(child: CircularProgressIndicator()):
    SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
            child: Container(
              height: 60,
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Confirm your details...", style: TextStyle(color: Colors.black,fontSize: 18),),
                ),
              ),
            ),
          ),



          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
            child: Container(
              height: 60,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(userList[0].name, style: TextStyle(color: Colors.black),),
                ),
              ), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),border: Border.all(width: 1.0, color: Colors.black12)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
            child: Container(
              height: 60,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(userList[0].email, style: TextStyle(color: Colors.black),),
                ),
              ), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),border: Border.all(width: 1.0, color: Colors.black12)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
            child: Container(
              height: 60,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(userList[0].address, style: TextStyle(color: Colors.black),),
                ),
              ), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),border: Border.all(width: 1.0, color: Colors.black12)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
            child: Container(
              height: 60,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(userList[0].phone, style: TextStyle(color: Colors.black),),
                ),
              ), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),border: Border.all(width: 1.0, color: Colors.black12)),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                child: Text('Edit'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                  onPrimary: Colors.white,
                  textStyle: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(

                        ),
                      ));

                },
              ),
              ElevatedButton(
                child: Text('Confirm'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                  onPrimary: Colors.white,
                  textStyle: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  databaseHelper.purchase(purchaseList, condition).then((value) {
                    if(value){
                      Navigator
                          .of(context)
                          .pushReplacement(MaterialPageRoute(builder: (BuildContext context) => SuccessScreen(),));
                    }
                  });
                },
              ),


            ],
          ),

        ],
      ),
    );

  }
}