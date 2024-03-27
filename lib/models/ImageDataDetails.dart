import 'package:my_app/models/ImportantThing.dart';

class ImageDataDetails {
  final String id;
  final String url;
  final String profileImage;
  final String title;
  final String description;
  final String location;
  final List<ImportantThing> importantThings; // Updated to use ImportantThing

  ImageDataDetails({
    required this.id,
    required this.url,
    required this.profileImage,
    required this.title,
    required this.description,
    required this.location,
    required this.importantThings, // Initialize in constructor
  });

  factory ImageDataDetails.fromJson(Map<String, dynamic> json) {
    var thingsList = <ImportantThing>[];
    if (json['importantThings'] != null) {
      json['importantThings'].forEach((v) {
        thingsList.add(ImportantThing.fromJson(v));
      });
    }
    return ImageDataDetails(
      id: json['id'],
      url: json['url'],
      profileImage: json['profile_image'],
      title: json['title'],
      description: json['description'],
      location: json['location'],
      importantThings: thingsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'profile_image': profileImage,
      'title': title,
      'description': description,
      'location': location,
      'importantThings': importantThings.map((v) => v.toJson()).toList(),
    };
  }
}
