class ItemResult {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  Rating rating;

  ItemResult.fromJson(Map<dynamic, dynamic> json) {
    id = json["id"];
    title = json["title"];
    price = json["price"].toDouble();
    description = json["description"];
    category = json["category"];
    image = json["image"];
    rating = Rating.fromJson(json["rating"]);
  }
}

class Rating {
  double rate;
  int count;

  Rating.fromJson(Map<dynamic, dynamic> json) {
    rate = json["rate"].toDouble();
    count = json["count"];
  }
}
