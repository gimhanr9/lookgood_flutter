import 'package:flutter/material.dart';
import 'package:lookgood_flutter/screens/home.dart';
import 'package:lookgood_flutter/utils/cart_size_config.dart';

class SuccessScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: SizedBox(),
        title: Text("Success"),
      ),
      body: Column(

          children: [
            SizedBox(height: CartSizeConfig.screenHeight * 0.04),
            Image.asset(
              "assets/images/check_mark.png",
              height: CartSizeConfig.screenHeight * 0.4, //40%
            ),
            SizedBox(height: CartSizeConfig.screenHeight * 0.08),
            Text(
              "Purchase Successful!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),

            ),
            Spacer(),
            SizedBox(
              width: CartSizeConfig.screenWidth * 0.6,
              child: ElevatedButton(
                child: Text('Back to Home'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () {
                  Navigator
                      .of(context)
                      .pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Home(),));
                },
              )
            ),
            Spacer(),
          ],
        ),
      );

  }
}