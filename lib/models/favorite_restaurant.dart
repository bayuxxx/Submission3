class FavoriteRestaurant {
  String id;
  String name;
  String pictureId;
  double rating;
  String city;

  FavoriteRestaurant({
    required this.id,
    required this.name,
    required this.pictureId,
    required this.rating,
    required this.city,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'pictureId': pictureId,
      'rating': rating,
      'city': city,
    };
  }

  // Add a factory constructor to create a FavoriteRestaurant instance from a map
  factory FavoriteRestaurant.fromMap(Map<String, dynamic> map) {
    return FavoriteRestaurant(
      id: map['id'],
      name: map['name'],
      pictureId: map['pictureId'],
      rating: map['rating'],
      city: map['city'],
    );
  }
}
