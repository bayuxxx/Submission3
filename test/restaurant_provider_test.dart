import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:submission2/provider/restaurant_provider.dart';

// Mock class for http.Client
class MockClient extends Mock implements http.Client {}

void main() {
  group('RestaurantProvider Tests', () {
    late RestaurantProvider restaurantProvider;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      restaurantProvider = RestaurantProvider();
      restaurantProvider.httpClient = mockClient;
    });

    test('fetchRestaurants Success', () async {
      // Arrange
      when(mockClient.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
          .thenAnswer((_) async => http.Response('{"restaurants": []}', 200));

      // Act
      await restaurantProvider.fetchRestaurants();

      // Assert
      expect(restaurantProvider.restaurants, isEmpty);
      expect(restaurantProvider.isConnected, isTrue);
      verify(mockClient.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
          .called(1);
    });

    test('fetchRestaurants Failure', () async {
      // Arrange
      when(mockClient.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
          .thenAnswer((_) async => http.Response('Error', 404));

      // Act
      await restaurantProvider.fetchRestaurants();

      // Assert
      expect(restaurantProvider.restaurants, isEmpty);
      expect(restaurantProvider.isConnected, isFalse);
      expect(restaurantProvider.error, 'Failed to load restaurants');
      verify(mockClient.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
          .called(1);
    });

    test('fetchRestaurants No Internet Connection', () async {
      // Arrange
      when(mockClient.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
          .thenThrow(SocketException('No internet connection'));

      // Act
      await restaurantProvider.fetchRestaurants();

      // Assert
      expect(restaurantProvider.restaurants, isEmpty);
      expect(restaurantProvider.isConnected, isFalse);
      expect(restaurantProvider.error,
          'No internet connection. Please check your connection and try again.');
      verify(mockClient.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
          .called(1);
    });
  });
}
