class RecommendTripDetails {
  final String id;
  final String title;
  final String subTitle;
  final double rates;
  final int reviews;
  final double cost;
  final String description;
  final List<String> urls;
  final List<String> popularDays; // Add this line

  RecommendTripDetails({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.rates,
    required this.reviews,
    required this.cost,
    required this.description,
    required this.urls,
    required this.popularDays, // Add this line
  });

  factory RecommendTripDetails.fromJson(Map<String, dynamic> json) {
    return RecommendTripDetails(
      id: json['id'],
      title: json['title'],
      subTitle: json['subTitle'],
      rates: json['rates'].toDouble(),
      reviews: json['reviews'],
      cost: json['cost'].toDouble(),
      description: json['description'],
      urls: List<String>.from(json['urls']),
      popularDays: List<String>.from(json['popularDays']), // Add this line
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subTitle': subTitle,
      'rates': rates,
      'reviews': reviews,
      'cost': cost,
      'description': description,
      'urls': urls,
      'popularDays': popularDays, // Add this line
    };
  }
}
