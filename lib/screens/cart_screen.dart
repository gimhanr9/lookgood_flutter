import 'package:flutter/material.dart';

class Cart_Screen extends StatefulWidget {
  Cart_Screen({Key key}) : super(key: key);

  @override
  Cart_ScreenState createState() {
    return Cart_ScreenState();
  }
}

class Cart_ScreenState extends State<Cart_Screen> {
  final items = List<String>.generate(20, (i) => "Item ${i + 1}");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Cart",
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              itemCount: bag.length,
              itemBuilder: (ctx, i) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 25),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.white,
                          ),
                          child: Image.network(
                            "${bag[i].mainImage}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${bag[i].title}",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Text(
                              "${bag[i].price}",
                            ),
                            SizedBox(height: 15),
                            MyCounter(),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Divider(),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("TOTAL", style: Theme.of(context).textTheme.subtitle2),
                    Text("RS. 0",
                        style: Theme.of(context).textTheme.headline5),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),

                          )
                      ),

                    ),
                    onPressed: (){

                    },
                    child: Text("Checkout",style: TextStyle(color: Colors.black,fontSize: 17.0)),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );

  }
}

class MyCounter extends StatefulWidget {
  const MyCounter({
    Key key,
  }) : super(key: key);

  @override
  _MyCounterState createState() => _MyCounterState();
}

class _MyCounterState extends State<MyCounter> {
  int _currentAmount = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
          child: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: Icon(
              Icons.remove,
              color: Colors.white,
            ),
          ),
          onTap: () {
            setState(() {
              _currentAmount -= 1;
            });
          },
        ),
        SizedBox(width: 15),
        Text(
          "$_currentAmount",
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(width: 15),
        GestureDetector(
          child: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          onTap: () {
            setState(() {
              _currentAmount += 1;
            });
          },
        ),
      ],
    );
  }
}






















