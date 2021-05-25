import 'package:flutter/material.dart';
import 'package:lookgood_flutter/utils/cart_size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: ()=> Navigator.pop(context),
        ),
        title: Text("Contact Us"),
      ),
      body: Column(

          children: [
            SizedBox(height: CartSizeConfig.screenHeight * 0.04),
            Image.asset(
              "assets/images/call_us.png",
              height: CartSizeConfig.screenHeight * 0.4, //40%
            ),
            SizedBox(height: CartSizeConfig.screenHeight * 0.08),
            Text(
              "Call our 24/7 hotline for any enquiries",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            SizedBox(
                width: CartSizeConfig.screenWidth * 0.6,
                child: ElevatedButton(
                  child: Text('CALL'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    onPrimary: Colors.white,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    _callPhone();
                  },
                )
            ),
            Spacer(),
          ],
        ),
      );

  }
}

_callPhone() async {
  String phoneNumber="770599068";
  String url = 'tel:' + phoneNumber;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}