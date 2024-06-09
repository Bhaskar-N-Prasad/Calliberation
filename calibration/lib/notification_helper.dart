import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  static final _notification = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    // Initialize timezones
    tz.initializeTimeZones();

    // Initialize the plugin
    const androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOSInitializationSettings = DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        // Handle notification tapped when app is in foreground (iOS-specific)
      },
    );

    final initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iOSInitializationSettings,
    );

    await _notification.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
        // Handle notification tapped (common for both Android & iOS)
      },
    );

    // Request iOS permissions
    await _notification
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  static Future<void> scheduledNotification(String title, String body, DateTime scheduledDateTime) async {
    try {
      var androidDetails = AndroidNotificationDetails(
        "important_notifications",
        "My_Channel",
        importance: Importance.max,
        priority: Priority.high,
      );

      var iosDetails = DarwinNotificationDetails();
      var notificationDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);

      // Convert DateTime to TZDateTime
      final tzScheduledDateTime = tz.TZDateTime.from(scheduledDateTime, tz.local);

      await _notification.zonedSchedule(
        0,
        title,
        body,
        tzScheduledDateTime,
        notificationDetails,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true, // Ensure allowWhileIdle is set to true
      );
      print("Notification scheduled successfully");
    } catch (e) {
      print("Error scheduling notification: $e");
    }
  }
}
