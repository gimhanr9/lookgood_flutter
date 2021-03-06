
import 'package:flutter/material.dart';
import 'package:lookgood_flutter/utils/auth_service.dart';

class EditProfilePage extends StatefulWidget {

  final String name,address,phone;

  const EditProfilePage({Key key, @required this.name,@required this.address,@required this.phone}) : super(key: key);
  @override
  _EditProfilePageState createState() => _EditProfilePageState(name: this.name,address: this.address,phone: this.phone);

}

class _EditProfilePageState extends State<EditProfilePage> {

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();

  String name,address,phone;
  final auth=new AuthService();

  _EditProfilePageState({this.name,this.address,this.phone});

  validateFields(){
    String name,address,phone;

    name=nameController.text.toString().trim();
    address=addressController.text.toString().trim();
    phone=phoneController.text.toString().trim();

    if(name.length>0 && address.length>0 && phone.length>0){

      auth.updateUser(context: context,name: name,address: address,phone: phone);

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
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                      CircleAvatar(
                        radius: 70,
                        child: ClipOval(child: Image.asset('assets/images/user.png', height: 150, width: 150, fit: BoxFit.cover,),),
                      ),

                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Name",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: name,
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
                      hintText: address,
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
                      hintText: phone,
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ),
              ),

              /*buildTextField("Name", name),
              buildTextField("Address", address),
              buildTextField("Phone", phone),*/
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    child: Text('CANCEL'),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      primary: Colors.white,
                      backgroundColor: Colors.teal,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          letterSpacing: 2.2,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                  ElevatedButton(
                    child: Text('SAVE'),
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
      title: Text('Edit Account'),

    );
  }

  Widget buildTextField(
      String labelText, String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(

        decoration: InputDecoration(

            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}