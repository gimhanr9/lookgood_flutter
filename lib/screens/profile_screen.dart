
import 'package:flutter/material.dart';
import 'package:lookgood_flutter/models/UserModel.dart';
import 'package:lookgood_flutter/screens/edit_profile.dart';
import 'package:lookgood_flutter/screens/login_register.dart';
import 'package:lookgood_flutter/utils/auth_service.dart';


class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final auth=new AuthService();
  List<UserModel> userList=[];
  bool isLogged;

  @override
  void initState() {
    super.initState();
    auth.isLoggedIn().then((value) {
      if(value){
        isLogged=true;
        auth.getUserDetails().then((value) {
          setState(() {
            userList.clear();
            userList.addAll(value);
          });

        });
      }else{
        setState(() {
          isLogged=false;
        });

      }
    });
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
        appBar: buildAppBar(),
        body: profileView()
    );
  }
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.black,),
        onPressed: ()=> Navigator.pop(context),

      ),
      title: Text('Account'),

    );
  }

  Widget profileView() {
    return isLogged==null || userList.length==0 ?Center(child: CircularProgressIndicator()):!isLogged?
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
    SingleChildScrollView(
      child:Column(
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0,0 ,50),
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: 70,
                  child: ClipOval(child: Image.asset('assets/images/user.png', height: 150, width: 150, fit: BoxFit.cover,),),
                ),
              ],
            ),
          ),
          Expanded(child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.black54, Color.fromRGBO(0, 41, 102, 1)]
                )
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                  child: Container(
                    height: 60,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(userList[0].name, style: TextStyle(color: Colors.white70),),
                      ),
                    ), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),border: Border.all(width: 1.0, color: Colors.white70)),
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
                        child: Text(userList[0].email, style: TextStyle(color: Colors.white70),),
                      ),
                    ), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),border: Border.all(width: 1.0, color: Colors.white70)),
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
                        child: Text(userList[0].address, style: TextStyle(color: Colors.white70),),
                      ),
                    ), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),border: Border.all(width: 1.0, color: Colors.white70)),
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
                        child: Text(userList[0].phone, style: TextStyle(color: Colors.white70),),
                      ),
                    ), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),border: Border.all(width: 1.0, color: Colors.white70)),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
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
                              builder: (context) => EditProfilePage(
                                name: userList[0].name,address: userList[0].address,phone: userList[0].phone,
                              ),
                            ));

                      },
                    ),
                  ),

                )
              ],
            ),
          ))
        ],
      ),
    );

  }
}