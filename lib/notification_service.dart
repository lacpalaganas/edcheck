import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Future<void> showNotification(
  //     int id, String title, String body, int seconds) async {
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //     id,
  //     title,
  //     body,
  //     tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
  //     const NotificationDetails(
  //       android: AndroidNotificationDetails('main_channel', 'Main Channel',
  //           importance: Importance.max,
  //           priority: Priority.max,
  //           timeoutAfter: 1,
  //           playSound: false,
  //           icon: '@mipmap/ic_launcher'),
  //       iOS: IOSNotificationDetails(
  //         sound: 'default.wav',
  //         presentAlert: true,
  //         presentBadge: true,
  //         presentSound: true,
  //       ),
  //     ),
  //     uiLocalNotificationDateInterpretation:
  //         UILocalNotificationDateInterpretation.absoluteTime,
  //     androidAllowWhileIdle: true,
  //   );
  // }
  Future<void> showNotification(
    int id,
    String title,
    String body,
  ) async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      importance: Importance.max,
      priority: Priority.high,
      playSound: false,
      timeoutAfter: 9,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidChannelSpecifics, iOS: iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      id, // Notification ID
      title, // Notification Title
      body, // Notification Body, set as null to remove the body
      platformChannelSpecifics,
      payload: 'New Payload', // Notification Payload
    );
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
