import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:submission2/provider/connectivity_provider.dart';
import 'package:submission2/provider/review_provider.dart';
import 'package:submission2/provider/scheduling_provider.dart';
import 'package:submission2/screen/splash_screen.dart';
import 'package:submission2/utils/background_service.dart';
import 'package:submission2/utils/notification_helper.dart';
import 'provider/favorites_provider.dart';
import 'provider/restaurant_detail_provider.dart';
import 'provider/restaurant_provider.dart';
import 'provider/search_provider.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  await AndroidAlarmManager.initialize();

  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => RestaurantProvider()),
            ChangeNotifierProvider(
                create: (context) => RestaurantDetailProvider()),
            ChangeNotifierProvider(create: (context) => SearchProvider()),
            ChangeNotifierProvider(create: (context) => ReviewProvider()),
            ChangeNotifierProvider(create: (context) => ConnectivityProvider()),
            // ChangeNotifierProvider.value(
            //   value: FavoritesProvider(),
            // ),
            ChangeNotifierProvider(create: (context) => SchedulingProvider()),
            ChangeNotifierProvider(create: (context) => FavoritesProvider()),
          ],
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Restaurant App',
            home: SplashScreen(),
          ),
        );
      },
    );
  }
}
