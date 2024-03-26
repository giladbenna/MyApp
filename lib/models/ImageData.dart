class ImageData {
  final String id;
  final String url;
  final String title;
  final String category; // Make category nullable

  ImageData({
    required this.id,
    required this.url,
    required this.title,
    required this.category, // Remove required and add a default value in the factory constructor
  });

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      id: json['id'],
      url: json['url'],
      title: json['title'],
      category: json['category'] ??
          "", // Provide a default empty string if category is null
    );
  }
}
