import 'package:supabase_flutter/supabase_flutter.dart';

class OrderEngine {
  final supabase = Supabase.instance.client;

  // 1. تنفيذ عملية شراء وخصم من المحفظة
  Future<bool> processPurchase(String userId, double amount, String sellerId) async {
    try {
      // خصم من محفظة المشتري
      await supabase.rpc('deduct_from_wallet', params: {
        'user_id': userId,
        'amount': amount,
      });

      // إضافة لعمولة المنصة ومحفظة التاجر
      await supabase.from('transactions').insert({
        'from_user': userId,
        'to_user': sellerId,
        'amount': amount,
        'status': 'completed',
        'type': 'purchase'
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  // 2. إشعار المندوب تلقائياً
  Future<void> alertNearestDriver(double lat, double lng, String orderId) async {
    // منطق البحث عن أقرب مندوب في الخريطة
    print("جاري البحث عن أقرب مندوب لتوصيل الطلب $orderId");
  }
}
