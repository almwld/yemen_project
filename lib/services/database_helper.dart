import 'package:supabase_flutter/supabase_flutter.dart';

class DataHelper {
  static final supabase = Supabase.instance.client;

  // جلب رصيد المحفظة الحي
  static Stream<List<Map<String, dynamic>>> getWalletStream() {
    return supabase
        .from('wallets')
        .stream(primaryKey: ['id'])
        .order('created_at');
  }

  // جلب المزادات النشطة مع الروابط الصحيحة للصور
  static Future<List<Map<String, dynamic>>> getActiveAuctions() async {
    final data = await supabase
        .from('auctions')
        .select()
        .eq('status', 'active');
    return data;
  }
}
