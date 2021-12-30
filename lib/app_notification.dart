import 'package:flutter_background_location/constants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';

class AppNotification {
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  AppNotification() {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsIOS = IOSInitializationSettings();
    const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin!.initialize(initializationSettings);
  }

  Future showNotificationWithoutSound(Position position) async {
    logger.d("Postion: ${position.toString()}");
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '1', 'fetch location in background',
        playSound: true, importance: Importance.max, priority: Priority.high);
    const iOSPlatformChannelSpecifics =
        IOSNotificationDetails(presentSound: false);
    const platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin!.show(
      0,
      'Location fetched',
      position.toString(),
      platformChannelSpecifics,
      payload: '',
    );
  }
}
