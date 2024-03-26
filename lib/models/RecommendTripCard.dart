class RecommendTripCard {
  final String urlPicture;
  final String subTitle;
  final String title;
  final String time;
  final double rate;
  final double cost;
  final int likes;

  RecommendTripCard({
    required this.urlPicture,
    required this.subTitle,
    required this.title,
    required this.time,
    required this.rate,
    required this.cost,
    required this.likes,
  });

  factory RecommendTripCard.fromJson(Map<String, dynamic> json) {
    return RecommendTripCard(
      urlPicture: json['urlPicture'],
      subTitle: json['subTitle'],
      title: json['title'],
      time: json['time'],
      rate: json['rate'].toDouble(),
      cost: json['cost'].toDouble(),
      likes: json['likes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'urlPicture': urlPicture,
      'subTitle': subTitle,
      'title': title,
      'time': time,
      'rate': rate,
      'cost': cost,
      'likes': likes,
    };
  }
}
