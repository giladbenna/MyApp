class RecommendTripDetails {
  final String id;
  final String title;
  final String subTitle;
  final double rates;
  final int reviews;
  final double cost;
  final String description;
  final bool isFreeCancel;
  final double time;
  final List<String> urls;
  final List<String> popularDays;
  final List<String> languages;

  RecommendTripDetails(
      {required this.id,
      required this.title,
      required this.subTitle,
      required this.rates,
      required this.reviews,
      required this.cost,
      required this.description,
      required this.isFreeCancel,
      required this.time,
      required this.urls,
      required this.popularDays,
      required this.languages});

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
      popularDays: List<String>.from(json['popularDays']),
      languages: List<String>.from(json['languages']),
      isFreeCancel: json['isFreeCancel'],
      time: json['time'].toDouble(),
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
      'isFreeCancel': isFreeCancel,
      'time': time,
      'urls': urls,
      'popularDays': popularDays,
      'languages': languages
    };
  }
}
