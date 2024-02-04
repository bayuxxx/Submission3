import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:submission2/data/database_helper.dart';
import 'package:submission2/models/favorite_restaurant.dart';
import 'package:submission2/models/restaurant_detail.dart';
import 'restaurant_detail_provider.dart';

class FavoritesProvider extends ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<FavoriteRestaurant> _favorites = [];
  static const String _favoritesKey = 'favorites';

  List<FavoriteRestaurant> get favorites => _favorites;

  final bool _isLoading = false;

  bool get isLoading => _isLoading;
  FavoritesProvider() {
    // Don't call asynchronous methods directly in the constructor
    // loadFavorites();
    // Instead, use an initialization method
    initialize();
  }

  Future<void> initialize() async {
    await loadFavorites();
    notifyListeners();
  }

  // FavoritesProvider() {
  //   loadFavorites();
  //   notifyListeners();
  // }

  Future<void> addToFavorites(RestaurantDetail restaurant) async {
    if (!_favorites.any((favorite) => favorite.id == restaurant.id)) {
      final favoriteRestaurant = FavoriteRestaurant(
        id: restaurant.id,
        name: restaurant.name,
        pictureId: restaurant.pictureId,
        rating: restaurant.rating,
        city: restaurant.city,
      );

      _favorites.add(favoriteRestaurant);
      notifyListeners();
      await _databaseHelper.insertFavorite(favoriteRestaurant);
    }
  }

  bool isFavorite(String restaurantId) {
    return _favorites.any((favorite) => favorite.id == restaurantId);
  }

  Future<void> toggleFavoriteStatus(String restaurantId) async {
    final restaurantDetailProvider = RestaurantDetailProvider();

    if (restaurantDetailProvider.restaurantDetail != null) {
      final restaurantDetail = restaurantDetailProvider.restaurantDetail!;

      if (isFavorite(restaurantId)) {
        await removeFromFavorites(restaurantId);
        notifyListeners();
      } else {
        await addToFavorites(restaurantDetail);
        notifyListeners();
      }
      await saveFavoritesAndNotify();
      notifyListeners();
    } else {
      await restaurantDetailProvider.fetchRestaurantDetail(restaurantId);
      final updatedRestaurantDetail = restaurantDetailProvider.restaurantDetail;
      if (updatedRestaurantDetail != null) {
        if (isFavorite(restaurantId)) {
          removeFromFavorites(restaurantId);
          notifyListeners();
        } else {
          await addToFavorites(updatedRestaurantDetail);
          notifyListeners();
        }
        await saveFavoritesAndNotify();
        notifyListeners();
      }
    }
    notifyListeners();
  }

  Future<void> removeFromFavorites(String restaurantId) async {
    _favorites.removeWhere((favorite) => favorite.id == restaurantId);
    notifyListeners();
    await _databaseHelper.deleteFavorite(restaurantId);
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson =
        jsonEncode(_favorites.map((fav) => fav.toMap()).toList());
    prefs.setString(_favoritesKey, favoritesJson);
    notifyListeners();
  }

  Future<void> saveFavoritesAndNotify() async {
    await saveFavorites();
    notifyListeners();
  }

  Future<void> loadFavorites() async {
    _favorites = await _databaseHelper.getFavorites();
    notifyListeners();
  }
}
