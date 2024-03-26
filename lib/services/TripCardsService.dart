import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:my_app/models/RecommendTripCard.dart';

class TripCardsService {
  Future<List<RecommendTripCard>> fetchTripCardsByCategoryAndId(
      String category, String id) async {
    final String response = await rootBundle
        .loadString('assets/data/$category/trip_cards/trip_cards_$id.json');
    final data = json.decode(response) as List;
    return data.map((item) => RecommendTripCard.fromJson(item)).toList();
  }
}
