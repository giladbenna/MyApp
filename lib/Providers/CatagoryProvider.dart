import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  String _selectedCategory = '';

  String get selectedCategory => _selectedCategory;

  void updateCategory(String category) {
    _selectedCategory = category;
    notifyListeners(); // Notify widgets listening to the change.
  }
}
