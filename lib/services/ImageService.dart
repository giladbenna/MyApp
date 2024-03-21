import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:my_app/models/ImageData.dart';
import 'package:my_app/models/ImageDataDetails.dart';

class ImageService {
  Future<List<ImageData>> loadImageDetailsByCategory(String category) async {
    final String response = await rootBundle
        .loadString('assets/data/$category/image_details_$category.json');
    //print('Response: $response'); // Check the raw response
    final List<dynamic> data = json.decode(response);
    //print('Decoded data: $data'); // Check the decoded data
    return data.map((item) => ImageData.fromJson(item)).toList();
  }

  Future<List<ImageData>> loadImageData() async {
    final String response =
        await rootBundle.loadString('assets/data/menu_images.json');
    print('Response: $response'); // Check the raw response
    final List<dynamic> data = json.decode(response);
    print('Decoded data: $data'); // Check the decoded data
    return data.map((item) => ImageData.fromJson(item)).toList();
  }

  Future<ImageDataDetails> loadImageCategoryDetails(
      String id, String category) async {
    final String response = await rootBundle
        .loadString('assets/data/$category/image_details_${category}_$id.json');
    final data = json.decode(response);
    return ImageDataDetails.fromJson(data);
  }
}
