import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    await _notificationsPlugin.initialize(initializationSettings);
    
    // طلب إذن المستخدم (ضروري في أندرويد 13+)
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission();
  }

  static void showOrderNotification(String title, String body) {
    const NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        'order_channel', 'Order Updates',
        importance: Importance.max, priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      ),
    );
    _notificationsPlugin.show(0, title, body, details);
  }
}
