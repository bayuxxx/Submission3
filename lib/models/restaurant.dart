class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      pictureId: json['pictureId'],
      city: json['city'],
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }

  static List<Restaurant> fromJsonList(dynamic jsonList) {
    if (jsonList is List) {
      return jsonList.map((json) => Restaurant.fromJson(json)).toList();
    } else if (jsonList is Map<String, dynamic>) {
      return [Restaurant.fromJson(jsonList)]; // Treat it as a single restaurant
    } else {
      throw const FormatException(
          "Invalid JSON format for the list of restaurants");
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      }..removeWhere((key, value) => value == null);
}
