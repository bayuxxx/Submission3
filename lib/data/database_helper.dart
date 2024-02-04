import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:submission2/models/favorite_restaurant.dart';

class DatabaseHelper {
  static const String _databaseName = 'favorites_database.db';
  static const String _tableName = 'favorites';

  late Database _database;

  DatabaseHelper() {
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _databaseName);

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $_tableName (
            id TEXT PRIMARY KEY,
            name TEXT,
            pictureId TEXT,
            rating REAL,
            city TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertFavorite(FavoriteRestaurant favorite) async {
    await _initDatabase(); // Ensure the database is initialized before use
    await _database.insert(_tableName, favorite.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteFavorite(String restaurantId) async {
    await _initDatabase(); // Ensure the database is initialized before use
    await _database
        .delete(_tableName, where: 'id = ?', whereArgs: [restaurantId]);
  }

  Future<List<FavoriteRestaurant>> getFavorites() async {
    await _initDatabase(); // Ensure the database is initialized before use
    final List<Map<String, dynamic>> maps = await _database.query(_tableName);
    return List.generate(maps.length, (i) {
      return FavoriteRestaurant.fromMap(maps[i]);
    });
  }
}
