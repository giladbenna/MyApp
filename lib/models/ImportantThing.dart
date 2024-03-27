class ImportantThing {
  final String imageUrl;
  final String link;
  final String? title; // Add this line

  ImportantThing({
    required this.imageUrl,
    required this.link,
    required this.title, // Add this line
  });

  factory ImportantThing.fromJson(Map<String, dynamic> json) {
    return ImportantThing(
      imageUrl: json['imageUrl'],
      link: json['link'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'imageUrl': imageUrl, 'link': link, 'title': title};
  }
}
