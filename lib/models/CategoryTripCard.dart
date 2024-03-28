class CategoryTripCard {
  final String id;
  final String url;
  final String title;
  final String subTitle;
  final String location;

  CategoryTripCard(
      {required this.id,
      required this.url,
      required this.title,
      required this.subTitle,
      required this.location});

  factory CategoryTripCard.fromJson(Map<String, dynamic> json) {
    return CategoryTripCard(
      id: json['id'],
      url: json['url'],
      title: json['title'],
      subTitle: json['subTitle'],
      location: json['location'],
    );
  }
}
