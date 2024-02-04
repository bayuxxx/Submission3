import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:submission2/models/restaurant.dart';
import 'package:submission2/screen/detail_screen.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse details) async {
      final payload = details.payload;
      if (payload != null) {}
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    List<Restaurant> restaurants,
  ) async {
    var channelId = "1";
    var channelName = "channel_01";
    var channelDescription = "dicoding news channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: const DefaultStyleInformation(true, true),
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    var shuffledRestaurants = List.from(restaurants)..shuffle();

    if (shuffledRestaurants.isNotEmpty) {
      var randomRestaurant = shuffledRestaurants.first;
      var header =
          "<b> ${randomRestaurant.name} </b>"; // Use restaurant name as header
      var body = "Recommendation Restaurant For You"; // Fixed body text

      await flutterLocalNotificationsPlugin.show(
        0,
        header,
        body,
        platformChannelSpecifics,
        payload: json.encode(randomRestaurant.toJson()),
      );
    } else {
      // print("No restaurants available for notification");
    }
  }

  void configureSelectNotificationSubject(
    BuildContext context,
  ) {
    selectNotificationSubject.stream.listen(
      (String payload) {
        // print('Notification tapped with payload: $payload');

        var data = Restaurant.fromJson(json.decode(payload));
        var restaurant =
            data; // Assuming data is a single restaurant, adjust as needed

        // Use the correct context from the details parameter
        // print('Navigating to DetailScreen...');
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailScreen(restaurantId: restaurant.id);
        }));
      },
    );
  }
}
