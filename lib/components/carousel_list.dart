import 'package:flutter/material.dart';

enum CarouselTypes { home, details }

class CarouselList extends StatefulWidget {
  final CarouselTypes type;
  final List<String> imagesList;
  const CarouselList({
    Key key,
    @required this.type,
    @required this.imagesList,
  }) : super(key: key);
  @override
  _CarouselListState createState() => _CarouselListState(imagesList: imagesList);
}

class _CarouselListState extends State<CarouselList> {
  final List<String> imagesList;

  _CarouselListState({this.imagesList});

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Column(
        children: <Widget>[
          Expanded(
            child: PageView.builder(
              controller: PageController(
                viewportFraction:
                widget.type == CarouselTypes.details ? .75 : .95,
              ),
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: widget.imagesList.length,
              itemBuilder: (ctx, id) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: widget.type == CarouselTypes.details
                        ? Colors.white
                        : Colors.transparent,
                  ),
                  margin: widget.type == CarouselTypes.details &&
                      _currentIndex != id
                      ? const EdgeInsets.symmetric(
                    horizontal: 9.0,
                    vertical: 15,
                  )
                      : const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 0,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/lookgood-cb008385.appspot.com/o/images%2Facg-mens-long-sleeve-t-shirt-ZR8hKZ%20(3).jpg?alt=media&token=3c7d77cc-671f-4665-9340-2297d332267b",
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 9),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              imagesList.length,
                  (i) {
                return Container(
                  width: 9,
                  height: 9,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i == _currentIndex ? Colors.black : Colors.grey,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}