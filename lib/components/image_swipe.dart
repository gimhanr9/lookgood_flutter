import 'package:flutter/material.dart';
import 'package:lookgood_flutter/utils/database_helper.dart';

class ImageSwipe extends StatefulWidget {
  final String id;

  const ImageSwipe({Key key,@required this.id}) : super(key: key);

  @override
  _ImageSwipeState createState() => _ImageSwipeState(id: this.id);
}

class _ImageSwipeState extends State<ImageSwipe> {
  final String id;
  final databaseHelper=new DatabaseHelper();
  final List<String> images=[];


  int _selectedPage = 0;

  _ImageSwipeState({this.id});

  @override
  void initState() {
    super.initState();
    databaseHelper.getImages(id).then((value){
      setState(() {
        images.clear();
        images.addAll(value);
      });


    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 250.0,
      child: Stack(
        children: [
          PageView(
            onPageChanged: (num) {
              setState(() {
                _selectedPage = num;
              });
            },
            children: [
              for(var i=0; i < images.length; i++)
                Container(
                  child: Image.network(
                    "${images[i]}",
                    fit: BoxFit.contain,
                  ),
                )
            ],
          ),
          Positioned(
            bottom: 20.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for(var i=0; i < images.length; i++)
                  AnimatedContainer(
                    duration: Duration(
                        milliseconds: 300
                    ),
                    curve: Curves.easeOutCubic,
                    margin: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    width: _selectedPage == i ? 35.0 : 10.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12.0)
                    ),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}