import 'package:supabase_flutter/supabase_flutter.dart';
import 'sound_service.dart';

class OrderService {
  static Future<void> placeOrder(Map<String, dynamic> orderData) async {
    final supabase = Supabase.instance.client;
    
    // إدخال الطلب في قاعدة البيانات
    await supabase.from('orders').insert(orderData);
    
    // تشغيل صوت الكاشير فوراً!
    await SoundService.playCashSound();
  }
}
