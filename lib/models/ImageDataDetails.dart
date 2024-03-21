class ImageDataDetails {
  final String id;
  final String url;
  final String profileImage;
  final String title;
  final String description;
  final String location;
  final List<String> importantThingsImages; // New field
  final List<String> importantThingsLinks;

  ImageDataDetails(
      {required this.id,
      required this.url,
      required this.profileImage,
      required this.title,
      required this.description,
      required this.location,
      required this.importantThingsImages, // Initialize in constructor
      required this.importantThingsLinks});

  factory ImageDataDetails.fromJson(Map<String, dynamic> json) {
    return ImageDataDetails(
      id: json['id'],
      url: json['url'],
      profileImage: json['profile_image'],
      title: json['title'],
      description: json['description'],
      location: json['location'],
      importantThingsImages: List<String>.from(json['importantThingsImages']),
      importantThingsLinks: List<String>.from(json['importantThingsLinks']),
    );
  }
}
