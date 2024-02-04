// File: lib/providers/restaurant_provider.dart
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:submission2/models/restaurant.dart';

class RestaurantProvider with ChangeNotifier {
  List<Restaurant> _restaurants = [];
  List<Restaurant> get restaurants => _restaurants;

  bool _isConnected = true;
  bool get isConnected => _isConnected;

  final String _error = '';
  String get error => _error;

  bool _isDisposed = false;

  http.Client _httpClient = http.Client();
  set httpClient(http.Client client) {
    _httpClient = client;
  }

  Future<void> fetchRestaurants() async {
    try {
      if (_isDisposed) {
        return;
      }
      final responseRestaurants = await _httpClient.get(
        Uri.parse('https://restaurant-api.dicoding.dev/list'),
      );
      if (_isDisposed) {
        return;
      }
      if (responseRestaurants.statusCode == 200) {
        final List<dynamic> data =
            json.decode(responseRestaurants.body)['restaurants'];

        _restaurants = data.map((json) => Restaurant.fromJson(json)).toList();

        if (!_isDisposed) {
          notifyListeners();
        }
      } else {
        _handleError('Failed to load restaurants');
      }
    } on SocketException catch (_) {
      if (!_isDisposed) {
        _handleError(
          'No internet connection. Please check your connection and try again.',
        );
      }
    }
  }

  void _handleError(String errorMessage) {
    if (!_isDisposed) {
      _isConnected = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
