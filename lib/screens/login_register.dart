import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lookgood_flutter/models/UserModel.dart';
import 'package:lookgood_flutter/screens/forgot_password.dart';
import 'package:lookgood_flutter/screens/home.dart';
import 'package:lookgood_flutter/utils/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';



class LoginRegister extends StatefulWidget {
  @override
  _LoginRegisterState createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  final auth=new AuthService();
  User user;
  bool isLoggingIn=false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  validateFields(){
    String email,password;

    email=emailController.text.toString().trim();
    password=passwordController.text.toString().trim();

    if(email.length>0 && password.length>0){
      setState(() {
        isLoggingIn=true;
      });
      auth.signInWithEmailAndPassword(context,email, password).then((value){
        setState(() {
          isLoggingIn=false;
        });

        if(value!=null) {
          addToSharedPreferences(true);
          Navigator
              .of(context)
              .pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) => Home(),));
        }

      });

    }else{
      ScaffoldMessenger.of(context)
          .showSnackBar(
          SnackBar(
            content: Text('Username and password must be entered!'),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width,
                height: height*0.45,
                child: Image.asset('assets/images/shop.png',fit: BoxFit.fill,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Login',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              SizedBox(height: 30.0,),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    suffixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: Icon(Icons.visibility_off),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.0,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: Text('Forgot Password'),
                      style: TextButton.styleFrom(

                        primary: Colors.red,
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPassword(
                              ),
                            ));
                      },
                    ),
                    isLoggingIn==true?CircularProgressIndicator(
                      valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                    )
                    :ElevatedButton(
                      child: Text('Login'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        onPrimary: Colors.white,
                      ),
                      onPressed: () {
                        validateFields();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height:20.0),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Second()));
                },
                child: Text.rich(
                  TextSpan(
                      text: 'Don\'t have an account',
                      children: [
                        TextSpan(
                          text: 'Signup',
                          style: TextStyle(
                              color: Color(0xffEE7B23)
                          ),
                        ),
                      ]
                  ),
                ),
              ),
              SizedBox(height:20.0),

            ],
          ),
        ),
      ),
    );
  }
  addToSharedPreferences(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', value);
  }

}


class Second extends StatefulWidget {
  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  final auth=new AuthService();
  User user;
  bool isLoggingIn=false;

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();

  validateFields(){
    String email,password,name,address,phone;

    email=emailController.text.toString().trim();
    password=passwordController.text.toString().trim();
    name=nameController.text.toString().trim();
    address=addressController.text.toString().trim();
    phone=phoneController.text.toString().trim();

    if(email.length>0 && password.length>0 && name.length>0 && address.length>0 && phone.length>0){
      UserModel userModel=UserModel(email: email,password: password,name: name,address: address,phone:phone);
      setState(() {
        isLoggingIn=true;
      });
      auth.registerWithEmailAndPassword(context,userModel).then((value){

        setState(() {
          isLoggingIn=false;
        });

        if(value!=null) {
          addToSharedPreferences(true);
          Navigator
              .of(context)
              .pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) => Home(),));
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
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width,
                height: height*0.45,
                child: Image.asset('assets/images/shopping.png',fit: BoxFit.fill,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Signup',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              SizedBox(height: 30.0,),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    suffixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: Icon(Icons.visibility_off),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    suffixIcon: Icon(Icons.account_circle),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                    hintText: 'Address',
                    suffixIcon: Icon(Icons.home),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    hintText: 'Phone',
                    suffixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30.0,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isLoggingIn==true?CircularProgressIndicator(
                      valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                    )
                    :ElevatedButton(
                      child: Text('Register'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        onPrimary: Colors.white,
                      ),
                      onPressed: () {
                        validateFields();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height:20.0),
              GestureDetector(
                onTap: (){
                  Navigator
                      .of(context)
                      .pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LoginRegister(),));
                },
                child: Text.rich(
                  TextSpan(
                      text: 'Already have an account',
                      children: [
                        TextSpan(
                          text: 'Signin',
                          style: TextStyle(
                              color: Color(0xffEE7B23)
                          ),
                        ),
                      ]
                  ),
                ),
              ),
              SizedBox(height:20.0),

            ],
          ),
        ),
      ),
    );
  }

  addToSharedPreferences(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', value);
  }

}