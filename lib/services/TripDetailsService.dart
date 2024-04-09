import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:my_app/models/RecommendTripDetails.dart';

class TripDetailsService {
  Future<RecommendTripDetails> fetchTripDetails(
      String categoryId, String tripId) async {
    // Adjust the path according to your JSON files' structure
    final String response = await rootBundle.loadString(
        'assets/data/$categoryId/trip_cards/trip_cards_details/trip_cards_details_$tripId.json');
    final data = json.decode(response);
    return RecommendTripDetails.fromJson(data);
  }
}
