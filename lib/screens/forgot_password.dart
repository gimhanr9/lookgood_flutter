import 'package:flutter/material.dart';
import 'package:lookgood_flutter/utils/auth_service.dart';

class ForgotPassword extends StatefulWidget {

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final auth=new AuthService();
  bool isLoggingIn=false;


  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Form(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Email Your Email',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  suffixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              isLoggingIn==true?CircularProgressIndicator(
                valueColor:
                AlwaysStoppedAnimation(Theme.of(context).primaryColor),
              )
                  :ElevatedButton(
                child: Text('Send Email'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                  onPrimary: Colors.white,
                  shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
                onPressed: () {
                  validateFields();
                },
              ),
              TextButton(
                child: Text('SignIn'),
                style: TextButton.styleFrom(
                  primary: Colors.red,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
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
      title: Text('Password Reset'),


    );
  }
  validateFields(){
    String email;

    email=emailController.text.toString().trim();

    if(email.length>0){
      setState(() {
        isLoggingIn=true;
      });

      auth.passwordReset(email).then((value) {
        setState(() {
          isLoggingIn=false;
        });
        if(value){
          ScaffoldMessenger.of(context)
              .showSnackBar(
              SnackBar(
                content: Text('Email sent!'),
              ));
        }else{
          ScaffoldMessenger.of(context)
              .showSnackBar(
              SnackBar(
                content: Text('Error occurred. Please try again!'),
              ));
        }
      });

    }else{
      ScaffoldMessenger.of(context)
          .showSnackBar(
          SnackBar(
            content: Text('Please fill in your email!'),
          ));
    }
  }
}
