class TotalRating{
  int counter;
  double totalRating;

  TotalRating({
    this.counter,
    this.totalRating,});



  TotalRating.fromMap(Map<dynamic, dynamic> mapData) {
    this.counter = mapData["counter"];
    this.totalRating=mapData["totalRating"].toDouble();

  }

}