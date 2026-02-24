import 'package:supabase_flutter/supabase_flutter.dart';

class AdminDocsService {
  // حفظ بيانات الاتفاق في جدول خاص للآدمين
  static Future<void> saveAgreement({
    required String buyer,
    required String seller,
    required String propertyTitle,
    required String price,
  }) async {
    await Supabase.instance.client.from('admin_agreements').insert({
      'buyer_name': buyer,
      'seller_name': seller,
      'property_info': propertyTitle,
      'final_price': price,
      'timestamp': DateTime.now().toIso8601String(),
      'status': 'verified_by_flex'
    });
  }
}
