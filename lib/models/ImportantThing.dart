class ImportantThing {
  final String imageUrl;
  final String link;
  final String? title;
  final double? price;

  ImportantThing(
      {required this.imageUrl,
      required this.link,
      required this.title,
      required this.price});

  factory ImportantThing.fromJson(Map<String, dynamic> json) {
    return ImportantThing(
        imageUrl: json['imageUrl'],
        link: json['link'],
        title: json['title'],
        price: json['price'].toDouble());
  }

  Map<String, dynamic> toJson() {
    return {'imageUrl': imageUrl, 'link': link, 'title': title, 'price': price};
  }
}
