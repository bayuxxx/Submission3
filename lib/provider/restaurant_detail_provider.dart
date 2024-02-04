import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:submission2/models/restaurant_detail.dart';
import 'package:submission2/provider/favorites_provider.dart';
import 'package:submission2/provider/review_provider.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  RestaurantDetail? _restaurantDetail;
  final FavoritesProvider _favoritesProvider = FavoritesProvider();

  RestaurantDetail? get restaurantDetail => _restaurantDetail;

  String? get restaurantName => _restaurantDetail?.name;

  bool isFavorite(String restaurantId) {
    return _favoritesProvider.favorites
        .any((favorite) => favorite.id == restaurantId);
  }

  Future<void> toggleFavoriteStatus(String restaurantId) async {
    if (isFavorite(restaurantId)) {
      await _favoritesProvider.removeFromFavorites(restaurantId);
      notifyListeners();
    } else {
      final restaurantDetail = _restaurantDetail;
      if (restaurantDetail != null) {
        await _favoritesProvider.addToFavorites(restaurantDetail);
        notifyListeners();
      }
    }
    notifyListeners();
  }

  Future<void> fetchRestaurantDetail(String restaurantId) async {
    try {
      final response = await http.get(Uri.parse(
          "https://restaurant-api.dicoding.dev/detail/$restaurantId"));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data.containsKey('restaurant')) {
          final restaurantDetail =
              RestaurantDetail.fromJson(data['restaurant']);
          _restaurantDetail = restaurantDetail;
          notifyListeners();
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        if (kDebugMode) {
          print(
              "Error: Failed to load restaurant details. Status code: ${response.statusCode}");
        }
        throw Exception('Failed to load restaurant details');
      }
    } catch (_) {}
  }

  Future<void> submitReview(
      BuildContext context, ReviewProvider reviewProvider) async {
    await _submitReview(context, reviewProvider);
    notifyListeners();
  }

  Future<void> _submitReview(
      BuildContext context, ReviewProvider reviewProvider) async {
    final String id = restaurantDetail?.id ?? "";
    final String name = reviewProvider.nameController.text;
    final String review = reviewProvider.reviewController.text;

    if (id.isEmpty || name.isEmpty || review.isEmpty) {
      Get.snackbar('Error', 'Name and review cannot be empty');
      if (kDebugMode) {
        print('Error: Restaurant ID, name, and review cannot be empty');
      }
      return;
    }

    final reviewData = {"id": id, "name": name, "review": review};

    try {
      reviewProvider.addReview(reviewData);

      final response = await http.post(
        Uri.parse("https://restaurant-api.dicoding.dev/review"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(reviewData),
      );

      if (response.statusCode == 201) {
        await fetchRestaurantDetail(id);
        Get.snackbar('Success', 'Review added successfully');
        notifyListeners();
        if (kDebugMode) {
          print('Success: Review added successfully');
        }
      } else {
        if (kDebugMode) {
          print("Failed to add review. Status code: ${response.statusCode}");
        }
      }
    } on SocketException catch (_) {
      Get.snackbar(
          'Error', 'No internet connection. Please check your connection.');
      if (kDebugMode) {}
    } catch (error) {
      if (kDebugMode) {}
    }
  }
}
