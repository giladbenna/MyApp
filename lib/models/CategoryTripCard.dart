class CategoryTripCard {
  final String id;
  final String url;
  final String title;
  final String subTitle;
  final String location;
  bool favorite; // Made mutable

  CategoryTripCard(
      {required this.id,
      required this.url,
      required this.title,
      required this.subTitle,
      required this.location,
      required this.favorite});

  factory CategoryTripCard.fromJson(Map<String, dynamic> json) {
    return CategoryTripCard(
      id: json['id'],
      url: json['url'],
      title: json['title'],
      subTitle: json['subTitle'],
      location: json['location'],
      favorite: json['favorite'] ?? false, // Safely handle null or missing key
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'title': title,
      'subTitle': subTitle,
      'location': location,
      'favorite': favorite,
    };
  }
}
