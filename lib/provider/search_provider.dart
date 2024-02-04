import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:submission2/models/restaurant.dart';
import 'connectivity_provider.dart';

class SearchProvider with ChangeNotifier {
  String _searchQuery = '';
  List<Restaurant> _searchResults = [];
  bool _isLoading = false;
  final ConnectivityProvider _connectivityProvider = ConnectivityProvider();

  String get searchQuery => _searchQuery;
  List<Restaurant> get searchResults => _searchResults;
  bool get isLoading => _isLoading;

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> searchRestaurants() async {
    try {
      setLoading(true);
      if (!_connectivityProvider.isDisposed) {
        await _connectivityProvider.updateConnectivityStatus();
        if (_connectivityProvider.isConnected) {
          final response = await http.get(Uri.parse(
              "https://restaurant-api.dicoding.dev/search?q=$_searchQuery"));

          // Check if ConnectivityProvider is not disposed
          if (!_connectivityProvider.isDisposed) {
            if (response.statusCode == 200) {
              final Map<String, dynamic> data = json.decode(response.body);
              if (data['error'] == false) {
                final List<dynamic> searchResults = data['restaurants'];
                _searchResults = searchResults
                    .map((json) => Restaurant.fromJson(json))
                    .toList();
                notifyListeners();
              } else {
                _searchResults = [];
              }
            } else {
              _searchResults = [];
            }
          }
        } else {
          _searchResults = [];
        }
      }
    } catch (error) {
      _searchResults = [];
    } finally {
      setLoading(false);
    }
  }

  @override
  void dispose() {
    _connectivityProvider.dispose();
    super.dispose();
  }
}
