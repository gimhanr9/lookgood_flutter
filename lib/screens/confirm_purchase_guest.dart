import 'package:flutter/material.dart';
import 'package:lookgood_flutter/models/Purchases.dart';
import 'package:lookgood_flutter/models/UserModel.dart';
import 'package:lookgood_flutter/screens/success_screen.dart';
import 'package:lookgood_flutter/utils/database_helper.dart';

class ConfirmPurchaseGuest extends StatefulWidget {

  final List<Purchases> purchaseList;
  final String condition;

  ConfirmPurchaseGuest({Key key,@required this.purchaseList,@required this.condition}) : super(key: key);

  @override
  _ConfirmPurchaseGuestState createState() => _ConfirmPurchaseGuestState(purchaseList: this.purchaseList,condition: this.condition);

}

class _ConfirmPurchaseGuestState extends State<ConfirmPurchaseGuest> {

  final databaseHelper=new DatabaseHelper();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();


  List<Purchases> purchaseList=[];
  String condition;

  _ConfirmPurchaseGuestState({this.purchaseList,this.condition});

  validateFields(){
    String name,email,address,phone;

    name=nameController.text.toString().trim();
    email=emailController.text.toString().trim();
    address=addressController.text.toString().trim();
    phone=phoneController.text.toString().trim();

    if(name.length>0 && email.length>0 && address.length>0 && phone.length>0){
      UserModel userModel=UserModel(email: email,name: name,address: address,phone: phone);
      databaseHelper.purchaseGuest(purchaseList, userModel).then((value) {
        if(value){
          Navigator
              .of(context)
              .pushReplacement(MaterialPageRoute(builder: (BuildContext context) => SuccessScreen(),));
        }
      });

    }else{
      ScaffoldMessenger.of(context)
          .showSnackBar(
          SnackBar(
            content: Text('Please fill all fields!'),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Enter your details...",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),

              Container(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Name",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ),
              ),

              Container(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Email",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ),
              ),

              Container(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  controller: addressController,

                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Address",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ),
              ),

              Container(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  controller: phoneController,

                  decoration: InputDecoration(

                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Phone",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ),
              ),

              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  ElevatedButton(
                    child: Text('CONFIRM'),
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      primary: Colors.teal,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),

                      textStyle: TextStyle(
                        fontSize: 14,
                        letterSpacing: 2.2,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 50),

                    ),

                    onPressed: () {
                      validateFields();

                    },
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      elevation: 0,
      leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.black,),
        onPressed: ()=> Navigator.pop(context),

      ),
      title: Text('Enter Details'),

    );
  }


}