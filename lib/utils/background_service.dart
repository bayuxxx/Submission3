import 'dart:convert';
import 'dart:ui';
import 'dart:isolate';
import 'package:http/http.dart' as http;
import 'package:submission2/main.dart';
import 'package:submission2/models/restaurant.dart';
import 'package:submission2/utils/notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      isolateName,
    );
  }

  @pragma('vm:entry-point')
  static Future<void> callback() async {
    // print('Alarm fired!');
    final NotificationHelper notificationHelper = NotificationHelper();

    final response = await http.get(
      Uri.parse('https://restaurant-api.dicoding.dev/list'),
    );
    // print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        final dynamic responseBody = jsonDecode(response.body);
        if (responseBody != null && responseBody is Map<String, dynamic>) {
          final restaurantList =
              Restaurant.fromJsonList(responseBody['restaurants']);
          // print('restaurantList = $restaurantList');
          await notificationHelper.showNotification(
            flutterLocalNotificationsPlugin,
            restaurantList,
          );
        } else {
          // print('Invalid JSON format in response body');
        }
      } catch (e) {
        // print('Error parsing JSON: $e');
      }
    } else {
      // print('Failed to fetch data: ${response.reasonPhrase}');
    }

    _uiSendPort ??= IsolateNameServer.lookupPortByName(isolateName);
    _uiSendPort?.send(null);
  }
}
