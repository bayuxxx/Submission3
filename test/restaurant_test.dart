import 'package:submission2/models/restaurant.dart';
import 'package:test/test.dart';

void main() {
  group('Restaurant Tests', () {
    test('Test Restaurant fromJson', () {
      // Arrange
      final Map<String, dynamic> json = {
        'id': '1',
        'name': 'Restaurant A',
        'description': 'A cozy place to dine',
        'pictureId': 'image1.jpg',
        'city': 'City X',
        'rating': 4.5,
      };

      final Restaurant restaurant = Restaurant.fromJson(json);

      expect(restaurant.id, equals('1'));
      expect(restaurant.name, equals('Restaurant A'));
      expect(restaurant.description, equals('A cozy place to dine'));
      expect(restaurant.pictureId, equals('image1.jpg'));
      expect(restaurant.city, equals('City X'));
      expect(restaurant.rating, equals(4.5));
    });

    test('Test Restaurant fromJsonList - Single Restaurant', () {
      final dynamic jsonList = {
        'id': '1',
        'name': 'Restaurant A',
        'description': 'A cozy place to dine',
        'pictureId': 'image1.jpg',
        'city': 'City X',
        'rating': 4.5,
      };

      final List<Restaurant> restaurants = Restaurant.fromJsonList(jsonList);

      expect(restaurants.length, equals(1));
      expect(restaurants[0].id, equals('1'));
    });

    test('Test Restaurant fromJsonList - List of Restaurants', () {
      // Arrange
      final dynamic jsonList = [
        {
          'id': '1',
          'name': 'Restaurant A',
          'description': 'A cozy place to dine',
          'pictureId': 'image1.jpg',
          'city': 'City X',
          'rating': 4.5,
        },
        {
          'id': '2',
          'name': 'Restaurant B',
          'description': 'Delicious food in City Y',
          'pictureId': 'image2.jpg',
          'city': 'City Y',
          'rating': 4.0,
        },
      ];

      // Act
      final List<Restaurant> restaurants = Restaurant.fromJsonList(jsonList);

      // Assert
      expect(restaurants.length, equals(2));
      expect(restaurants[0].id, equals('1'));
      expect(restaurants[1].id, equals('2'));
    });

  });
}
