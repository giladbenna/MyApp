class CategoryTripCard {
  final String id;
  final String url;
  final String title;

  CategoryTripCard({
    required this.id,
    required this.url,
    required this.title,
  });

  factory CategoryTripCard.fromJson(Map<String, dynamic> json) {
    return CategoryTripCard(
      id: json['id'],
      url: json['url'],
      title: json['title'],
    );
  }
}
