class ImportantThing {
  final String imageUrl;
  final String link;

  ImportantThing({required this.imageUrl, required this.link});

  factory ImportantThing.fromJson(Map<String, dynamic> json) {
    return ImportantThing(
      imageUrl: json['imageUrl'],
      link: json['link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'link': link,
    };
  }
}
