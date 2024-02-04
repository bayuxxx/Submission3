import 'package:flutter/material.dart';

class ReviewProvider extends ChangeNotifier {
  final List<Map<String, String>> _reviews = [];
  String? _restaurantName;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  List<Map<String, String>> get reviews => _reviews;

  String? get restaurantName => _restaurantName;

  TextEditingController get nameController => _nameController;

  TextEditingController get reviewController => _reviewController;

  void setRestaurantName(String name) {
    _restaurantName = name;
    notifyListeners();
  }

  void clearControllers() {
    nameController.clear();
    reviewController.clear();
    notifyListeners();
  }

  void addReview(Map<String, String> review) {
    _reviews.add(review);
    _nameController.clear();
    _reviewController.clear();
    notifyListeners();
  }
}
