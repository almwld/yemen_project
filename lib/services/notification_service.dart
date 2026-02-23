import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future initialize() async {
    // طلب إذن من المستخدم لإرسال الإشعارات
    NotificationSettings settings = await _fcm.requestPermission();
    
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('تم تفعيل الإشعارات بنجاح');
      
      // الحصول على "Token" الجهاز لإرسال إشعارات مخصصة إذا أردت
      String? token = await _fcm.getToken();
      print("Token الجهاز: $token");
    }

    // التعامل مع الإشعارات أثناء فتح التطبيق
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("وصل إشعار جديد: ${message.notification?.title}");
    });
  }
}
