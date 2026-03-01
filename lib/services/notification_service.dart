import 'package:flutter/material.dart'; // إضافة الاستيراد المفقود
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    await _notifications.initialize(settings);
  }

  static Future<void> showNotification(String title, String body) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'flex_channel', 'Flex Notifications',
        importance: Importance.max,
        priority: Priority.high,
        color: Color(0xFFD4AF37), // الآن سيعمل بنجاح
      ),
    );
    await _notifications.show(0, title, body, details);
  }
}
