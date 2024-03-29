import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:my_app/models/CategoryTripCard.dart';

class CategoryTripService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // Update to accept a category parameter for dynamic file paths
  Future<File> _localFile(String category) async {
    final path = await _localPath;
    return File('$path/image_details_$category.json');
  }

  // Adjust to include the category in the method signature
  Future<List<CategoryTripCard>> loadItems(String category) async {
    try {
      final file = await _localFile(category);
      // Check if the local file exists, if not, initialize from assets
      if (!await file.exists()) {
        final data = await rootBundle
            .loadString('assets/data/$category/image_details_$category.json');
        await file.writeAsString(data);
      }
      final contents = await file.readAsString();
      final List<dynamic> jsonResponse = jsonDecode(contents);
      return jsonResponse
          .map((data) => CategoryTripCard.fromJson(data))
          .toList();
    } catch (e) {
      // If encountering an error, return an empty list
      return [];
    }
  }

  // Adjust to include the category in the method signature
  Future<void> saveItems(String category, List<CategoryTripCard> items) async {
    final file = await _localFile(category);
    final String json = jsonEncode(items.map((item) => item.toJson()).toList());
    // Inside saveItems method, right after the write operation
    try {
      await file.writeAsString(json);
      print("Write successful");
    } catch (e) {
      print("Error writing file: $e");
    }

    print("Content supposedly written to file.");

// Read back to verify
    final verifyContents = await file.readAsString();
    print("Contents of file now: $verifyContents");
  }

  // Adjust to include the category in the method signature
  Future<void> updateFavoriteStatus(
      String category, String id, bool newStatus) async {
    print("Updating favorite status for $id in $category to $newStatus");
    List<CategoryTripCard> items = await loadItems(category);
    int index = items.indexWhere((item) => item.id == id);
    if (index != -1) {
      items[index].favorite = newStatus;
      await saveItems(category, items);
      print("Saved items back to file. , ${items[index].favorite}");
    }
  }
}
